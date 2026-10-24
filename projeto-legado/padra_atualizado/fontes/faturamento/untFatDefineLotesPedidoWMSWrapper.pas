unit untFatDefineLotesPedidoWMSWrapper;

interface

uses untInterfacedObjectNoCount, untIFatDefineLotesPedidoWMS, SysUtils, Uni,
  Variants;

type
  TFatDefineLotesPedidoWMSWrapper = class(TInterfacedObject, IFatDefineLotesPedidoWMS)
  private
    strAutInc: String; // Autoincrem do FATGOR
    procedure pAtualizaSeparadorPedido(strCodSep: String);
  public
    constructor Create;
    destructor Destroy; override;
    function fDigitaLotesPedidoWMS(strNumDoc,
      strEmpPed, strCodCli, strCodSep, strAutInc, strSepImp,
      strAutIncTinta: String): Boolean; overload;

    function fDigitaLotesPedidoWMS(strNumDoc, strEmpPed, strCodCli,
      strCodIte : String): Boolean; overload;
  end;

implementation

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core, untFuncoesGenerica;
{$ELSE}
  untFatDefineLotesPedidoWMS, untFuncoesSimples;
{$ENDIF}

{ TFatDefineLotesPedidoWMSWrapper }

constructor TFatDefineLotesPedidoWMSWrapper.Create;
begin
  inherited Create;
end;

destructor TFatDefineLotesPedidoWMSWrapper.Destroy;
begin
  inherited Destroy;
end;

{$IFDEF LINUX}
function TFatDefineLotesPedidoWMSWrapper.fDigitaLotesPedidoWMS(strNumDoc, strEmpPed, strCodCli, strCodIte: String): Boolean;
begin
  raise Exception.Create('TFatDefineLotesPedidoWMSWrapper.fDigitaLotesPedidoWMS nao possui implementacao para compilacao linux');
end;
{$ELSE}
function TFatDefineLotesPedidoWMSWrapper.fDigitaLotesPedidoWMS(strNumDoc, strEmpPed, strCodCli, strCodIte: String): Boolean;
begin
  Try
    Try
      pCriarFormularios(TfrmFatDefineLotesPedidoWMS, frmFatDefineLotesPedidoWMS);

      frmFatDefineLotesPedidoWMS.strNumPed := strNumDoc;
      frmFatDefineLotesPedidoWMS.strEmpPed := strEmpPed;
      frmFatDefineLotesPedidoWMS.strCodCli := strCodCli;
      frmFatDefineLotesPedidoWMS.strCodIte := strCodIte;
      frmFatDefineLotesPedidoWMS.blnReimpr := False;

      frmFatDefineLotesPedidoWMS.ShowModal;

      Result := frmFatDefineLotesPedidoWMS.blnConfirma And
                frmFatDefineLotesPedidoWMS.blnSepImp;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '');
      End;
    End;
  Finally
    pFreeAndNil(frmFatDefineLotesPedidoWMS);
  End;
end;
{$ENDIF}

{$IFDEF LINUX}
function TFatDefineLotesPedidoWMSWrapper.fDigitaLotesPedidoWMS(strNumDoc,
  strEmpPed, strCodCli, strCodSep, strAutInc, strSepImp,
  strAutIncTinta: String): Boolean;
begin
  raise Exception.Create('TFatDefineLotesPedidoWMSWrapper.fDigitaLotesPedidoWMS nao possui implementacao para compilacao linux');
end;
{$ELSE}
function TFatDefineLotesPedidoWMSWrapper.fDigitaLotesPedidoWMS(strNumDoc,
  strEmpPed, strCodCli, strCodSep, strAutInc, strSepImp,
  strAutIncTinta: String): Boolean;
begin
  Try
    Try
      Self.strAutInc := strAutInc;

      pCriarFormularios(TfrmFatDefineLotesPedidoWMS, frmFatDefineLotesPedidoWMS);

      frmFatDefineLotesPedidoWMS.strNumPed := strNumDoc;
      frmFatDefineLotesPedidoWMS.strEmpPed := strEmpPed;
      frmFatDefineLotesPedidoWMS.strCodSep := strCodSep;
      frmFatDefineLotesPedidoWMS.strCodCli := strCodCli;
      frmFatDefineLotesPedidoWMS.blnReimpr := (StrToIntDef(strSepImp,0) > 0);
      frmFatDefineLotesPedidoWMS.pAtuSepPed:= pAtualizaSeparadorPedido;

      frmFatDefineLotesPedidoWMS.strAutIncTinta := strAutIncTinta;

      frmFatDefineLotesPedidoWMS.ShowModal;

      Result := frmFatDefineLotesPedidoWMS.blnConfirma And
                frmFatDefineLotesPedidoWMS.blnSepImp;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '');
      End;
    End;
  Finally
    pFreeAndNil(frmFatDefineLotesPedidoWMS);
  End;
end;
{$ENDIF}

procedure TFatDefineLotesPedidoWMSWrapper.pAtualizaSeparadorPedido(
  strCodSep: String);
var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery;

    With qryGen, SQL Do
    Begin
      Clear;

      Add('UPDATE');
      Add('  EXTGOR,');
      Add('  FATGOR ');
      Add('  SET FGO_SEPEXP = :CODSEP    ');
      Add('WHERE FGO_SEQFGO = AUTOINCREM ');
      Add('  AND AUTOINCREM = :AUTINC    ');

      If fEmptyStr(strCodSep) Then
        ParamByName('CODSEP').Value := Null
      Else
        ParamByName('CODSEP').AsString := strCodSep;

      ParamByName('AUTINC').AsString := strAutInc; //informar o autoincrem do fatdor

      ExecSQL;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

end.
