unit untQckCtrDuplicata;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RLPreviewForm, RLParser, RLReport, RLFilters, StrUtils,
  RLDraftFilter, DB, MemDS, DBAccess, Uni, frxClass, frxDBSet, System.MaskUtils;

type
  TfrmQckCtrDuplicata = class(TForm)
    qryRelCTR: TUniQuery;
    qryRelCTRCTR_NUMDUP: TStringField;
    qryRelCTRCTR_PARCEL: TStringField;
    qryRelCTRCTR_ESPDOC: TStringField;
    qryRelCTRCLIENTE: TStringField;
    qryRelCTRCLI_ENDERE: TStringField;
    qryRelCTRCLI_BAIRRO: TStringField;
    qryRelCTRCID_NOMCID: TStringField;
    qryRelCTRCLI_FONE01: TStringField;
    qryRelCTRVENDEDOR: TStringField;
    qryRelCTRCTR_DTACAD: TDateField;
    qryRelCTRCTR_VALDUP: TFloatField;
    qryRelCTRCTR_DESSUJ: TFloatField;
    qryRelCTRCTR_DTAVEN: TDateField;
    qryRelCTRCTR_DESCOB: TFloatField;
    qryRelCTRCTR_NOSNUM: TStringField;
    qryRelCTRPORTADOR: TStringField;
    qryRelCTREVENTO: TStringField;
    qryRelCTRHIST01: TStringField;
    qryRelCTRCTR_HIST02: TStringField;
    qryRelCTRCTR_CODVEL: TStringField;
    qryRelCTRCTR_DTAREC: TDateField;
    qryRelCTRPORBAI: TStringField;
    qryRelCTRCTR_CTABAI: TStringField;
    qryRelCTROPEBAI: TStringField;
    qryRelCTRCTR_SEQBAI: TIntegerField;
    qryRelCTRCTR_VALORI: TFloatField;
    qryRelCTRCTR_VALREC: TFloatField;
    qryRelCTRCTR_DOCBAI: TStringField;
    qryRelCTRCTR_HISBAI: TStringField;
    qryRelCTRCTR_DESCON: TStringField;
    qryRelCTRCLI_CGCCPF: TLongWordField;
    qryRelCTRCLI_C_G_C_: TStringField;
    qryRelCTRPLANOCONTA: TStringField;
    qryRelCTREMP_NOMEMP: TStringField;
    frxDBRelCTR: TfrxDBDataset;
    frxRelCTR: TfrxReport;
  private
    { Private declarations }
    procedure pVerificaImpressao(strNomForm: String);
    function fLoadReport : Boolean;
  public
    { Public declarations }
    procedure ImprimeDup(strNumDup, strCodEmp, strNomForm: String);
  end;

var
  frmQckCtrDuplicata: TfrmQckCtrDuplicata;
  strNomImp,
  strTipImp : String;

implementation

uses untFuncoesSimples, untFuncoesGenerica;

{$R *.dfm}

procedure TfrmQckCtrDuplicata.ImprimeDup(strNumDup, strCodEmp, strNomForm: String);
  Var
    strSQL: String;
    intOpcao : Integer;
