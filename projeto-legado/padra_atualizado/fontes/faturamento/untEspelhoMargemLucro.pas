unit untEspelhoMargemLucro;

interface

uses Uni, UniClientDataSet, untFuncoesSimples, System.SysUtils, untIEspelhoMargemLucro, System.Math;

type
  TEspelhoMargemLucro = class(TInterfacedObject, IEspelhoMargemLucro)
  private
    FCdsItensMargem: TUniClientDataSet;
    FAutIncMovDet: String;
    FPosicaoMatrizItens: Integer;

    procedure pAdicionarItensEntrada(qryEspelho: TUniQuery);
    procedure pAdicionarItensSaida(qryEspelho: TUniQuery);
    function fValidarCampoFlutuante(AValue: Double): Double;
  public
    function SetCdsItensMargem(AValue: TUniClientDataSet): IEspelhoMargemLucro;
    function SetAutIncMovDet(AValue: String): IEspelhoMargemLucro;
    function SetPosicaoMatrizItens(AValue: Integer): IEspelhoMargemLucro;

    procedure pGravarEspelhoMargemLucro;

    constructor Create;
    destructor Destroy; override;

    class function New(): IEspelhoMargemLucro;
  end;

implementation

{ TEspelhoMargemLucro }

constructor TEspelhoMargemLucro.Create;
begin

end;

destructor TEspelhoMargemLucro.Destroy;
begin

  inherited;
end;

class function TEspelhoMargemLucro.New: IEspelhoMargemLucro;
begin
  Result:= Self.Create;
end;

