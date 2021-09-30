defmodule NjausteveWeb.Endpoint.CertificationTest do
  use ExUnit.Case, async: false
  import SiteEncrypt.Phoenix.Test

  test "certification" do
    clean_restart(NjausteveWeb.Endpoint)
    cert = get_cert(NjausteveWeb.Endpoint)
    assert cert.domains == ~w/njausteve.com www.njausteve.com reports.njausteve.com/
  end
end