begin
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CTR_NUMDUP, ';
  strSQL := strSQL + '  CTR_PARCEL, ';
  strSQL := strSQL + '  CTR_ESPDOC, ';
  strSQL := strSQL + '  CONCAT(CTR_CODCLI, " - ", CLI_NOMCLI) AS CLIENTE, ';
  strSQL := strSQL + '  IF(CLI_ENDCOB = "" OR CLI_ENDCOB IS NULL, CLI_ENDERE, CLI_ENDCOB) AS CLI_ENDERE, ';
  strSQL := strSQL + '  IF(CLI_BAICOB = "" OR CLI_BAICOB IS NULL, CLI_BAIRRO, CLI_BAICOB) AS CLI_BAIRRO, ';
  strSQL := strSQL + '  CID_NOMCID, ';
  strSQL := strSQL + '  CLI_FONE01, ';
  strSQL := strSQL + '  CONCAT(CTR_CODVEN, " - ",  V.OPE_NOMOPE) AS VENDEDOR, ';
  strSQL := strSQL + '  CTR_DTACAD, ';
  strSQL := strSQL + '  CTR_VALDUP, ';
  strSQL := strSQL + '  CTR_DESSUJ, ';
  strSQL := strSQL + '  CTR_DTAVEN, ';
  strSQL := strSQL + '  CTR_DESCOB, ';
  strSQL := strSQL + '  CTR_NOSNUM, ';
  strSQL := strSQL + '  CONCAT(CTR_CODPOR, " - ", P.POR_NOMPOR) AS PORTADOR, ';
  strSQL := strSQL + '  CONCAT(CTR_CODEVE, " - ", EVE_DESEVE) AS EVENTO, ';
  strSQL := strSQL + '  REPLACE(CAST(IFNULL(CTR_HIST01, "") AS CHAR(255)), ''<<csq>>'', ''\r'') AS HIST01, ';
  strSQL := strSQL + '  CTR_HIST02, ';
  strSQL := strSQL + '  CTR_CODVEL, ';
  strSQL := strSQL + '  CTR_DTAREC, ';
  strSQL := strSQL + '  CONCAT(CTR_PORBAI, " - ", B.POR_NOMPOR) AS PORBAI, ';
  strSQL := strSQL + '  CTR_CTABAI, ';
  strSQL := strSQL + '  CONCAT(CTR_OPEBAI, " - ", O.OPE_NOMOPE) AS OPEBAI, ';
  strSQL := strSQL + '  CTR_SEQBAI, ';
  strSQL := strSQL + '  CTR_VALORI, ';
  strSQL := strSQL + '  CTR_VALREC, ';
  strSQL := strSQL + '  CTR_DOCBAI, ';
  strSQL := strSQL + '  CTR_HISBAI, ';
  strSQL := strSQL + '  CTR_DESCON, ';
  strSQL := strSQL + '  CLI_CGCCPF, ';
  strSQL := strSQL + '  CLI_C_G_C_, ';
  strSQL := strSQL + '  CONCAT(CTR_CTABAI, " - ", C.CTA_DESCTA) PLANOCONTA, ';
  strSQL := strSQL + '  EMP_NOMEMP ';
  strSQL := strSQL + '  FROM ';
  strSQL := strSQL + '  CADREC ';
  strSQL := strSQL + '  JOIN CADCLI ON CTR_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + '  LEFT JOIN CADPOR P ON CTR_CODPOR = P.POR_CODPOR ';
  strSQL := strSQL + '  LEFT JOIN CADPOR B ON CTR_PORBAI = B.POR_CODPOR ';
  strSQL := strSQL + '  LEFT JOIN CADEVE   ON CTR_CODEVE = EVE_CODEVE ';
  strSQL := strSQL + '  LEFT JOIN CADCID   ON CID_CODCID = IF(CLI_CIDCOB = "" OR CLI_CIDCOB IS NULL, CLI_CODCID, CLI_CIDCOB) ';
  strSQL := strSQL + '  LEFT JOIN CADEMP E ON EMP_CODEMP = CTR_CODEMP ';
  strSQL := strSQL + '  LEFT JOIN CADOPE O ON CTR_OPEBAI = O.OPE_CODOPE ';
  strSQL := strSQL + '  LEFT JOIN CADOPE V ON CTR_CODVEN = V.OPE_CODOPE ';
  strSQL := strSQL + '  LEFT JOIN CADCTA C  ON CTR_CTABAI = CTA_CODCTA ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CADREC.AUTOINCREM = :AUTOIN AND ';
  strSQL := strSQL + '  CTR_CODEMP = :CODEMP';

  With qryRelCTR Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('AUTOIN').AsString := strNumDup;
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;
  end;

  try
    If fMensagem('','Opção:',['&Vídeo','&Impressora'])= 1 Then
      intOpcao := 1
    Else
      intOpcao := 2;

    fLoadReport;

    If intOpcao = 2 Then
    Begin
      pVerificaImpressao(strNomForm);
      If Not fEmptyStr(strNomImp) Then
      Begin
        frxRelCTR.PrintOptions.ShowDialog := False;
        frxRelCTR.PrintOptions.Printer := AnsiReplaceText(strNomImp, '\\' + fRetNomeRede + '\', '');
      End;
    End;

    frxRelCTR.Script.Variables['DATAHORA'] := FormatDateTime('dd/mm/YYYY hh:mm:ss', fRetDataServidor + fRetHoraServidor);
    frxRelCTR.Script.Variables['NOMEFORM'] := '[frmCadCtaReceber]';
    frxRelCTR.Script.Variables['FONE01']   := fFormataFone(qryRelCTRCLI_FONE01.asString);
    TfrxMemoView(frxRelCTR.FindObject('frxMemoEmpresa')).Text := qryRelCTREMP_NOMEMP.asString;

    frxRelCTR.Script.Variables['CGCCPF'] :=  IIF((qryRelCTRCLI_CGCCPF.asString = '1'),FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_G_C_), qryRelCTRCLI_C_G_C_.AsString),
                                                                                      FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_P_F_), qryRelCTRCLI_C_G_C_.AsString));
    frxRelCTR.Script.Variables['DUPDESCONTADA'] := IIF(SameText(qryRelCTR.FieldByName('CTR_DESCON').AsString,'S'),'SIM','NÃO');
    frxRelCTR.Script.Variables['TIPOBAIXA'] :=  IIF((qryRelCTR.FieldByName('CTR_SEQBAI').AsInteger <= 0),'BAIXA TOTAL','BAIXA PARCIAL');
    frxRelCTR.Script.Variables['JUROSAODIA'] := FormatFloat('#,##0.00',(qryRelCTR.FieldByName('CTR_VALDUP').AsFloat * fCfgSis('TAXDIA', varDouble) / 100));

    If Assigned(frxRelCTR.FindObject('ChildBaixa')) Then
    frxRelCTR.FindObject('ChildBaixa').Visible := IIF(((qryRelCTR.FieldByName('CTR_VALREC').AsFloat > 0) Or (qryRelCTR.FieldByName('CTR_VALREC').AsFloat < 0)),True,False);


    If frxRelCTR.PrepareReport Then
      If intOpcao = 1 Then
        pPreviewReport(Self.Name, Self.Caption, frxRelCTR)
      else
        pPrintReport(Self.Name, Self.Caption, strNomImp, frxRelCTR);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[Erro ao Imprimir Duplicata]');
    End;
  end;

