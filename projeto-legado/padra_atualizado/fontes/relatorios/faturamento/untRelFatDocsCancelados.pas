unit untRelFatDocsCancelados;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, Mask, MaskEditFocus, RLFilters, RLDraftFilter,
  Menus, StdCtrls, EditFocus, QColorLabel, Buttons, ExtCtrls, StrUtils,
  frxDesgn, frxClass, frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML,
  frxExportXLS, frxExportRTF, AppEvnts, Uni, untTypesSistema, BitBtnLockedIncrem,
  untGeraExcel, untExcel, DB, ComCtrls, frxExportCSVTestabilidade;

type
  TfrmRelFatDocsCancelados = class(TfrmPaiRelatorio)
    lblEmpresa: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    Label1: TLabel;
    edtEspDoc: TEditFocus;
    edtNumDoc: TEditFocus;
    Label2: TLabel;
    rgpSelectDatas: TRadioGroup;
    Label3: TLabel;
    edtCodVen: TEditFocus;
    edtDesVen: TEditFocus;
    Label4: TLabel;
    edtCodCli: TEditFocus;
    edtDesCli: TEditFocus;
    gpb1: TGroupBox;
    chkVenda: TCheckBox;
    chkCompra: TCheckBox;
    lbl1: TLabel;
    edtCodOco: TEditFocus;
    edtDesOco: TEditFocus;
    Label14: TLabel;
    edtCodRed: TEditFocus;
    edtDesRed: TEditFocus;
    ColorLabel2: TColorLabel;
    pgbProgresso: TProgressBar;
    Label5: TLabel;
    edtCodCfop: TEditFocus;
    edtDesCfops: TEditFocus;
    procedure FormShow(Sender: TObject);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtCodVenExit(Sender: TObject);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliExit(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure chkVendaClick(Sender: TObject);
    procedure chkCompraClick(Sender: TObject);
    procedure edtCodOcoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodOcoExit(Sender: TObject);
    procedure edtCodRedExit(Sender: TObject);
    procedure edtCodRedKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure edtCodCfopKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCfopExit(Sender: TObject);
    procedure edtCodCfopChange(Sender: TObject);
  private
    { Private declarations }
    strClass : String;

    arrEmp,
    arrVen,
    arrCli,
    arrRed,
    arrCfop,
    arrOco: TConsultasArray;
    QryRel : TUniQuery;

    strEmp,
    strVen,
    strCli,
    strRed,
    strCfop,
    strOco: String;

    procedure pGeraExcel(qryDados: TUniQuery);
    procedure pSomaTotais(var Totais: TTotais; Dados: TDataSet);
    procedure pImpFiltros(Excel: TExcel; Dados: TDataSet; Campos: TCampos; Filtros: array of String);
    procedure pImpDetalhe(Excel: TExcel; Dados: TDataSet; Campos: TCampos; CorFundo: TCorExcel);
    procedure pImpTitColuna(Excel: TExcel; Campos: TCampos);
    procedure pMontaResumo(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras);

    procedure pCarregaClassificacoes;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
  end;

var
  frmRelFatDocsCancelados: TfrmRelFatDocsCancelados;

implementation

uses untFuncoesFactory, untIFuncoes, untQckFatDocsCancelados,
  untClassPanelCx;

{$R *.dfm}

procedure TfrmRelFatDocsCancelados.FormShow(Sender: TObject);
begin
  shpMultSel.Visible := True;

  // carrega classificacoes para validação de campos
  pCarregaClassificacoes;

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  blnExcel := True;

  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);

  edtNumDoc.MaxLength := fTamDocCadRec;
  edtNumDoc.TamCampo  := fTamDocCadRec;

  inherited;
end;

procedure TfrmRelFatDocsCancelados.edtCodEmpExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodEmp, edtDesEmp, arrEmp, fRetNomeEmpresa, nil, 'da Empresa', 3);
end;

procedure TfrmRelFatDocsCancelados.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
begin
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrEmp, False, True) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatDocsCancelados.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNumDoc);
end;

function TfrmRelFatDocsCancelados.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
  Var
    intEmp: Integer;
    intIndex : Integer;
    intErro : Integer;
