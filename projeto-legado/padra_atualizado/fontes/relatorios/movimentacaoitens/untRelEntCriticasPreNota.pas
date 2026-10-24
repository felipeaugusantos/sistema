unit untRelEntCriticasPreNota;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF,
  RLFilters, RLDraftFilter, AppEvnts, Menus, StdCtrls, EditFocus, QColorLabel,
  ExtCtrls, BitBtnLockedIncrem, Buttons, StrUtils, UniClientDataSet, Vcl.Mask,
  MaskEditFocus, frxExportCSVTestabilidade, Uni, Data.DB, frxDMPClass;

type
  TfrmRelEntCriticasPreNota = class(TfrmPaiRelatorio)
    rdgOrientacao: TRadioGroup;
    frxdbCriticas: TfrxDBDataset;
    frxDBCadastro: TfrxDBDataset;
    frxReportM: TfrxReport;
    frxReportJ: TfrxReport;
    grpDadosNE: TGroupBox;
    Label6: TLabel;
    lblEspecie: TLabel;
    lblSerie: TLabel;
    lblEmpresaNE: TLabel;
    Label8: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    edtDocumento: TEditFocus;
    edtEspecie: TEditFocus;
    edtSerie: TEditFocus;
    edtCodEmpresaNE: TEditFocus;
    edtDesEmpresaNE: TEditFocus;
    edtForNot: TEditFocus;
    edtDesForNot: TEditFocus;
    mskDtaEntIni: TMaskEditFocus;
    mskDtaEntFin: TMaskEditFocus;
    frxReportJP: TfrxReport;
    procedure btnImprimirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure edtForNotExit(Sender: TObject);
    procedure edtForNotKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaNEExit(Sender: TObject);
    procedure edtCodEmpresaNEKeyPress(Sender: TObject; var Key: Char);
  private
    qryCriCad: TUniQuery;
    qryConsulta: TUniQuery;
    blnReimpressao: Boolean;
    FstlPedidos: TStringList;
    FstrCompradores: String;
    procedure pSetstlPedidos(const Value: TStringList);
    { Private declarations }
  public
    { Public declarations }
    strNotEle,
    strCodFor : String;
    cdsCriCad: TUniClientDataSet;
    procedure pPreparaReimpressaoCritica;
    function fRetCompradores: String;
    procedure pPreparaQryReimpressao;
    property stlPedidos: TStringList read FstlPedidos write pSetstlPedidos;
  end;

var
  frmRelEntCriticasPreNota: TfrmRelEntCriticasPreNota;

implementation

uses untFuncoesSimples, untCfgRel, untTypesSistema, untConsultas,
  untFuncoesConsulta;

{$R *.dfm}

procedure TfrmRelEntCriticasPreNota.btnImprimirClick(Sender: TObject);
Var
  strNomFil: String;
  frxReport: TfrxReport;
  strTipImp: String;