procedure TEspelhoMargemLucro.pAdicionarItensEntrada(qryEspelho: TUniQuery);
begin
  With qryEspelho Do
  Begin
    FieldByName('ENT_ITE_CLAFIS').AsString        := FCdsItensMargem.FieldByName('ITE_CLAFIS').AsString;
    FieldByName('ENT_ITE_PD_OR_ENT_FU').AsBoolean := FCdsItensMargem.FieldByName('PED_ORC_ENT_FUT').AsBoolean;
    FieldByName('ENT_ITE_IMPFED').AsFloat         := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_IMPFED').AsFloat);
    FieldByName('ENT_ITE_PREMED').AsFloat         := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_PREMED').AsFloat);
    FieldByName('ENT_ITE_CALCST_MARG').AsBoolean  := FCdsItensMargem.FieldByName('ITE_CALCST_MARGEM').AsBoolean;
    FieldByName('ENT_ITE_UNIORI').AsFloat         := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_UNIORI').AsFloat);
    FieldByName('ENT_ITE_UNITAR').AsFloat         := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_UNITAR').AsFloat);
    FieldByName('ENT_ITE_ICMCAL').AsFloat         := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_ICMCAL').AsFloat);
    FieldByName('ENT_ITE_BASICM').AsFloat         := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_BASICM').AsFloat);
    FieldByName('ENT_ITE_VDIFAL').AsFloat         := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_VDIFAL').AsFloat);
    FieldByName('ENT_ITE_VALFCP').AsFloat         := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_VALFCP').AsFloat);
    FieldByName('ENT_ITE_DESOPE').AsFloat         := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_DESOPE').AsFloat);
    FieldByName('ENT_ITE_DESOPE_CLI').AsFloat     := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_DESOPE_CLI').AsFloat);
    FieldByName('ENT_ITE_COMTBL').AsFloat         := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_COMTBL').AsFloat);
    FieldByName('ENT_ITE_CUSPRA').AsFloat         := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_CUSPRA').AsFloat);
    FieldByName('ENT_ITE_CUSITE').AsFloat         := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_CUSITE').AsFloat);
    FieldByName('ENT_ITE_OUTVAL').AsFloat         := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_OUTVAL').AsFloat);
    FieldByName('ENT_ITE_PREULT').AsFloat         := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_PREULT').AsFloat);
    FieldByName('ENT_ITE_IMPULT').AsFloat         := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_IMPULT').AsFloat);
    FieldByName('ENT_ITE_VAL_ST').AsFloat         := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_VAL_ST').AsFloat);
    FieldByName('ENT_ITE_ICMPAV_MARG').AsFloat    := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_ICMPAV_MARGEM').AsFloat);
    FieldByName('ENT_ITE_VALOR_CAT17').AsFloat    := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_CUSCAT').AsFloat);
    FieldByName('ENT_ITE_ADICM_MKPMAR').AsFloat   := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_ALQDIFICM_MKPMAR4').AsFloat);
    FieldByName('ENT_ITE_CM_PD_MAR').AsFloat      := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_CALMAR_PREDIN_MAR').AsFloat);
    FieldByName('ENT_ITE_CM_PD_MARLIQ').AsFloat   := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_CALMAR_PREDIN_MARLIQ').AsFloat);
    FieldByName('ENT_ITE_ADICM_MARMED').AsFloat   := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_ALQDIFICM_MARMED').AsFloat);
    FieldByName('ENT_ITE_ADICM_MARIMP').AsFloat   := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_ALQDIFICM_MARIMP').AsFloat);
    FieldByName('ENT_ITE_ADICM_MARITE').AsFloat   := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_ALQDIFICM_MARITE').AsFloat);
    FieldByName('ENT_ITE_ADICM_MARLUC').AsFloat   := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_ALQDIFICM_MARLUC').AsFloat);
    FieldByName('ENT_ITE_MARMIN').AsFloat         := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_MARMIN').AsFloat);
    FieldByName('ENT_ITE_CLC_PRE_IDE').AsBoolean  := (FCdsItensMargem.FindField('ITE_PREIDE') <> Nil);
    FieldByName('ENT_ITE_VLR_PRE_IDE').AsFloat    := IIF(FCdsItensMargem.FindField('ITE_PREIDE') <> Nil, fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_PREIDE').AsFloat), 0);
    FieldByName('ENT_ITE_ICM_PREIDE').AsFloat     := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_ICMSAI_PREIDE').AsFloat);
  End;
end;

procedure TEspelhoMargemLucro.pAdicionarItensSaida(qryEspelho: TUniQuery);
begin
  With qryEspelho Do
  Begin
    FieldByName('SAI_ITE_IDENUM_MAR').AsFloat   := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_IDENUM_MAR').AsFloat);
    FieldByName('SAI_ITE_PRANUM_MAR').AsFloat   := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_PRANUM_MAR').AsFloat);
    FieldByName('SAI_ITE_PRANUM_MAR_S').AsFloat := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_PRANUM_MAR_SDO').AsFloat);
    FieldByName('SAI_ITE_MEDNUM_MAR').AsFloat   := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_MEDNUM_MAR').AsFloat);
    FieldByName('SAI_ITE_IMPNUM_MAR').AsFloat   := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_IMPNUM_MAR').AsFloat);
    FieldByName('SAI_ITE_PRONUM_MAR').AsFloat   := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_PRONUM_MAR').AsFloat);
    FieldByName('SAI_ITE_MARMIN').AsFloat       := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_MARMIN').AsFloat);
    FieldByName('SAI_ITE_CUMAZR').AsFloat       := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_CUMAZR').AsFloat);
    FieldByName('SAI_ITE_MARPRA_PRECU').AsFloat := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_MARPRA_PRECUS').AsFloat);
    FieldByName('SAI_ITE_MARPRO_PRECU').AsFloat := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_MARPRO_PRECUS').AsFloat);
    FieldByName('SAI_ITE_MARPRO_CUSIT').AsFloat := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_MARPRO_CUSITE').AsFloat);
    FieldByName('SAI_ITE_MARPRA_CUSIT').AsFloat := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_MARPRA_CUSITE').AsFloat);
    FieldByName('SAI_ITE_MARBRU_PREME').AsFloat := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_MARBRU_PREMED').AsFloat);
    FieldByName('SAI_ITE_MARLIQ_PREME').AsFloat := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_MARLIQ_PREMED').AsFloat);
    FieldByName('SAI_ITE_MARBRU_PREUL').AsFloat := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_MARBRU_PREULT').AsFloat);
    FieldByName('SAI_ITE_MARLIQ_PREUL').AsFloat := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_MARLIQ_PREULT').AsFloat);
    FieldByName('SAI_ITE_MARBRU_IMPUL').AsFloat := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_MARBRU_IMPULT').AsFloat);
    FieldByName('SAI_ITE_MARLIQ_IMPUL').AsFloat := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_MARLIQ_IMPULT').AsFloat);
    FieldByName('SAI_ITE_PRANUM_MKP').AsFloat   := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_PRANUM_MKP').AsFloat);
    FieldByName('SAI_ITE_PRANUM_MKP_S').AsFloat := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_PRANUM_MKP_SDO').AsFloat);
    FieldByName('SAI_ITE_PRONUM_MKP').AsFloat   := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_PRONUM_MKP').AsFloat);
    FieldByName('SAI_ITE_MEDNUM_MKP').AsFloat   := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_MEDNUM_MKP').AsFloat);
    FieldByName('SAI_ITE_IMPNUM_MKP').AsFloat   := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_IMPNUM_MKP').AsFloat);
    FieldByName('SAI_ITE_MARMED').AsFloat       := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_MARMED').AsFloat);
    FieldByName('SAI_ITE_MARIMP').AsFloat       := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_MARIMP').AsFloat);
    FieldByName('SAI_ITE_MARITE').AsFloat       := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_MARITE').AsFloat);
    FieldByName('SAI_ITE_MARLUC').AsFloat       := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_MARLUC').AsFloat);
    FieldByName('SAI_ITE_MARCAT').AsFloat       := fValidarCampoFlutuante(FCdsItensMargem.FieldByName('ITE_MARCAT').AsFloat);
  End;
end;

procedure TEspelhoMargemLucro.pGravarEspelhoMargemLucro;
Var
  qryEspelho: TUniQuery;
begin
  If Not FCdsItensMargem.Locate('AUTOINCREM', FPosicaoMatrizItens, []) Then
    Exit;

  Try
    qryEspelho := fCriaQuery;

    With qryEspelho Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM ESPELHO_MARGEM_LUCRO WHERE FALSE');
      Open;

      Insert;
      FieldByName('ITE_SEQGER').AsString := FAutIncMovDet;
      pAdicionarItensEntrada(qryEspelho);
      pAdicionarItensSaida(qryEspelho);
      Post;
    End;
  Finally
    FreeAndNil(qryEspelho);
  End;
end;

function TEspelhoMargemLucro.SetAutIncMovDet(
  AValue: String): IEspelhoMargemLucro;
begin
  Result := Self;

  FAutIncMovDet := AValue;
end;

function TEspelhoMargemLucro.SetCdsItensMargem(
  AValue: TUniClientDataSet): IEspelhoMargemLucro;
begin
  Result := Self;

  FCdsItensMargem := AValue;
end;

function TEspelhoMargemLucro.SetPosicaoMatrizItens(
  AValue: Integer): IEspelhoMargemLucro;
begin
  Result := Self;

  FPosicaoMatrizItens := AValue;
end;

function TEspelhoMargemLucro.fValidarCampoFlutuante(AValue: Double): Double;
begin
  Result := 0;

  If IsInfinite(AValue) Then
    Exit;

  If IsNan(AValue) Then
    Exit;

  Result := AValue;
end;

end.