begin
  Result := True;
  intErro := 0;

  If(inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = mskDtaIni) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) And (fEmptyStr(edtNumDoc.Text)) Then
      Begin
        fMensagem('AVISO','O Campo Data Inicial deve ser preenchido!',['&O K']);
        Result := False;
      End;
    End

    Else
    If (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(edtNumDoc.Text) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('AVISO','O Campo Data Final deve ser preenchido!',['&O K']);
          Result := False;
        End
        Else
        If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
        Begin
          fMensagem('AVISO','O Campo Data Inicial deve ser menor que a Data Final',['&O K']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtNumDoc) Then
    Begin

      If (Not fEmptyStr(edtNumDoc.Text)) Then
      Begin
        mskDtaIni.Clear;
        mskDtaFin.Clear;
        edtCodEmp.Clear;
        edtDesEmp.Clear;

        mskDtaIni.Enabled := False;
        mskDtaFin.Enabled := False;
        edtCodEmp.Enabled := False;
      End
      Else
      Begin
        If blnValidaIndividual Then
        Begin
          mskDtaIni.Enabled := True;
          mskDtaFin.Enabled := True;
          edtCodEmp.Enabled := True;

          mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
          mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

          edtCodEmp.Text := VS_strCodEmp;
          edtDesEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);
        End;
      End;

    End

    Else If (Sender = edtCodVen) Then
    begin
      If (fEmptyStr(edtCodVen.Text)) Then
        pDesmarcaLista(edtCodVen, arrVen);
    end

    Else If (Sender = edtCodCli) Then
    begin
      If (fEmptyStr(edtCodCli.Text)) Then
        pDesmarcaLista(edtCodCli, arrCli)
    end

    Else If (Sender = edtCodRed) Then
    begin
      If (fEmptyStr(edtCodVen.Text)) Then
        pDesmarcaLista(edtCodRed, arrRed);
    end

    Else If (Sender = edtCodOco) Then
      pDesmarcaLista(edtCodOco, arrOco)

    Else If (Sender = edtCodEmp) Then
    Begin
      pDesmarcaLista(edtCodEmp, arrEmp);

      If Length(arrEmp) > 0 Then
        For intEmp := 0 To Length(arrEmp) -1 Do
        Begin
          If Not fEmptyStr(arrEmp[intEmp].strCodigo) Then
          Begin
            If Pos(arrEmp[intEmp].strCodigo, strEmpAcessoUsuarioLogado) <= 0 Then
            Begin
              fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
              Result := False;
              Break;
            End;
          End;
        End
      Else
      Begin
        If Not fEmptyStr(edtCodEmp.Text) Then
        Begin
          If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
            Result := False;
          End;
        End;
      End;
    End
    Else If (Sender = edtCodCfop) Then
    begin
      If (fEmptyStr(edtCodCfop.Text)) Then
        pDesmarcaLista(edtCodCfop, arrCfop);

      If (Not fEmptyStr(edtCodCfop.Text)) Then
      begin
        If (Length(arrCfop) > 0) Then
        begin
          for intIndex := Low(arrCfop) to High(arrCfop) do
          begin
            If (Pos(arrCfop[intIndex].strCodigo, strClass)<= 0 ) Then
            begin
              Inc(intErro);
            end;
          end;
        end;

        If (Not fEmptyStr(edtCodCfop.Text) and (Length(arrCfop) = 0) ) Then
        begin
          If (Pos(edtCodCfop.Text, strClass)<= 0 ) Then
            Inc(intErro);
        end;

        If (intErro > 0) Then
        begin
          fMensagem('ATENÇÃO!', 'Classificação Fiscal inválida!', ['&O k']);
          Result := False;
        end;
      end;
    end;
  End;
end;

procedure TfrmRelFatDocsCancelados.btnImprimirClick(Sender: TObject);
  Var
    strSQL,
    strSQL2,
    strSQLFgo,
    strSelect:string;
begin
  Try
    pnlInfo.Caption := 'Gerando Relatório...';
    pnlInfo.Repaint;
    inherited;

    If (Not fTabelaExiste('DEL_NOTGER')) And
       (Not fTabelaExiste('DEL_MOVGER')) And
       (Not fTabelaExiste('DEL_FATGOR')) Then
    Begin
      blnImprime := False;
      pTabelaVazia;
    End;

    If blnImprime Then
    Begin
      {*******************************************}
      {* PEDIDOS DE VENDAS CANCELADOS            *}
      {****************************************AC*}
      strSQL  := '';
      strSQL2 := '';
      strSQLFgo := '';
      strSelect := '';

      If (fTabelaExiste('DEL_FATGOR')) And
         (Not chkVenda.Checked) And (Not chkCompra.Checked) and (fEmptyStr(edtCodCfop.Text)) Then
      Begin
        strSQLFgo := strSQLFgo + ' SELECT SQL_NO_CACHE ';
        strSQLFgo := strSQLFgo + '   CONCAT(FGO_NUMDOC,"-",FGO_ESPDOC) AS NUMDOC, ';
        strSQLFgo := strSQLFgo + '   DTADEL, ';
        strSQLFgo := strSQLFgo + '   HORDEL, ';
        strSQLFgo := strSQLFgo + '   OPEDEL, ';
