unit untQckRcxRecCredPenCli;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frxClass, frxDMPExport, frxDBSet, DB, UniClientDataSet, Provider,
  Datasnap.DBClient, System.StrUtils;

type
  TfrmQckRcxRecCredPenCli = class(TForm)
    frxReciboB: TfrxReport;
    frxDotMatrixExport1: TfrxDotMatrixExport;
    cdsRecibo: TUniClientDataSet;
    frxDBRecibo: TfrxDBDataset;
    cdsReciboCTR_NUMDUP: TStringField;
    cdsReciboCTR_PARCEL: TStringField;
    cdsReciboCTR_ESPDOC: TStringField;
    cdsReciboCTR_CODCLI: TStringField;
    cdsReciboCTR_CODEMP: TStringField;
    cdsReciboCTR_DTACAD: TDateField;
    cdsReciboCTR_DTAVEN: TDateField;
    cdsReciboCTR_CODVEN: TStringField;
    cdsReciboCTR_VALDUP: TCurrencyField;
    dtsRecibo: TDataSource;
    frxReciboLJ: TfrxReport;
    frxReciboLM: TfrxReport;
    cdsReciboNOMCLIENTE: TStringField;
    cdsReciboCTR_HIST01: TStringField;
    frxReciboT: TfrxReport;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  public
    { Public declarations }
    procedure pGetCreditosCliente(strCodCli: String);
    class procedure pImprimeRcxRecCredPenCli(strCodCli, strNomeForm: String);
  end;

var
  frmQckRcxRecCredPenCli: TfrmQckRcxRecCredPenCli;

implementation

  Uses  untfuncoesSimples, Uni, untCfgRel;

{$R *.dfm}

procedure TfrmQckRcxRecCredPenCli.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  cdsRecibo.Close;
end;

procedure TfrmQckRcxRecCredPenCli.FormCreate(Sender: TObject);
begin
  cdsRecibo.CreateDataSet; 
end;

procedure TfrmQckRcxRecCredPenCli.pGetCreditosCliente(strCodCli: String);

  Function fGetSqlAberto: String;
  Begin
    Result := '';
    Result := Result + ' SELECT ';
    Result := Result + '   CTR_NUMDUP, ';
    Result := Result + '   CTR_CODCLI, ';
    Result := Result + '   CTR_DTACAD, ';
    Result := Result + '   CTR_CODEMP, ';
    Result := Result + '   CTR_DTAVEN, ';
    Result := Result + '   CTR_CODVEN, ';
    Result := Result + '   CTR_VALDUP, ';
    Result := Result + '   CTR_ESPDOC, ';
    Result := Result + '   CTR_PARCEL, ';
    Result := Result + '   CTR_HIST01  ';
    Result := Result + ' FROM CADREC   ';
    Result := Result + ' WHERE ';
    Result := Result + '   CTR_DTAREC IS NULL AND ';
    Result := Result + '   CTR_VALDUP < 0     AND ';
    Result := Result + '   CTR_CODCLI = :CODCLI ';

    If Not fEmptyStr(fCfgSis('POOCRE')) Then
      Result := Result + 'AND IFNULL(CTR_CODPOR,"") <> '+String(fCfgSis('POOCRE')).QuotedString;

  End;

  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);

  cdsRecibo.EmptyDataSet;

  qryAux.SQL.Add(fGetSqlAberto);
  qryAux.ParamByName('CODCLI').AsString := strCodCli;
  qryAux.Open;

  qryAux.First;
  While Not qryAux.Eof Do
  Begin

    cdsRecibo.Append;
    cdsRecibo.FieldByName('CTR_NUMDUP').AsString   := qryAux.FieldByName('CTR_NUMDUP').AsString;
    cdsRecibo.FieldByName('CTR_CODCLI').AsString   := qryAux.FieldByName('CTR_CODCLI').AsString;
    cdsRecibo.FieldByName('CTR_DTACAD').AsDateTime := qryAux.FieldByName('CTR_DTACAD').AsDateTime;
    cdsRecibo.FieldByName('CTR_CODEMP').AsString   := qryAux.FieldByName('CTR_CODEMP').AsString;
    cdsRecibo.FieldByName('CTR_DTAVEN').AsDateTime := qryAux.FieldByName('CTR_DTAVEN').AsDateTime;
    cdsRecibo.FieldByName('CTR_CODVEN').AsString   := qryAux.FieldByName('CTR_CODVEN').AsString;
    cdsRecibo.FieldByName('CTR_VALDUP').AsFloat    := Abs(qryAux.FieldByName('CTR_VALDUP').AsFloat);
    cdsRecibo.FieldByName('CTR_ESPDOC').AsString   := qryAux.FieldByName('CTR_ESPDOC').AsString;
    cdsRecibo.FieldByName('CTR_PARCEL').AsString   := qryAux.FieldByName('CTR_PARCEL').AsString;
    cdsRecibo.FieldByName('NOMCLIENTE').AsString   := fRetNomCliente(cdsRecibo.FieldByName('CTR_CODCLI').AsString);
    cdsRecibo.FieldByName('CTR_HIST01').AsString   := qryAux.FieldByName('CTR_HIST01').AsString;
    cdsRecibo.Post;

    qryAux.Next;
  End;

  qryAux.Close;
  FreeANdNil(qryAux);
