defmodule Hospital.FilesTest do
  use Hospital.DataCase

  alias Hospital.Files

  describe "recipes" do
    alias Hospital.Files.Recipe

    @valid_attrs %{fecha: ~D[2010-04-17], medicamentos: "some medicamentos"}
    @update_attrs %{fecha: ~D[2011-05-18], medicamentos: "some updated medicamentos"}
    @invalid_attrs %{fecha: nil, medicamentos: nil}

    def recipe_fixture(attrs \\ %{}) do
      {:ok, recipe} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Files.create_recipe()

      recipe
    end

    test "list_recipes/0 returns all recipes" do
      recipe = recipe_fixture()
      assert Files.list_recipes() == [recipe]
    end

    test "get_recipe!/1 returns the recipe with given id" do
      recipe = recipe_fixture()
      assert Files.get_recipe!(recipe.id) == recipe
    end

    test "create_recipe/1 with valid data creates a recipe" do
      assert {:ok, %Recipe{} = recipe} = Files.create_recipe(@valid_attrs)
      assert recipe.fecha == ~D[2010-04-17]
      assert recipe.medicamentos == "some medicamentos"
    end

    test "create_recipe/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Files.create_recipe(@invalid_attrs)
    end

    test "update_recipe/2 with valid data updates the recipe" do
      recipe = recipe_fixture()
      assert {:ok, %Recipe{} = recipe} = Files.update_recipe(recipe, @update_attrs)
      assert recipe.fecha == ~D[2011-05-18]
      assert recipe.medicamentos == "some updated medicamentos"
    end

    test "update_recipe/2 with invalid data returns error changeset" do
      recipe = recipe_fixture()
      assert {:error, %Ecto.Changeset{}} = Files.update_recipe(recipe, @invalid_attrs)
      assert recipe == Files.get_recipe!(recipe.id)
    end

    test "delete_recipe/1 deletes the recipe" do
      recipe = recipe_fixture()
      assert {:ok, %Recipe{}} = Files.delete_recipe(recipe)
      assert_raise Ecto.NoResultsError, fn -> Files.get_recipe!(recipe.id) end
    end

    test "change_recipe/1 returns a recipe changeset" do
      recipe = recipe_fixture()
      assert %Ecto.Changeset{} = Files.change_recipe(recipe)
    end
  end
end
