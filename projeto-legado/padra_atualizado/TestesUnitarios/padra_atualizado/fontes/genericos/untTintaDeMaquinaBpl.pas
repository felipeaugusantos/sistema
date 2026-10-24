unit untTintaDeMaquinaBpl;

interface

Uses
  Windows,
  Shared.Functions.Faturamento.TintaDeMaquina;

type
  TTintaDeMaquinaBpl = class(TInterfacedObject, ITintaDeMaquina)
  private
    Const
      IMOBILIARIA =
        '_SUV_CIM_REI_CID_SHE_BZI_LKS_LKC_KRE_DAC_SHE_FUT_MZI_KIL_COL_EUC_ADV_MAZ_RSI_ANJ_WEG_'
        + 'ALE_VEL_SAY_HYD_INT_CAL_IQU_LIK_REC_GLO_AJA_REN_ANN_INK_BAU_QUA_CIA_MON_MEG_FAL_GRA_BEL_SHW_MAX_';

      AUTOMOTIVA =
        '_LAZ_SKY_GEN_PPG_ZYN_STA_WAN_WCP_SAL_GLA_DUP_AUT_FAR_GLA_MZA_NEX_BZC_BZA_DOX_STW_AJT_ROB_';

      INDUSTRIAL = '_ADT_MZD_SPA_LEC_';

  public
    function RetornarAutcomTintaDll : THandle;

    function fGetTintaImobiliaria(Const strIdePro : String) : Boolean;
    function fGetTintaAutomotiva(Const strIdePro : String)  : Boolean;
    function fGetTintaIndustrial(Const strIdePro : String)  : Boolean;

    class function New: ITintaDeMaquina;
  end;

implementation

{ TTintaDeMaquinaBpl }




function TTintaDeMaquinaBpl.fGetTintaAutomotiva(
  const strIdePro: String): Boolean;
begin
  Result := Pos(strIdePro, AUTOMOTIVA) > 0;
end;

function TTintaDeMaquinaBpl.fGetTintaImobiliaria(
  const strIdePro: String): Boolean;
begin
  Result := Pos(strIdePro, IMOBILIARIA) > 0;;
end;

function TTintaDeMaquinaBpl.fGetTintaIndustrial(
  const strIdePro: String): Boolean;
begin
  Result := Pos(strIdePro, INDUSTRIAL) > 0;;
end;

class function TTintaDeMaquinaBpl.New: ITintaDeMaquina;
begin
  Result := Self.Create;
end;



function TTintaDeMaquinaBpl.RetornarAutcomTintaDll: THandle;
begin
  Result := 123456;
end;

initialization
  SetObjTintaDeMaquina(TTintaDeMaquinaBpl.New());
end.