//        strSQLFgo := strSQLFgo + '  IF ( OCO_DESOCO IS NULL, CAST(MOTDEL AS CHAR(50)), CONCAT(OCO_CODOCO,"-",OCO_DESOCO) ) AS MOTDEL, ';
        strSQLFgo := strSQLFgo + '   MOTDEL, ';
        strSQLFgo := strSQLFgo + '   FGO_CODVEN AS CODVEN, ';
        strSQLFgo := strSQLFgo + '   OPE_NOMOPE AS NOMOPE, ';
        strSQLFgo := strSQLFgo + '   FGO_CODEMP AS CODEMP, ';
        strSQLFgo := strSQLFgo + '   CONCAT(FGO_CODCLI,"-",CLI_NOMCLI) AS NOMCLI, ';
        strSQLFgo := strSQLFgo + '   FGO_DTAENT AS DTAENT, ';
        strSQLFgo := strSQLFgo + '   FGO_VLRCON AS VLRCON, ';
        strSQLFgo := strSQLFgo + '   "" AS CLAFIS ';
        strSQLFgo := strSQLFgo + ' FROM ';
        strSQLFgo := strSQLFgo + '   DEL_FATGOR ';
        strSQLFgo := strSQLFgo + '        JOIN CADCLI ON FGO_CODCLI = CLI_CODCLI ';
        strSQLFgo := strSQLFgo + '        JOIN CADOPE ON FGO_CODVEN = OPE_CODOPE ';
        strSQLFgo := strSQLFgo + '   LEFT JOIN CADOCO ON TRIM(LEFT(MOTDEL,3)) = OCO_CODOCO ';
        strSQLFgo := strSQLFgo + ' WHERE ';
        strSQLFgo := strSQLFgo + '  TRUE ';

        If fEmptyStr(edtNumDoc.Text) Then
          Case rgpSelectDatas.ItemIndex of
            0: strSQLFgo := strSQLFgo + '  AND DTADEL BETWEEN :DTAINI AND :DTAFIN  ';
            1: strSQLFgo := strSQLFgo + '  AND FGO_DTAENT BETWEEN :DTAINI AND :DTAFIN  ';
          End;

        If Not fEmptyStr(edtNumDoc.Text) Then
          strSQLFgo := strSQLFgo + '  AND FGO_NUMDOC = :NUMDOC ';

        If Not fEmptyStr(edtEspDoc.Text) Then
          strSQLFgo := strSQLFgo + '  AND FGO_ESPDOC = :ESPDOC ';

        strSQLFgo := strSQLFgo + fStrLocateEmpresa(edtCodEmp, arrEmp, 'FGO_CODEMP', 'CODEMP');
        strSQLFgo := strSQLFgo + fStrLocate(edtCodCli, arrCli, 'FGO_CODCLI', 'CODCLI');
        strSQLFgo := strSQLFgo + fStrLocate(edtCodVen, arrVen, 'FGO_CODVEN', 'CODVEN');
        strSQLFgo := strSQLFgo + fStrLocate(edtCodOco, arrOco, 'OCO_CODOCO', 'CODOCO');
        strSQLFgo := strSQLFgo + fStrLocate(edtCodRed, arrRed, 'CLI_CODRED', 'CODRED');
      End;

      If (fTabelaExiste('DEL_MOVGER')) Then
      Begin

        If Not fEmptyStr(strSQL) Then
          strSQL := strSQL + ' UNION ALL ';

        strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
        STRSQL := strSQL + '  CONCAT(GER_NUMDOC,"-",GER_ESPDOC) AS NUMDOC, ';
        strSQL := strSQL + '  DTADEL, ';
        strSQL := strSQL + '  HORDEL, ';
        strSQL := strSQL + '  OPEDEL, ';