begin
  frxReport := nil;
  inherited;

  If blnImprime Then
  Begin
    pnlInfo.Caption := 'Gerando Relatório...';
    pnlInfo.Repaint;
    If blnReimpressao Then
    Begin
      pPreparaQryReimpressao;
      qryConsulta.Open;
      If qryConsulta.IsEmpty Then
      Begin
        fMensagem('', 'Não há dados para ser impresso.', ['&OK']);
        Exit;
      End;
      frxDBCadastro.DataSet := qryCriCad;
      frxdbCriticas.DataSet := qryConsulta;
    end
    Else
      frxDBCadastro.DataSet := cdsCriCad;

    Application.ProcessMessages;

    If fEmptyStr(strFilRel) Then
      strFilRel := Self.Name;

    Try

      pCarregaConfImprRel(strFilRel, strNomFil, strTipImp, '', False);

      If rdgOrientacao.ItemIndex = 1 Then
        strTipImp := 'J';

      If strTipImp = 'M' Then
      Begin
        If rdgOrientacao.ItemIndex = 0 Then
          frxReport := frxReportM
      End Else
      Begin
        If rdgOrientacao.ItemIndex = 0 Then
          frxReport := frxReportJ
        Else
          frxReport := frxReportJP;

        TfrxMemoView(frxReport.FindObject('mmoDetalhe')).Highlight.Color := fCfgSis('CORZEB');
        TfrxMemoView(frxReport.FindObject('mmoDetalhe2')).Highlight.Color := fCfgSis('CORZEB');

      End;

      TfrxMemoView(frxReport.FindObject('mmoQtdPed')).DisplayFormat.FormatStr := '%2.' + IntToStr(fCfgSis('DEQTPC', varInteger)) + 'n';
      TfrxMemoView(frxReport.FindObject('mmoQtdNfe')).DisplayFormat.FormatStr := '%2.' + IntToStr(fCfgSis('DEQTPC', varInteger)) + 'n';

      frxReport.PrintOptions.Printer := AnsiReplaceStr(strNomFil,'\\' + fRetNomeRede + '\','');
      frxReport.PrintOptions.ShowDialog := fEmptyStr(frxReport.PrintOptions.Printer);

      frxReport.Script.Variables['NOMREL'] := 'Relatório de Inconsistências Pré-Nota de Entrada';
      frxReport.Script.Variables['NOMEMP'] := fRetNomeEmpresa;
      If blnReimpressao Then
      Begin
        If strTipImp = 'M' Then
        Begin
          TfrxDMPMemoView(frxReport.FindObject('mmoPedido')).Text := '[frxdbCriticas."PEDIDO"]';
          TfrxDMPMemoView(frxReport.FindObject('mmoNFE')).Text := '[frxdbCriticas."NOTELE"]';
          TfrxDMPMemoView(frxReport.FindObject('mmoLoja')).Text := '[frxdbCriticas."EMPELE"]';
          TfrxDMPMemoView(frxReport.FindObject('mmoFornecedor')).Text := '[frxdbCriticas."FORELE"]';
          TfrxDMPMemoView(frxReport.FindObject('mmoComprador')).Text := '[frxdbCriticas."COMPRADOR"]';
          TfrxDMPMemoView(frxReport.FindObject('mmoDEQTPC')).Text := '* Configuração CFG_DEQTPC: Quantidade de casas decimais para quantidade do produto - PEDIDO DE COMPRA = ' + fCfgSis('DEQTPC');
        end
        Else
        Begin
          TfrxMemoView(frxReport.FindObject('mmoPedido')).Text := '[frxdbCriticas."PEDIDO"]';
          TfrxMemoView(frxReport.FindObject('mmoNFE')).Text := '[frxdbCriticas."NOTELE"]';
          TfrxMemoView(frxReport.FindObject('mmoLoja')).Text := '[frxdbCriticas."EMPELE"]';
          TfrxMemoView(frxReport.FindObject('mmoFornecedor')).Text := '[frxdbCriticas."FORELE"]';
          TfrxMemoView(frxReport.FindObject('mmoComprador')).Text := '[frxdbCriticas."COMPRADOR"]';
          TfrxMemoView(frxReport.FindObject('mmoDEQTPC')).Text := '* Configuração CFG_DEQTPC: Quantidade de casas decimais para quantidade do produto - PEDIDO DE COMPRA = ' + fCfgSis('DEQTPC');
        End;
      End
      Else
      Begin
        frxReport.Script.Variables['PEDIDO'] := stlPedidos.CommaText;
        frxReport.Script.Variables['COMPRADOR'] := FstrCompradores;
        frxReport.Script.Variables['NFE'] := strNotEle;
        frxReport.Script.Variables['LOJA'] := VS_strCodEmp + ' - ' + fRetNomeEmpresa;
        frxReport.Script.Variables['FORNECEDOR'] := strCodFor + '-' + fRetNomFornecedor(strCodFor);
        frxReport.Script.Variables['DEQTPC'] := '* Configuração CFG_DEQTPC: Quantidade de casas decimais para quantidade do produto - PEDIDO DE COMPRA = ' + fCfgSis('DEQTPC');
      End;

      If edtDestino.Text = 'V' Then
        pPreviewReport(strFilRel, Self.Caption, frxReport)
      Else
        If frxReport.PrepareReport Then
          pPrintReport(strFilRel, Self.Caption, strNomFil, frxReport);

    Except
      On E: Exception Do
      Begin
        fMensagem('', E.Message, ['&OK']);
      End;
    End;

  End;

  btnImprimir.Enabled := True;
  pnlInfo.Caption := '';
  pSetFocus(TWinControl(rdgOrientacao.Controls[0]));
end;

procedure TfrmRelEntCriticasPreNota.edtCodEmpresaNEExit(Sender: TObject);
begin
  edtDesEmpresaNE.Text := fRetNomeEmpresaSelec(edtCodEmpresaNE.Text);

  If fEmptyStr(edtDesEmpresaNE.Text) And (Not fEmptyStr(edtCodEmpresaNE.Text)) And (edtCodEmpresaNE.Text <> '000') Then
  Begin
    fMensagem('AVISO', 'Código da empresa não encontrado.', ['&O K']);
    edtCodEmpresaNE.Clear;
    pSetFocus(edtCodEmpresaNE);
  End;
end;

procedure TfrmRelEntCriticasPreNota.edtCodEmpresaNEKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrEmp: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresaNE, edtDesEmpresaNE, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmpresaNE, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEntCriticasPreNota.edtForNotExit(Sender: TObject);
Var
  arrForNot: TConsultasArray;
begin
  inherited;
  pEdtCodSelectExit(edtForNot, edtDesForNot, arrForNot, fRetNomFornecedor, Nil, 'do Fornecedor');
end;

procedure TfrmRelEntCriticasPreNota.edtForNotKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrForNot: TConsultasArray;
begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, edtForNot, edtDesForNot, nil, Key, arrForNot) Then
  Begin
    If fValidaCampos(edtForNot, True) Then
      SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmRelEntCriticasPreNota.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(cdsCriCad);
  If blnReimpressao Then
  Begin
    If Assigned(qryCriCad) Then
      FreeAndNil(qryCriCad);
    If Assigned(qryConsulta) Then
      FreeAndNil(qryConsulta);
  End;
