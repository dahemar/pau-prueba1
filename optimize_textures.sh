#!/bin/bash

# 1. Convierte todas las imágenes .jpg a .webp
echo "Convirtiendo imágenes .jpg a .webp..."

for img in *.jpg; do
    # Convierte cada archivo .jpg a .webp
    cwebp "$img" -q 80 -o "${img%.jpg}.webp"
    echo "Convertido: $img -> ${img%.jpg}.webp"
done

# 2. Actualiza el archivo .gltf con las nuevas rutas de las texturas .webp
echo "Actualizando las rutas de las texturas en el archivo .gltf..."

gltf_file="igualada_split.gltf"
for img in *.webp; do
    # Cambia las rutas de las texturas en el archivo .gltf
    sed -i '' "s|\"uri\": \"$img\"|\"uri\": \"$img\"|g" "$gltf_file"
    echo "Actualizada textura: $img en $gltf_file"
done

# 3. Empaquetar el archivo .gltf con texturas webp a un nuevo .glb optimizado con Draco
echo "Empaquetando el archivo .gltf en .glb optimizado..."

gltf-pipeline -i "$gltf_file" -o igualada_optimized.glb -d --draco.compressionLevel 10

echo "Proceso completado. El archivo optimizado está en igualada_optimized.glb"

