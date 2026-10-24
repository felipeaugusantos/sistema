unit untEntPreNotaEntradaMotivoLib;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, Uni, untPaiConfirma, MemoFocus, frxClass, frxExportCSVTestabilidade;

type
  TTipoMotivo = (tmPreNota, tmEntrada);

  TfrmEntPreNotaEntradaMotivoLib = class(TfrmPaiConfirma)
    mmoMotivo: TMemoFocus;
    procedure mmoMotivoKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    // Query de Log Liberação da Pre Nota Entrada
    qryLibPrn : TUniQuery;

    FdtaDtaEnt : TDate;
    FstrNumDoc,
    FstrEspDoc,
    FstrSerie,
    FstrCodFor,
    FstrCodEmp,
    FstrTipoFc,
    FstrCodOpe,
    FstrDiverge : String;
    FtpmTipo: TTipoMotivo;
    procedure pGravaLibPrn;
    function fGetSqlLiberacao: String;
  public
    Class Function fRegistraMotivo(dtaDtaEnt : TDate; strNumDoc, strEspDoc, strSerie, strCodFor, strCodEmp, strTipoFc, strCodOpe, strDiverge : String; tpmTipo: TTipoMotivo = tmPreNota):Boolean;
  end;

implementation

uses untFuncoesSimples, untPai, untModulo;

{$R *.dfm}

procedure TfrmEntPreNotaEntradaMotivoLib.pGravaLibPrn;
Var
  strSql : String;
begin
  try
    qryLibPrn := TUniQuery.Create(Self);
    qryLibPrn.Connection := frmModulo.GetCurrentConnection;

    strSql := fGetSqlLiberacao;

    with qryLibPrn do
    Begin
      Close;
      SQL.Add(strSql);

      ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('LIBPRN', VS_strCodEmp);
      ParamByName('DTAENT').AsDateTime   := FdtaDtaEnt;
      ParamByName('NUMDOC').AsString     := FstrNumDoc;
      ParamByName('ESPDOC').AsString     := FstrEspDoc;
      ParamByName('SERIE_').AsString     := FstrSerie;
      ParamByName('CODFOR').AsString     := FstrCodFor;
      ParamByName('CODEMP').AsString     := FstrCodEmp;
      ParamByName('TIP_FC').AsString     := FstrTipoFc;
      ParamByName('DTALIB').AsDateTime   := VS_Date;
      ParamByName('HRALIB').AsDateTime   := fTime();
      ParamByName('CODOPE').AsString     := FstrCodOpe;
      ParamByName('MOTIVO').AsString     := mmoMotivo.Texto;
      ParamByName('DIVERG').AsString     := FstrDiverge;

      ExecSQL;

      Close;
    End;

  Finally
    FreeAndNil(qryLibPrn);
  End;

end;

procedure TfrmEntPreNotaEntradaMotivoLib.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mmoMotivo);
end;

procedure TfrmEntPreNotaEntradaMotivoLib.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(mmoMotivo);

end;

class function TfrmEntPreNotaEntradaMotivoLib.fRegistraMotivo(dtaDtaEnt: TDate;
  strNumDoc, strEspDoc, strSerie, strCodFor, strCodEmp, strTipoFc,
  strCodOpe, strDiverge: String; tpmTipo: TTipoMotivo = tmPreNota): Boolean;
  var
    frmEntPreNotaEntradaMotivoLib: TfrmEntPreNotaEntradaMotivoLib;
begin
  pCriarFormularios(TfrmEntPreNotaEntradaMotivoLib, frmEntPreNotaEntradaMotivoLib);
  With frmEntPreNotaEntradaMotivoLib Do
  Begin
    mmoMotivo.Lines.Clear;
    FtpmTipo   := tpmTipo;
    FdtaDtaEnt := dtaDtaEnt;
    FstrNumDoc := strNumDoc;
    FstrEspDoc := strEspDoc;
    FstrSerie  := strSerie;
    FstrCodFor := strCodFor;
    FstrCodEmp := strCodEmp;
    FstrTipoFc := strTipoFc;
    FstrCodOpe := strCodOpe;
    FstrDiverge:= strDiverge;

    If (ShowModal = MrOk) Then
    Begin
      pGravaLibPrn;
      Result := True;
    End
    Else
      Result := False;
  End;
  pFreeAndNil(frmEntPreNotaEntradaMotivoLib);

end;

procedure TfrmEntPreNotaEntradaMotivoLib.mmoMotivoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If CharInSet(key, ['a'..'z']) Then
    key := UpperCase(key)[1];
end;

function TfrmEntPreNotaEntradaMotivoLib.fGetSqlLiberacao: String;
Begin
  case FtpmTipo of
    tmPreNota:
    Begin
      Result:= ' INSERT INTO LIBPRN ( ';
      Result:= Result+ 'AUTOINCREM,';
      Result:= Result+ 'LPN_DTAENT,';
      Result:= Result+ 'LPN_NUMDOC,';
      Result:= Result+ 'LPN_ESPDOC,';
      Result:= Result+ 'LPN_SERIE_,';
      Result:= Result+ 'LPN_CODFOR,';
      Result:= Result+ 'LPN_CODEMP,';
      Result:= Result+ 'LPN_TIP_FC,';
      Result:= Result+ 'LPN_DTALIB,';
      Result:= Result+ 'LPN_HRALIB,';
      Result:= Result+ 'LPN_CODOPE,';
      Result:= Result+ 'LPN_MOTIVO,';
      Result:= Result+ 'LPN_DIVERG ';
      Result:= Result+ ') VALUES ';
    End;
    tmEntrada:
    Begin
      Result:= ' INSERT INTO LIBENT ( ';
      Result:= Result+ 'AUTOINCREM,';
      Result:= Result+ 'ENT_DTAENT,';
      Result:= Result+ 'ENT_NUMDOC,';
      Result:= Result+ 'ENT_ESPDOC,';
      Result:= Result+ 'ENT_SERIE_,';
      Result:= Result+ 'ENT_CODFOR,';
      Result:= Result+ 'ENT_CODEMP,';
      Result:= Result+ 'ENT_TIP_FC,';
      Result:= Result+ 'ENT_DTALIB,';
      Result:= Result+ 'ENT_HRALIB,';
      Result:= Result+ 'ENT_CODOPE,';
      Result:= Result+ 'ENT_MOTIVO,';
      Result:= Result+ 'ENT_DIVERG ';
      Result:= Result+ ') VALUES ';
    End;
  end;

  Result:= Result+ '( ';
  Result:= Result+ ':AUTOINCREM,';
  Result:= Result+ ':DTAENT,';
  Result:= Result+ ':NUMDOC,';
  Result:= Result+ ':ESPDOC,';
  Result:= Result+ ':SERIE_,';
  Result:= Result+ ':CODFOR,';
  Result:= Result+ ':CODEMP,';
  Result:= Result+ ':TIP_FC,';
  Result:= Result+ ':DTALIB,';
  Result:= Result+ ':HRALIB,';
  Result:= Result+ ':CODOPE,';
  Result:= Result+ ':MOTIVO,';
  Result:= Result+ ':DIVERG ';
  Result:= Result+ ') ';
End;

end.