end;

procedure TfrmRelEntCriticasPreNota.FormCreate(Sender: TObject);
begin
  inherited;
  Self.Height := 127;
  grpDadosNE.Visible := False;
  blnReimpressao := False;

end;

procedure TfrmRelEntCriticasPreNota.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: If ActiveControl Is TRadioButton Then
        Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEntCriticasPreNota.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(TWinControl(rdgOrientacao.Controls[0]));
  pSetFocus(btnImprimir);
end;

function TfrmRelEntCriticasPreNota.fRetCompradores: String;
var blnCriouQuery: Boolean;
begin
  blnCriouQuery := False;
  If Not Assigned(qryConsulta) Then
  Begin
    qryConsulta := fCriaQuery;
    blnCriouQuery := True;
  End;

  Try
    qryConsulta.SQl.Clear;
    qryConsulta.SQL.Add('SELECT  GROUP_CONCAT(DISTINCT PCG_CODCMP, " - ", OPE_NOMOPE) AS COMPRADOR');
    qryConsulta.SQL.Add('  FROM PCMGER ');
    qryConsulta.SQL.Add('  LEFT JOIN CADOPE ON OPE_CODOPE = PCG_CODCMP ');
    qryConsulta.SQL.Add('  WHERE PCG_NUMPED IN ('+ fCommaText(stlPedidos, True) +')');
    qryConsulta.SQL.Add('  AND PCG_ESPDOC = "PD"');
    qryConsulta.SQL.Add('  AND IFNULL(PCG_EMPDES, PCG_CODEMP) = "'+VS_StrCodEmp + '"');
    qryConsulta.SQL.Add('  AND IFNULL(PCG_CODCMP, "") <> ""');

    qryConsulta.Open;

    Result := qryConsulta.FieldByName('COMPRADOR').AsString;
  Finally
    If blnCriouQuery Then
      FreeAndNil(qryConsulta);
  End;

  {}
end;