//        strSQL := strSQL + '  IF ( OCO_DESOCO IS NULL, CAST(MOTDEL AS CHAR(50)), CONCAT(OCO_CODOCO,"-",OCO_DESOCO) ) AS MOTDEL, ';
        strSQL := strSQL + '  MOTDEL, ';
        strSQL := strSQL + '  GER_CODVEN AS CODVEN, ';
        strSQL := strSQL + '  OPE_NOMOPE AS NOMOPE, ';
        strSQL := strSQL + '  GER_CODEMP AS CODEMP, ';
        strSQL := strSQL + '  IF(GER_CODCLI IS NOT NULL, CONCAT(GER_CODCLI,"-",CLI_NOMCLI), CONCAT(GER_CODFOR,"-",FOR_NOMFOR)) AS NOMCLI, ';
        strSQL := strSQL + '  GER_DTAENT AS DTAENT, ';
        strSQL := strSQL + '  GER_VLRCON AS VLRCON, ';
        strSQL := strSQL + '  GER_CLAFIS AS CLAFIS ';
        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  DEL_MOVGER ';
        strSQL := strSQL + '  LEFT JOIN CADOPE ON GER_CODVEN = OPE_CODOPE ';
        strSQL := strSQL + '  LEFT JOIN CADCLI ON GER_CODCLI = CLI_CODCLI ';
        strSQL := strSQL + '  LEFT JOIN CADFOR ON GER_CODFOR = FOR_CODFOR ';
        strSQL := strSQL + '  LEFT JOIN CADOCO ON TRIM(LEFT(MOTDEL,3)) = OCO_CODOCO ';
        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  TRUE ';

        If fEmptyStr(edtNumDoc.Text) Then
          case rgpSelectDatas.ItemIndex of
            0: strSQL := strSQL + '  AND DTADEL BETWEEN :DTAINI AND :DTAFIN  ';
            1: strSQL := strSQL + '  AND GER_DTAENT BETWEEN :DTAINI AND :DTAFIN  ';
          End;

        If Not fEmptyStr(edtNumDoc.Text) Then
          strSQL := strSQL + '  AND GER_NUMDOC = :NUMDOC ';

        If Not fEmptyStr(edtEspDoc.Text) Then
          strSQL := strSQL + '  AND GER_ESPDOC = :ESPDOC ';

        strSQL := strSQL + fStrLocateEmpresa(edtCodEmp, arrEmp, 'GER_CODEMP', 'CODEMP');
        strSQL := strSQL + fStrLocate(edtCodCli, arrCli, 'GER_CODCLI', 'CODCLI');
        strSQL := strSQL + fStrLocate(edtCodVen, arrVen, 'GER_CODVEN', 'CODVEN');
        strSQL := strSQL + fStrLocate(edtCodOco, arrOco, 'OCO_CODOCO', 'CODOCO');
        strSQL := strSQL + fStrLocate(edtCodRed, arrRed, 'CLI_CODRED', 'CODRED');
        strSQL := strSQL + fStrLocate(edtCodCfop, arrCfop, 'GER_CLAFIS', 'CODCFOP');


        If chkVenda.Checked Then
          strSQL := strSQL + '  AND LOCATE(GER_CLAFIS, :CLAVEN) > 0 ';

        If chkCompra.Checked Then
          strSQL := strSQL + '  AND LOCATE(GER_CLAFIS, :CLACOM) > 0 ';
      End;

      If (fTabelaExiste('DEL_NOTGER')) Then
      Begin

        If Not fEmptyStr(strSQL) Then
          strSQL := strSQL + ' UNION ALL ';

        strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
        STRSQL := strSQL + '  CONCAT(GER_NUMDOC,"-",GER_ESPDOC) AS NUMDOC, ';
        strSQL := strSQL + '  DTADEL, ';
        strSQL := strSQL + '  HORDEL, ';
        strSQL := strSQL + '  OPEDEL, ';
