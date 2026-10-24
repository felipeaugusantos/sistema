unit TestShared.Functions.Faturamento.TintaDeMaquina;

interface

Uses
  untTintaDeMaquinaBpl, TestFramework, Shared.Functions.Faturamento.TintaDeMaquina;


type
  TSharedFunctionsTintaDeMaquina = class(TTestCase)
  Private
    Const
      IMOBILIARIA =
        '_SUV_CIM_REI_CID_SHE_BZI_LKS_LKC_KRE_DAC_SHE_FUT_MZI_KIL_COL_EUC_ADV_MAZ_RSI_ANJ_WEG_'
        + 'ALE_VEL_SAY_HYD_INT_CAL_IQU_LIK_REC_GLO_AJA_REN_ANN_INK_BAU_QUA_CIA_MON_MEG_FAL_GRA_BEL_SHW_MAX_';

      AUTOMOTIVA =
        '_LAZ_SKY_GEN_PPG_ZYN_STA_WAN_WCP_SAL_GLA_DUP_AUT_FAR_GLA_MZA_NEX_BZC_BZA_DOX_STW_AJT_ROB_';

      INDUSTRIAL = '_ADT_MZD_SPA_LEC_';
  Published
    procedure TestRetornarAutcomTintaDll_false;
    procedure TestRetornarAutcomTintaDll_True;

    procedure TestfGetTintaAutomotiva;
    procedure TestfGetTintaAutomotiva_False_Imobiliaria;
    procedure TestfGetTintaAutomotiva_False_Industrial;

    procedure TestfGetTintaImobiliaria;
    procedure TestfGetTintaImobiliaria_False_Industrial;
    procedure TestfGetTintaImobiliaria_False_Automotiva;

    procedure TestfGetTintaIndustrial;
    procedure TestfGetTintaIndustrial_False_Automotiva;
    procedure TestfGetTintaIndustrial_False_Imobiliaria;

  Public
    procedure SetUp; override;
    procedure TearDown; override;
  end;

implementation

{ TSharedFunctionsTintaDeMaquina }

procedure TSharedFunctionsTintaDeMaquina.SetUp;
begin
  inherited;

end;

procedure TSharedFunctionsTintaDeMaquina.TearDown;
begin
  inherited;

end;

procedure TSharedFunctionsTintaDeMaquina.TestfGetTintaAutomotiva;
var
  ReturnValue: Boolean;
begin
  ReturnValue :=  TTintaDeMaquinaBpl.New.fGetTintaAutomotiva(AUTOMOTIVA);

  CheckTrue(ReturnValue);
end;

procedure TSharedFunctionsTintaDeMaquina.TestfGetTintaAutomotiva_False_Imobiliaria;
var
  ReturnValue: Boolean;
begin
  ReturnValue :=  TTintaDeMaquinaBpl.New.fGetTintaAutomotiva(IMOBILIARIA);

  CheckFalse(ReturnValue);
end;

procedure TSharedFunctionsTintaDeMaquina.TestfGetTintaAutomotiva_False_Industrial;
var
  ReturnValue: Boolean;
begin
  ReturnValue :=  TTintaDeMaquinaBpl.New.fGetTintaAutomotiva(INDUSTRIAL);

  CheckFalse(ReturnValue);
end;

procedure TSharedFunctionsTintaDeMaquina.TestfGetTintaImobiliaria;
var
  ReturnValue: Boolean;
begin
  ReturnValue :=  TTintaDeMaquinaBpl.New.fGetTintaImobiliaria(IMOBILIARIA);

  CheckTrue(ReturnValue);
end;

procedure TSharedFunctionsTintaDeMaquina.TestfGetTintaImobiliaria_False_Automotiva;
var
  ReturnValue: Boolean;
begin
  ReturnValue :=  TTintaDeMaquinaBpl.New.fGetTintaImobiliaria(AUTOMOTIVA);

  CheckFalse(ReturnValue);

end;

procedure TSharedFunctionsTintaDeMaquina.TestfGetTintaImobiliaria_False_Industrial;
var
  ReturnValue: Boolean;
begin
  ReturnValue :=  TTintaDeMaquinaBpl.New.fGetTintaImobiliaria(INDUSTRIAL);

  CheckFalse(ReturnValue);

end;

procedure TSharedFunctionsTintaDeMaquina.TestfGetTintaIndustrial;
var
  ReturnValue: Boolean;
begin
  ReturnValue :=  TTintaDeMaquinaBpl.New.fGetTintaIndustrial(INDUSTRIAL);

  CheckTrue(ReturnValue);
end;

procedure TSharedFunctionsTintaDeMaquina.TestfGetTintaIndustrial_False_Automotiva;
var
  ReturnValue: Boolean;
begin
  ReturnValue :=  TTintaDeMaquinaBpl.New.fGetTintaIndustrial(AUTOMOTIVA);

  CheckFalse(ReturnValue);

end;

procedure TSharedFunctionsTintaDeMaquina.TestfGetTintaIndustrial_False_Imobiliaria;
var
  ReturnValue: Boolean;
begin
  ReturnValue :=  TTintaDeMaquinaBpl.New.fGetTintaIndustrial(IMOBILIARIA);

  CheckFalse(ReturnValue);
end;

procedure TSharedFunctionsTintaDeMaquina.TestRetornarAutcomTintaDll_false;
var
  ReturnValue: Boolean;
begin
  ReturnValue := (TTintaDeMaquinaBpl.New.RetornarAutcomTintaDll = 0);

  CheckFalse(ReturnValue);
end;

procedure TSharedFunctionsTintaDeMaquina.TestRetornarAutcomTintaDll_True;
var
  ReturnValue: Boolean;
begin
  ReturnValue :=  TTintaDeMaquinaBpl.New.RetornarAutcomTintaDll > 0;

  CheckTrue(ReturnValue);
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TSharedFunctionsTintaDeMaquina.Suite);
end.