End;

procedure TfrmQckCtrDuplicata.pVerificaImpressao(strNomForm: String);
  var
    qryCfgRel: TUniQuery;
Begin

  qryCfgRel := fCriaQuery;

  pCarregaConfImpr(qryCfgRel, strNomForm);

  strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
  strTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
  fPreImpressao(qryCfgRel, strNomImp, strTipImp, False);
  FreeAndNil(qryCfgRel);

End;

function TfrmQckCtrDuplicata.fLoadReport : Boolean;
  Var
   mmsLoad: TStream;
   qryLayImp: TUniQuery;
Begin
  Result := False;

  qryLayImp := fCriaQuery(nil);

  Try
    With qryLayImp, SQL Do
    Begin
      Close;
      Clear;
      Add('SELECT * FROM ');
      Add('  LAYIMP');
      Add('WHERE');
      Add('  LAY_TIPLAY = :TIPLAY AND  ');
      Add('  LAY_CODEMP = :CODEMP AND  ');
      Add('  LAY_CODLAY = :CODLAY      ');

      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('CODLAY').AsString := 'DUPCTR';

      If(strTipImp = 'M') Then
        ParamByName('TIPLAY').AsString := 'M'
      Else
        ParamByName('TIPLAY').AsString := 'L';

      Add('ORDER BY');
      Add('  LAY_DTAALT DESC,');
      Add('  LAY_HORALT DESC ');
      Add('LIMIT 1');
      Open;

      If Not IsEmpty Then
      Begin
        Result := True;
        mmsLoad := CreateBlobStream(FieldByName('LAY_RELFR3'), bmRead);

        frxRelCTR.LoadFromStream(mmsLoad);
        frxRelCTR.Variables.Clear;
      End;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fLoadReport]');
    End;
  End;

  FreeAndNil(qryLayImp);
End;

end.
