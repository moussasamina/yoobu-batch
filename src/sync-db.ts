/* Syncroniser la base de donnee Logistic de Youbu à 
l'image de La base de donnee principale wordpress de Yoobu
- Ce programme met tout simplement à jour les commandes , il s'execute regulierement pour mettre à jour la base de donnee Logistic
*/

import { prisma_yb_logistic, prisma_yb_wp } from "./lib/db.js";

async function main() {
  console.log("Syncro.....");
  try {
    const [wp_orders, orders] = await Promise.all([
      prisma_yb_wp.wp_dokan_orders.findMany(),
      prisma_yb_logistic.orders_ord.findMany(),
    ]);

    const mapNewOrders = new Map(
      orders.map((order: any) => [order.ord_id, order])
    );

    const metadata = {
      count_created: 0,
      count_updated: 0,
      created_ids: [{}],
      updated_ids: [{}],
    };

    for (const wpOrder of wp_orders) {
      const existingOrder = mapNewOrders.get(wpOrder.id);

      const addresse = await prisma_yb_wp.wp_wc_order_addresses.findFirst({
        where: {
          order_id: wpOrder.order_id!,
        },
        omit: {},
      });

      // Get Order Items
      const _orderItems =
        await prisma_yb_wp.wp_woocommerce_order_items.findMany({
          where: {
            order_id: wpOrder.order_id as bigint,
          },
        });

      const orderItems = await Promise.all(
        [..._orderItems].map(async (item) => {
          const product_infos =
            await prisma_yb_wp.wp_wc_order_product_lookup.findUnique({
              where: {
                order_item_id: item.order_item_id,
              },
            });

          return {
            ori_itm_id: item.order_item_id,
            ori_itm_count: product_infos?.product_qty,
            ori_itm_product_id: product_infos?.product_id,
            ori_itm_product_name: item.order_item_name,
          };
        })
      );

      if (!existingOrder) {
        metadata["count_created"] += 1;
        metadata["created_ids"].push({
          id: Number(wpOrder?.id),
          order_id: Number(wpOrder.order_id),
        });
        await prisma_yb_logistic.orders_ord.create({
          data: {
            ord_id: wpOrder.id,
            ord_order_id: wpOrder.order_id!,
            ord_seller_id: wpOrder.seller_id!,
            ord_order_status: wpOrder.order_status,
            ord_net_amount: wpOrder.net_amount,
            ord_order_total: wpOrder.order_total,
            ordersitems_ori: {
              connectOrCreate: orderItems.map((item) => ({
                where: {
                  ori_itm_id: item.ori_itm_id,
                },
                create: item,
              })),
            },
            addresse_adr: {
              connectOrCreate: {
                where: {
                  adr_id: wpOrder.id,
                },
                create: {
                  adr_address_1: addresse?.address_1,
                  adr_address_2: addresse?.address_2,
                  adr_address_type: addresse?.address_type,
                  adr_city: addresse?.city,
                  adr_company: addresse?.company,
                  adr_country: addresse?.country,
                  adr_email: addresse?.email,
                  adr_first_name: addresse?.first_name,
                  adr_last_name: addresse?.last_name,
                  adr_id: wpOrder.id,
                  adr_phone: addresse?.phone,
                  adr_state: addresse?.state,
                  adr_postcode: addresse?.postcode,
                },
              },
            },
          },
        });
      } else {
        metadata["count_updated"] += 1;
        metadata["updated_ids"].push({
          id: Number(wpOrder?.id),
          order_id: Number(wpOrder.order_id),
        });
        await prisma_yb_logistic.orders_ord.update({
          where: {
            ord_id: wpOrder.id,
          },
          data: {
            ord_order_id: wpOrder.order_id!,
            ord_seller_id: wpOrder.seller_id!,
            ord_order_status: wpOrder.order_status,
            ord_net_amount: wpOrder.net_amount,
            ord_order_total: wpOrder.order_total,
            ordersitems_ori: {
              connectOrCreate: orderItems.map((item) => ({
                where: {
                  ori_itm_id: item.ori_itm_id,
                },
                create: item,
              })),
            },
            addresse_adr: {
              connectOrCreate: {
                where: {
                  adr_id: wpOrder.id,
                },
                create: {
                  // ...addresse,
                  adr_address_1: addresse?.address_1,
                  adr_address_2: addresse?.address_2,
                  adr_address_type: addresse?.address_type,
                  adr_city: addresse?.city,
                  adr_company: addresse?.company,
                  adr_country: addresse?.country,
                  adr_email: addresse?.email,
                  adr_first_name: addresse?.first_name,
                  adr_last_name: addresse?.last_name,
                  adr_phone: addresse?.phone,
                  adr_state: addresse?.state,
                  adr_postcode: addresse?.postcode,
                },
              },
            },
          },
        });
      }
    }
    console.log("%c Sync with Success", "color: green;font-size: 36px");
    console.log("Total Créé: ", metadata.count_created);
    console.log("Total Modifié: ", metadata.count_updated);
  } catch (error) {
    console.error(error);
    process.exit(1);
  } finally {
    console.log("Fin de syncro");
  }
}

main();