procedure TfrmRelEntCriticasPreNota.pPreparaQryReimpressao;
begin
  qryConsulta.SQL.Clear;
  qryCriCad.SQL.Clear;
  qryConsulta.SQL.Add('SELECT C.CRI_CODITE AS CODITE,');
  qryConsulta.SQL.Add('       C.CRI_DESITE AS DESITE,');
  qryConsulta.SQL.Add('       C.CRI_DESUNI AS DESUNI,');
  qryConsulta.SQL.Add('       C.CRI_CODFAB AS CODFAB,');
  qryConsulta.SQL.Add('       I.ITE_SALDOS AS SALDOS,');
  qryConsulta.SQL.Add('       C.CRI_LOCFIS AS LOCFIS,');
  qryConsulta.SQL.Add('       C.CRI_QTDPED AS QTDPED,');
  qryConsulta.SQL.Add('       C.CRI_QTDNFE AS QTDNFE,');
  qryConsulta.SQL.Add('       C.CRI_UNIPED AS UNIPED,');
  qryConsulta.SQL.Add('       C.CRI_UNINFE AS UNINFE,');
  qryConsulta.SQL.Add('       C.CRI_IPIPED AS IPIPED,');
  qryConsulta.SQL.Add('       C.CRI_IPINFE AS IPINFE,');
  qryConsulta.SQL.Add('       C.CRI_SUBPED AS SUBPED,');
  qryConsulta.SQL.Add('       C.CRI_SUBNFE AS SUBNFE,');
  qryConsulta.SQL.Add('       C.CRI_FREPED AS FREPED,');
  qryConsulta.SQL.Add('       C.CRI_FRENFE AS FRENFE,');
  qryConsulta.SQL.Add('       C.CRI_INFADI AS INFADI,');
  qryConsulta.SQL.Add('       C.CRI_NFEEAN AS NFEEAN,');
  qryConsulta.SQL.Add('       C.CRI_CODBAR AS CODBAR,');
  qryConsulta.SQL.Add('       C.CRI_TRAPED AS TRAPED,');
  qryConsulta.SQL.Add('       C.CRI_TRAXML AS TRAXML,');
  qryConsulta.SQL.Add('       CONCAT(B08_NNF, " - ", GER_CODFOR, "-", F.FOR_NOMFOR)  AS NOTELE,');
  qryConsulta.SQL.Add('       CONCAT(GER_CODFOR, "-", F.FOR_NOMFOR)  AS FORELE,');
  qryConsulta.SQL.Add('       C.AUTOINCREM,');
  qryConsulta.SQL.Add('       C.CRI_OPELIB AS OPELIB,');
  qryConsulta.SQL.Add('       C.CRI_DTALIB AS DTALIB,');
  qryConsulta.SQL.Add('       C.CRI_AUTNFE AS AUTNFE,');
  qryConsulta.SQL.Add('       C.CRI_DESITE AS DESITE,');
  qryConsulta.SQL.Add('       CONCAT(EMP_CODEMP, "-", EMP_NOMEMP) AS EMPELE,');
  qryConsulta.SQL.Add('       GROUP_CONCAT(DISTINCT PEL_NUMDOC) AS PEDIDO,');
  qryConsulta.SQL.Add('       GROUP_CONCAT(DISTINCT PCG_CODCMP, " - ", OPE_NOMOPE) AS COMPRADOR, ');
  qryConsulta.SQL.Add('       (D.I11_VPROD - D.I17_VDESC + D.O14_VIPI + D.N23_VICMSST + D.N23D_FCPST) AS TOTGER ');
  qryConsulta.SQL.Add('  FROM PRECRI C');
  qryConsulta.SQL.Add('   INNER JOIN GERELE G ON G.AUTOINCREM = C.CRI_AUTNFE');
  qryConsulta.SQL.Add('   INNER JOIN PEDELE P ON P.PEL_SEQELE = C.CRI_AUTNFE');
  qryConsulta.SQL.Add('   INNER JOIN CADFOR F ON F.FOR_CODFOR = G.GER_CODFOR');
  qryConsulta.SQL.Add('   INNER JOIN CADEMP E ON E.EMP_CODEMP = G.GER_CODEMP');
  qryConsulta.SQL.Add('   LEFT JOIN ITEGER I ON I.ITE_CODITE = C.CRI_CODITE');
  qryConsulta.SQL.Add('                      AND I.ITE_CODEMP = G.GER_CODEMP');
  qryConsulta.SQL.Add('   LEFT JOIN DETELE D ON G.AUTOINCREM = D.DET_SEQGER');
  qryConsulta.SQL.Add('                     AND D.DET_CODITE = C.CRI_CODITE');
  qryConsulta.SQL.Add('   LEFT JOIN PCMGER ON PCG_NUMPED = PEL_NUMDOC ');
  qryConsulta.SQL.Add('                   AND PCG_ESPDOC = PEL_ESPDOC ');
  qryConsulta.SQL.Add('                   AND PCG_CODEMP = PEL_CODEMP ');
  qryConsulta.SQL.Add('                   AND PCG_CODFOR = PEL_CODFOR ');
  qryConsulta.SQL.Add('    LEFT JOIN CADOPE ON OPE_CODOPE = PCG_CODCMP ');
  qryConsulta.SQL.Add(' WHERE TRUE ');
  If Not fEmptyStr(edtDocumento.Text) Then
    qryConsulta.SQL.Add('    AND B08_NNF = :NUMDOC ');
  If Not fEmptyStr(edtSerie.Text) Then
    qryConsulta.SQL.Add('    AND B07_SERIE = :SERIE ');
  If Not fEmptyStr(edtCodEmpresaNE.Text) Then
    qryConsulta.SQL.Add('    AND GER_CODEMP = :CODEMP ');
  If Not fEmptyStr(edtForNot.Text) Then
    qryConsulta.SQL.Add('    AND GER_CODFOR = :CODFOR ');
  If Not fEmptyStr(mskDtaEntIni.Text, True) And Not fEmptyStr(mskDtaEntFin.Text, True) Then
    qryConsulta.SQL.Add('    AND ((B09_DEMI BETWEEN :DTAINI AND :DTAFIN) OR (GER_DTAIMP BETWEEN :DTAINI AND :DTAFIN)) ');

  qryCriCad.SQL.Text := qryConsulta.SQL.Text;
  qryCriCad.SQL.Add('AND CRI_INFADI <> ' + QuotedStr('') + ' AND CRI_CODITE <> ' + QuotedStr('00000'));

  If Not fEmptyStr(edtDocumento.Text) Then
  Begin
    qryConsulta.ParamByName('NUMDOC').AsString := edtDocumento.Text;
    qryCriCad.ParamByName('NUMDOC').AsString := edtDocumento.Text;
  end;
  If Not fEmptyStr(edtSerie.Text) Then
  Begin
    qryConsulta.ParamByName('SERIE').AsString := edtSerie.Text;
    qryCriCad.ParamByName('SERIE').AsString := edtSerie.Text;
  end;
  If Not fEmptyStr(edtCodEmpresaNE.Text) Then
  Begin
    qryConsulta.ParamByName('CODEMP').AsString := edtCodEmpresaNE.Text;
    qryCriCad.ParamByName('CODEMP').AsString := edtCodEmpresaNE.Text;
  end;
  If Not fEmptyStr(edtForNot.Text) Then
  Begin
    qryConsulta.ParamByName('CODFOR').AsString := edtForNot.Text;
    qryCriCad.ParamByName('CODFOR').AsString := edtForNot.Text;
  end;
  If Not fEmptyStr(mskDtaEntIni.Text, True) And Not fEmptyStr(mskDtaEntFin.Text, True) Then
  Begin
    qryConsulta.ParamByName('DTAINI').AsDate := StrToDate(mskDtaEntIni.Text);
    qryConsulta.ParamByName('DTAFIN').AsDate := StrToDate(mskDtaEntFin.Text);
    qryCriCad.ParamByName('DTAINI').AsDate := StrToDate(mskDtaEntIni.Text);
    qryCriCad.ParamByName('DTAFIN').AsDate := StrToDate(mskDtaEntFin.Text);
  end;
  qryConsulta.SQL.Add('GROUP BY C.AUTOINCREM');
  qryCriCad.SQL.Add('GROUP BY C.AUTOINCREM');
  qryConsulta.SQL.Add('ORDER BY C.CRI_AUTNFE');
  qryCriCad.SQL.Add('ORDER BY C.CRI_AUTNFE');
end;

procedure TfrmRelEntCriticasPreNota.pPreparaReimpressaoCritica;

begin
  Self.Height := 261;
  grpDadosNE.Visible := True;
  btnImprimir.ModalResult := mrNone;

  qryCriCad := fCriaQuery;
  qryConsulta := fCriaQuery;
  blnReimpressao := True;

end;

procedure TfrmRelEntCriticasPreNota.pSetstlPedidos(const Value: TStringList);
begin
  FstlPedidos := Value;
  FstrCompradores := fRetCompradores;
end;

end.