//        strSQL := strSQL + '  IF ( OCO_DESOCO IS NULL, CAST(MOTDEL AS CHAR(50)), CONCAT(OCO_CODOCO,"-",OCO_DESOCO) ) AS MOTDEL, ';
        strSQL := strSQL + '  MOTDEL, ';
        strSQL := strSQL + '  GER_CODVEN AS CODVEN, ';
        strSQL := strSQL + '  OPE_NOMOPE AS NOMOPE, ';
        strSQL := strSQL + '  GER_CODEMP AS CODEMP, ';
        strSQL := strSQL + '  IF(GER_CODCLI IS NOT NULL, CONCAT(GER_CODCLI,"-",CLI_NOMCLI), CONCAT(GER_CODFOR,"-",FOR_NOMFOR)) AS NOMCLI, ';
        strSQL := strSQL + '  GER_DTAENT AS DTAENT, ';
        strSQL := strSQL + '  GER_VLRCON AS VLRCON, ';
        strSQL := strSQL + '  GER_CLAFIS AS CLAFIS ';
        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  DEL_NOTGER ';
        strSQL := strSQL + '  LEFT JOIN CADOPE ON GER_CODVEN = OPE_CODOPE ';
        strSQL := strSQL + '  LEFT JOIN CADCLI ON GER_CODCLI = CLI_CODCLI ';
        strSQL := strSQL + '  LEFT JOIN CADFOR ON GER_CODFOR = FOR_CODFOR ';
        strSQL := strSQL + '  LEFT JOIN CADOCO ON TRIM(LEFT(MOTDEL,3)) = OCO_CODOCO ';
        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  TRUE ';

        If fEmptyStr(edtNumDoc.Text) Then
          case rgpSelectDatas.ItemIndex of
            0: strSQL := strSQL + '  AND DTADEL BETWEEN :DTAINI AND :DTAFIN  ';
            1: strSQL := strSQL + '  AND GER_DTAENT BETWEEN :DTAINI AND :DTAFIN  ';
          End;

        If Not fEmptyStr(edtNumDoc.Text) Then
          strSQL := strSQL + '  AND GER_NUMDOC = :NUMDOC ';

        If Not fEmptyStr(edtEspDoc.Text) Then
          strSQL := strSQL + '  AND GER_ESPDOC = :ESPDOC ';

        strSQL := strSQL + fStrLocateEmpresa(edtCodEmp, arrEmp, 'GER_CODEMP', 'CODEMP');
        strSQL := strSQL + fStrLocate(edtCodCli, arrCli, 'GER_CODCLI', 'CODCLI');
        strSQL := strSQL + fStrLocate(edtCodVen, arrVen, 'GER_CODVEN', 'CODVEN');
        strSQL := strSQL + fStrLocate(edtCodOco, arrOco, 'OCO_CODOCO', 'CODOCO');
        strSQL := strSQL + fStrLocate(edtCodRed, arrRed, 'CLI_CODRED', 'CODRED');

        If chkVenda.Checked Then
          strSQL := strSQL + '  AND LOCATE(GER_CLAFIS, :CLAVEN) > 0 ';

        If chkCompra.Checked Then
          strSQL := strSQL + '  AND LOCATE(GER_CLAFIS, :CLACOM) > 0 ';
      End;

      If Not fEmptyStr(strSQLFgo) Then
        strSelect := strSQLFgo;

      If Not fEmptyStr(strSQL) Then
      Begin

        If Not fEmptyStr(strSelect) Then
          strSelect := strSelect + 'UNION ALL ';

        strSelect := strSelect + strSQL;
      End;

      If Not fEmptyStr(strSQL2) Then
      Begin

        If Not fEmptyStr(strSelect) Then
          strSelect := strSelect + 'UNION ALL ';

        strSelect := strSelect + strSQL2;

      End;

      strSelect := strSelect + 'ORDER BY ';
      strSelect := strSelect + '  DTADEL, HORDEL ';

      QryRel := fCriaQuery;

      With QryRel Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSelect);

        If fEmptyStr(edtNumDoc.Text) Then
        Begin
          ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
          ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
        End;

        If Not fEmptyStr(edtEspDoc.Text) Then
          ParamByName('ESPDOC').AsString := edtEspDoc.Text;

        If Not fEmptyStr(edtNumDoc.Text) Then
          ParamByName('NUMDOC').AsString := edtNumDoc.Text;

        pSetaParam(edtCodEmp.Text, arrEmp, strEmp, 'CODEMP', QryRel);
        pSetaParam(edtCodVen.Text, arrVen, strVen, 'CODVEN', QryRel);
        pSetaParam(edtCodCli.Text, arrCli, strCli, 'CODCLI', QryRel);
        pSetaParam(edtCodRed.Text, arrRed, strRed, 'CODRED', QryRel);
        pSetaParam(edtCodOco.Text, arrOco, strOco, 'CODOCO', QryRel);
        pSetaParam(edtCodCfop.Text, arrCfop, strCfop, 'CODCFOP', QryRel);

        If Assigned(Params.FindParam('CLAVEN')) Then
        Begin
          ParamByName('CLAVEN').AsString := VS_strClaVen;
        End;

        If Assigned(Params.FindParam('CLACOM')) Then
        Begin
          ParamByName('CLACOM').AsString := VS_strClaCom;
        End;

        Open;

      End;

      If Not QryRel.IsEmpty Then
      Begin
        If edtDestino.Text = 'E' Then
        Begin
          pGeraExcel(QryRel);
        End
        Else
        Begin
           Try
             pCriarFormularios(TfrmQckFatDocsCancelados,frmQckFatDocsCancelados);

             If strTipImp = 'M' Then
               frmQckFatDocsCancelados.qckPagina.DefaultFilter := rldFiltro
             Else
               frmQckFatDocsCancelados.qckPagina.DefaultFilter := Nil;

             {********************}
             {* CABEÇALHO DO QCK *}
             {*****************LB*}
             frmQckFatDocsCancelados.rllNomeRelatorio.Caption := 'RELATORIO DE DOCUMENTOS CANCELADOS ';
             If fEmptyStr(edtNumDoc.Text) Then
               frmQckFatDocsCancelados.strOrdem := 'REFERENTE AO PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text
             Else
               frmQckFatDocsCancelados.strOrdem := '';

             If fEmptyStr(edtEspDoc.Text) Then
               frmQckFatDocsCancelados.rllEspecie.Caption := 'ESPECIE: TODAS '
             Else
               frmQckFatDocsCancelados.rllEspecie.Caption := 'ESPECIE: ' + edtEspDoc.Text;

             frmQckFatDocsCancelados.rllEmpresa.Caption := fStrTitulo(edtCodEmp.Text, edtDesEmp, arrEmp, strEmp, 'EMPRESA', True);
             frmQckFatDocsCancelados.rllRedeLoja.Caption := fStrTitulo(edtCodRed.Text, edtDesRed, arrRed, strRed, 'REDE DE LOJA', True);
             frmQckFatDocsCancelados.rllOcorrencia.Caption := fStrTitulo(edtCodOco.Text, edtDesOco, arrOco, strOco, 'OCORRÊNCIA', True);
             frmQckFatDocsCancelados.rllCliente.Caption := fStrTitulo(edtCodCli.Text, edtDesCli, arrCli, strCli, 'CLIENTE');
             frmQckFatDocsCancelados.rllVendedor.Caption := fStrTitulo(edtCodVen.Text, edtDesVen, arrVen, strVen, 'VENDEDOR');
             frmQckFatDocsCancelados.rllCfop.Caption := IfThen(fEmptyStr(edtCodCfop.Text), 'CLASS. FISCAL:NENHUM INFORMADO',
               fStrTitulo(edtCodCfop.Text, edtDesCfops, arrCfop, strCfop, 'CLASS. FISCAL', True));

             If chkVenda.Checked Then
               frmQckFatDocsCancelados.rllTipoDocumentos.Caption := 'SOMENTE CFOP DE VENDA'
             Else If chkCompra.Checked Then
               frmQckFatDocsCancelados.rllTipoDocumentos.Caption := 'SOMENTE CFOP DE COMPRA'
             Else
               frmQckFatDocsCancelados.rllTipoDocumentos.Caption := ' ';

             frmQckFatDocsCancelados.dtsRelatorio.DataSet := QryRel;

             If edtDestino.Text = 'V' Then
               frmQckFatDocsCancelados.qckPagina.PreviewModal
             Else
               frmQckFatDocsCancelados.qckPagina.Print;

           Except
             On E: Exception Do
             Begin
               pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
             End;
           End;

           pFreeAndNil(frmQckFatDocsCancelados);
        End;
      End
      Else
      Begin
        pTabelaVazia;
      End;

    End;

    btnImprimir.Enabled := True;
    pnlInfo.Caption := '';

  Except
    On E: Exception Do
      pMensagensErro(e.Message,'[TfrmRelFatDocsCancelados.btnImprimirClick]');
  End;