End;

class procedure TfrmQckRcxRecCredPenCli.pImprimeRcxRecCredPenCli(
  strCodCli, strNomeForm: String);
  Var
    strNomeFila : String;
    strTipImp   : String;
    qryGenEmp,
    qryCfgRel   : TUniQuery;
    strSQL      : String;
    frxReciboX  : TfrxReport;
    strOpcImp   : String;
begin
  Try
    qryGenEmp := fCriaQuery;
    qryCfgRel := fCriaQuery;
    pCriarFormularios(TfrmQckRcxRecCredPenCli, frmQckRcxRecCredPenCli);

    Try

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  CADEMP.*, ';
      strSQL := strSQL + '  CONCAT(CID_NOMCID, "-",CID_ESTADO) AS CIDADE ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADEMP, ';
      strSQL := strSQL + '  CADCID ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  EMP_CODCID = CID_CODCID AND ';
      strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';
      With qryGenEmp Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        Open;
      End;

      frmQckRcxRecCredPenCli.pGetCreditosCliente(strCodCli);

      strOpcImp := fCfgSis('RECRCX');

      pCarregaConfImpr(qryCfgRel, strNomeForm);
      strNomeFila := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
      strTipImp   := qryCfgRel.FieldByName('REL_IDEIMP').AsString;

      If strTipImp = 'M' Then
      Begin
        If strOpcImp = 'B' Then
          frxReciboX := frmQckRcxRecCredPenCli.frxReciboB
        Else
          frxReciboX := frmQckRcxRecCredPenCli.frxReciboLM;
      End
      Else
      begin
        If strOpcImp = 'B' Then
          frxReciboX := frmQckRcxRecCredPenCli.frxReciboT
        Else
          frxReciboX := frmQckRcxRecCredPenCli.frxReciboLJ;
      end;


      frxReciboX.Script.Variables['EMPRESA']  := qryGenEmp.Fieldbyname('EMP_NOMEMP').AsString;
      frxReciboX.Script.Variables['TELEFONE'] := qryGenEmp.Fieldbyname('EMP_FONE01').AsString;
      frxReciboX.Script.Variables['ENDERECO'] := qryGenEmp.Fieldbyname('EMP_ENDERE').AsString +
                                                                ','  + qryGenEmp.Fieldbyname('EMP_ENDNUM').AsString +
                                                                '  ' + qryGenEmp.Fieldbyname('EMP_ENDCMP').AsString +
                                                                 '-' + qryGenEmp.Fieldbyname('EMP_BAIRRO').AsString;
      frxReciboX.Script.Variables['CIDADE']   := qryGenEmp.Fieldbyname('CIDADE').AsString;
      frxReciboX.Script.Variables['DATA']     := qryGenEmp.Fieldbyname('CIDADE').AsString + ', ' + FormatDateTime('dd/MM/yyyy',VS_Date);

      If fEmptyStr(strNomeFila) Then
        frxReciboX.PrintOptions.ShowDialog := True
      Else
        frxReciboX.PrintOptions.Printer := AnsiReplaceText(strNomeFila,'\\' + fRetNomeRede + '\','');

      If frxReciboX.PrepareReport Then
      Begin
        frxReciboX.PrintOptions.Copies := fCfgSis('VIAREC', varInteger);
        pPrintReport(strNomeForm, frmQckRcxRecCredPenCli.Caption, strNomeFila, frxReciboX);
      End;
    Finally
      FreeAndNil(qryGenEmp);
      FreeAndNil(qryCfgRel);
      pFreeAndNil(frmQckRcxRecCredPenCli);
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pImprimeRcxRecCredPenCli]');
    End;
  End;
end;

end.