end;

procedure TfrmRelFatDocsCancelados.edtCodVenExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodVen, edtDesVen, arrVen, fRetNomVendRep, nil, 'do Vendedor');
end;

procedure TfrmRelFatDocsCancelados.edtCodVenKeyPress(Sender: TObject; var Key: Char);
begin
  If fPesqOperador(Self, edtCodVen, edtDesVen, nil, Key, arrVen, False)  Then
  Begin
    If fValidaCampos(edtCodVen, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatDocsCancelados.edtCodCfopChange(Sender: TObject);
begin
  inherited;
  If (Not fEmptyStr(edtCodCfop.Text)) Then
    gpb1.Enabled := False
  else
    gpb1.Enabled := False;
end;

procedure TfrmRelFatDocsCancelados.edtCodCfopExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCfop, edtDesCfops, arrCfop, fRetNatOpe, Nil, 'da Classificação Fiscal');
end;

procedure TfrmRelFatDocsCancelados.edtCodCfopKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqCFOP(Self, edtCodCfop, edtDesCfops, Nil, Key, arrCfop, False) Then
  Begin
    If fValidaCampos(edtCodCfop, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatDocsCancelados.edtCodCliExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodCli, edtDesCli, arrCli, nil, fRetNomCliente, 'do Cliente');

  If Not fEmptyStr(edtCodCli.Text) Then
  Begin
    edtCodRed.Enabled := False;
    edtCodRed.Clear;
    pDesmarcaLista(edtCodRed, arrRed);
  End
  Else
    edtCodRed.Enabled := True;
end;

procedure TfrmRelFatDocsCancelados.edtCodCliKeyPress(Sender: TObject; var Key: Char);
begin
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtDesCli, Nil, Key, arrCli, False) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatDocsCancelados.edtCodOcoExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodOco, edtDesOco, arrOco, Nil, fRetDescOcorrencia, 'da Ocorrência');
end;

procedure TfrmRelFatDocsCancelados.edtCodOcoKeyPress(Sender: TObject; var Key: Char);
begin
  If fPesqOcorrencia(Self, edtCodOco, edtDesOco, Nil, Key, arrOco, False) Then
  Begin
    If fValidaCampos(edtCodOco, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatDocsCancelados.edtCodRedExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodRed, edtDesRed, arrRed, nil, fRetNomeRedeLoja, 'da Rede');
end;

procedure TfrmRelFatDocsCancelados.edtCodRedKeyPress(Sender: TObject; var Key: Char);
begin
  If fPesqRedeLojas(Self, edtCodRed, edtDesRed, Nil, Key, arrRed, False) Then
  Begin
    If fValidaCampos(edtCodRed, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatDocsCancelados.pCarregaClassificacoes;
  var
    qryClass : TUniQuery;
    strSqlCla : String;
begin
  try
    qryClass := fCriaQuery(nil);

    strSqlCla := '';
    strSqlCla := strSqlCla + ' SELECT';
    strSqlCla := strSqlCla + '   CFO_CODCFO';
    strSqlCla := strSqlCla + ' FROM';
    strSqlCla := strSqlCla + '   CADCFO';

    with qryClass do
    begin
      Close;
      SQL.Text := strSqlCla;
      Open;

      If (Not IsEmpty) Then
      begin
        First;
        strClass := '';

        while not Eof do
        begin
          strClass := strClass + FieldByName('CFO_CODCFO').AsString + '_';
          Next;
        end;
      end;
    end;
  finally
    FreeAndNil(qryClass);
  end;
end;

procedure TfrmRelFatDocsCancelados.pGeraExcel(qryDados: TUniQuery);
var objGeraExcel: TGeraExcel;
begin
  objGeraExcel := TGeraExcel.Create(qryDados, pgbProgresso);
  Try
    With objGeraExcel do
    Begin
      strNomRel := 'RELATORIO DE DOCUMENTOS CANCELADOS';

      AddFiltro(fStrTitulo(edtCodEmp.Text, edtDesEmp, arrEmp, strEmp, 'EMPRESA', True));
      AddFiltro(fStrTitulo(edtCodVen.Text, edtDesVen, arrVen, strVen, 'VENDEDOR'));
      AddFiltro(fStrTitulo(edtCodCli.Text, edtDesCli, arrCli, strCli, 'CLIENTE'));
      AddFiltro(fStrTitulo(edtCodRed.Text, edtDesRed, arrRed, strRed, 'REDE DE LOJA', True));
      AddFiltro(fStrTitulo(edtCodOco.Text, edtDesOco, arrOco, strOco, 'OCORRÊNCIA', True));
      AddFiltro(IfThen(fEmptyStr(edtCodCfop.Text), 'CLASS. FISCAL:NENHUM INFORMADO',
         fStrTitulo(edtCodCfop.Text, edtDesCfops, arrCfop, strCfop, 'CLASS. FISCAL', True)));

      If chkVenda.Checked Then
        AddFiltro('SOMENTE CFOP DE VENDA');
      If chkCompra.Checked Then
        AddFiltro('SOMENTE CFOP DE COMPRA');

      AddFiltro('REFERENTE AO PERIODO DE ' + mskDtaIni.Text+ ' A ' + mskDtaFin.Text);

      AddCampo('DTADEL',  'DATA DEL');
      AddCampo('HORDEL',  'HORA DEL');
      AddCampo('OPEDEL',  'OPE');
      AddCampo('CODEMP',  'EMP');
      AddCampo('CLAFIS',  'CFOP');
      AddCampo('NUMDOC',  'DOCUMENTO');
      AddCampo('NOMCLI',  'CÓDIGO - NOME CLIENTE / FORNECEDOR');
      AddCampo('CODVEN',  'VENDEDOR');
      AddCampo('DTAENT',  'DATA DOC');
      AddCampo('VLRCON',  'VALOR TOTAL');

      AddTotais('VLRCON');
    End;

    objGeraExcel.OnSomaResumo := pSomaTotais;
    objGeraExcel.OnImpDetalhes := pImpDetalhe;
    objGeraExcel.OnImpFiltros := pImpFiltros;
    objGeraExcel.OnImpTitColuna := pImpTitColuna;
    objGeraExcel.OnMontaResumo := pMontaResumo;

    If objGeraExcel.fGerarRelatorio Then
       fMensagem('','Arquivo gerado com sucesso!',['&O k']);
  Finally
    objGeraExcel.Free;
  End;
end;

procedure TfrmRelFatDocsCancelados.pSomaTotais(var Totais: TTotais; Dados: TDataSet);
Begin
  Totais['VLRCON'] := Totais['VLRCON'] + Dados.FieldByName('VLRCON').AsFloat;
End;

procedure TfrmRelFatDocsCancelados.pImpDetalhe(Excel: TExcel; Dados: TDataSet; Campos: TCampos; CorFundo: TCorExcel);
var strPriCmp, strCliCmp, strVenCmp, strUltCmp: String;
Begin

  Excel.ProximaLinha;
  Excel.Escrever(Excel.LinhaAtual, Campos.ColunaPorNome['DTADEL'].Coluna, Dados.FieldByName('MOTDEL').AsString);
  Excel.Escrever(Excel.LinhaAtual, Campos.ColunaPorNome['CODVEN'].Coluna, Dados.FieldByName('NOMOPE').AsString);

  strPriCmp := 'A' + IntToStr(Excel.LinhaAtual);
  strCliCmp := fGetLetraAlfa(Campos.ColunaPorNome['NOMCLI'].Coluna) + IntToStr(Excel.LinhaAtual);
  strVenCmp := fGetLetraAlfa(Campos.ColunaPorNome['CODVEN'].Coluna) + IntToStr(Excel.LinhaAtual);
  strUltCmp := fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(Excel.LinhaAtual);

  Excel.Mesclar(strPriCmp, strCliCmp);
  Excel.Mesclar(strVenCmp, strUltCmp);

  Excel.Alinhamento(strPriCmp, strUltCmp, Esquerda);
  Excel.CorFundo(strPriCmp, strUltCmp, CorFundo);
  Excel.Bordas(strPriCmp, strUltCmp);
End;

procedure TfrmRelFatDocsCancelados.pImpFiltros(Excel: TExcel; Dados: TDataSet; Campos: TCampos; Filtros: array of String);
var intLinha: Integer;
begin
  For intLinha := 0 to Length(Filtros) -1 Do
     Excel.Alinhamento('A' + IntToStr(Excel.LinhaAtual -intLinha), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(Excel.LinhaAtual -intLinha), Centro);
End;

procedure TfrmRelFatDocsCancelados.pImpTitColuna(Excel: TExcel; Campos: TCampos);
var strPriCmp, strUltCmp: String;
Begin
  Excel.ProximaLinha;
  Excel.Escrever(Excel.LinhaAtual, Campos.ColunaPorNome['DTADEL'].Coluna, 'MOTIVO');
  strPriCmp := 'A'+ IntToStr(Excel.LinhaAtual);
  strUltCmp := fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(Excel.LinhaAtual);
  Excel.CorFundo(strPriCmp, strUltCmp, Preto);
  Excel.CorFonte(strPriCmp, strUltCmp, Branco);
  Excel.Negrito(strPriCmp, strUltCmp, True);
  Excel.Bordas(strPriCmp, strUltCmp);
End;

procedure TfrmRelFatDocsCancelados.pMontaResumo(Excel: TExcel; Campos: TCampos;
  Quebra: TRecQuebras);
begin
  If Quebra.NomeCampo = '[GERAL]' Then
  Begin
    With Excel Do
    Begin

      Escrever(ProximaLinha, 01, 'TOTAL: ');
      Escrever(LinhaAtual, Campos.ColunaPorNome['VLRCON'].Coluna, FormatFloat('#,##0.00', Quebra.Totais['VLRCON']));

      CorFundo('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Amarelo);
      CorFonte('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Azul);

      Negrito('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True);
      Bordas('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
      Alinhamento('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Direita);

      Mesclar('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count-1) + IntToStr(LinhaAtual));
      Alinhamento('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count-1) + IntToStr(LinhaAtual), Esquerda);

    End;
  End;
end;

procedure TfrmRelFatDocsCancelados.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If key = VK_RETURN Then
    If (ActiveControl Is TRadioGroup) or (ActiveControl Is TRadioButton) Then
    Begin
      pProximoControle(Sender);
    End;

end;

procedure TfrmRelFatDocsCancelados.chkVendaClick(Sender: TObject);
begin
  inherited;
  If chkVenda.Checked Then chkCompra.Checked := False;
end;

procedure TfrmRelFatDocsCancelados.chkCompraClick(Sender: TObject);
begin
  inherited;
  If chkCompra.Checked Then chkVenda.Checked := False;
end;

end.


