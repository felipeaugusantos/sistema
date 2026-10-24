unit untImportCatalogoPreco;

interface

uses
  Windows, Messages, System.SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Mask, DirectoryEditFocus, Uni, FilenameEditFocus, ComCtrls,
  StrUtils, ComObj, BitBtnLockedIncrem, frxClass, System.Math,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, cxButtons,
  MaskEditFocus, untZClient, untParCalculaPrecoCusto, untFatorPreco,
  cxProgressBar, Grids,untTValidaExcel;

Const
  arrSimNao : Array[0..1] Of String = ('Não', 'Sim');

type
  TTipoCampo = (tcCodIte, tcCodBar, tcCodFab, tcCodFor, tcPreCom, tcDesF01,
                tcDesF02, tcDesF03, tcDesF04, tcDesF05, tcDesF06, tcIcmEnt,
                tcSubFed, tcIpiEnt, tcFreEnt, tcValFre, tcAcrFin, tcSubSti,
                tcDesAbd, tcOutVal, tcIcmSai, tcImpFed, tcDesOpe,
                tcDesIte, tcPesBru, tcEmbala, tcClaIpi, tcCodMar, tcCodUni,
                tcRefere, tcAplica, tcPreDol, tcTCIFCu, tcTSCust, tcDePiCo,
                tcDeICMS, tcFatReg, tcCodAbf);
type
  TfrmImportCatalogoPreco = class(TfrmPai)
    gpbPath: TGroupBox;
    gpbDefinicao: TGroupBox;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    pgbGeral: TProgressBar;
    btnImporta: TBitBtnLocked;
    edtPath: TFilenameEditFocus;
    btnHlpImp: TBitBtnLocked;
    frxHelp: TfrxReport;
    Label1: TLabel;
    chkAtuPreCat: TCheckBox;
    chkCadNovCat: TCheckBox;
    chkExcProdCat: TCheckBox;
    gpbRecalcular: TGroupBox;
    rdbMargem: TRadioButton;
    rdbPreVen: TRadioButton;
    frxSuframa: TfrxReport;
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure btnImportaClick(Sender: TObject);
    procedure btnHlpImpClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkExcProdCatClick(Sender: TObject);
  private
    { Private declarations }
    Excel : Variant;
    blnArqCsv : Boolean;
    stlArqCsv : TStringList;
    stlLErros : TStringList;

    cdsItens : TZClient;

    cdsExclu : TZClient;
    qryLocIte : TUniQuery;
    qryLocCat : TUniQuery;
    qryCatIte : TUniQuery;
    arrValores: Array Of String;
    cpcParams: TParCalculaPrecoCusto;
    intDecUni: Integer;
    strMarMkp: String;
    strPcmPro: String;
    strCampo : String;

    dtaDtaAltera: TDate;
    blnVaiAtualizarItens : Boolean;

    strList   : TStringGrid;

    const cCodIte = 'A'; // 0
          cCodBar = 'B'; // 1
          cCodFab = 'C'; // 2
          cCodFor = 'D'; // 3
          cPrComp = 'E'; // 4
          cDesFo1 = 'F'; // 5
          cDesFo2 = 'G'; // 6
          cDesFo3 = 'H'; // 7
          cDesFo4 = 'I'; // 8
          cDesFo5 = 'J'; // 9
          cDesFo6 = 'K'; // 10
          cIcmEnt = 'L'; // 11
          cSubFed = 'M'; // 12
          cIpiEnt = 'N'; // 13
          cFrete_ = 'O'; // 14
          cVrFret = 'P'; // 15
          cAcrFin = 'Q'; // 16
          cSubSti = 'R'; // 17
          cDesAdc = 'S'; // 18
          cOutros = 'T'; // 19
          cIcmSai = 'U'; // 20
          cImpFed = 'V'; // 21
          cDesOpe = 'W'; // 22
          cDesIte = 'X'; // 23
          cPesBru = 'Y'; // 24
          cEmbala = 'Z'; // 25
          cClaIpi = 'AA';// 26
          cCodMar = 'AB';// 27
          cCodUni = 'AC';// 28
          cRefere = 'AD';// 29
          cAplica = 'AE';// 30
          cPreDol = 'AF';// 31
          cTCIFCu = 'AG';// 32
          cTSCust = 'AH';// 33
          cDePiCo = 'AI';// 34
          cDeICMS = 'AJ';// 35
          cFatReg = 'AK';// 36
          cCodAbf = 'AL';// 37

          iCodIte = 0;
          iCodBar = 1;
          iCodFab = 2;
          iCodFor = 3;
          iPreCom = 4;
          iDesF01 = 5;
          iDesF02 = 6;
          iDesF03 = 7;
          iDesF04 = 8;
          iDesF05 = 9;
          iDesF06 = 10;
          iIcmEnt = 11;
          iSubFed = 12;
          iIpiEnt = 13;
          iFreEnt = 14;
          iValFre = 15;
          iAcrFin = 16;
          iSubSti = 17;
          iDesAdc = 18;
          iOutVal = 19;
          iIcmSai = 20;
          iImpFed = 21;
          iDesOpe = 22;
          iDesIte = 23;
          iPesoIt = 24;
          iEmbala = 25;
          iClaIpi = 26;
          iCodMar = 27;
          iCodUni = 28;
          iRefere = 29;
          iAplica = 30;
          iPreDol = 31;
          iTCIFCu = 32;
          iTSCust = 33;
          iDePiCo = 34;
          iDeICMS = 35;
          iFatReg = 36;
          iCodAbf = 37;

    function  fRetPrecoCusto(fltPreCom,
                             fltDesF01,
                             fltDesF02,
                             fltDesF03,
                             fltDesF04,
                             fltDesF05,
                             fltDesF06,
                             fltICMEnt,
                             fltSubFed,
                             fltIpiEnt,
                             fltFreEnt,
                             fltAcrFin,
                             fltSubsti,
                             fltDesAdb,
                             fltVrFret: Double;
                             blnPreDol: Boolean;
                             fltTCIFCu,
                             fltTSCust,
                             fltDePiCo,
                             fltDeICMS,
                             fltFatReg: Double): Double;

    function fSelectBase(blnExcLin: Boolean): string;
    procedure pCriarCds;
    procedure pInsereCatCDS(intLinha :Integer);
    procedure pCalcularPrecos;
    procedure pGetCodigos(Var strCodIte, strCodBar, strCodFor, strCodFab: String; intLinha: Integer);
    function fLocCat(intLinha: Integer): Boolean;
    function fGetCampoCSV(tcCampo: TTipoCampo; intLinha: Integer): Variant;
    procedure pCarregaExclusoes;
    procedure pIncluirExclusaoDeLinha;
    procedure pCarregaLocIte;
    procedure pSetaAtivoParaComprasNao(strCodIte, strCodBar, strCodFor, strCodFab: String);
    procedure pDeletaCatalogo(strAutInc: String);
    procedure pAtualizarPrecoCatalogo(strAutInc: String);
    procedure pAtivaCatalogoNaoAtivo(strAutInc: String);
    function fConfirmaData: Boolean;
    function fConfirmarImportacao(pgbProgresso: TcxProgressBar): Boolean;
    function fProcessarImportacaoItem: Boolean;
    function fValidarAbvFiscal: boolean;
    procedure pGravaPreIteCat;
    procedure pAtualizaDadosInformativosDoCatalogo(strAutInc: String);
    procedure pAtualizaDadosInformativosDoProduto(strCodIte: String);
    function XlsToStringGrid (AGrid :TStringGrid; AXLSFile :String) :boolean;
  protected
    FLog: TStringList;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fExisteRegistro(strCodigo, strTabela, strCampoCodigo: String): Boolean;
  public
    { Public declarations }
    qryConsulta: TUniQuery;
    strSelect : String;
  end;

var
  frmImportCatalogoPreco: TfrmImportCatalogoPreco;

implementation

uses DB, untFuncoesSimples, untConsultas, untTConfiguracao, untTypesSistema,
     untImportCatalogoPrecoConfirma, untPreAlt, untAltPrecoDigData, untGravando,
  untAltEfetivacaoPrecos, untMensagemExplicativa, untIteBar;

{$R *.dfm}

function TfrmImportCatalogoPreco.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;
  Try
    If (inherited fValidaCampos(Sender)) Then
    Begin
      If (Sender = edtCodFor) Then
      Begin
        If (fEmptyStr(edtCodFor.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Código do Fornecedor deve ser preenchido!', ['&OK']);
          Result := False;
        End
        Else
        Begin
          edtNomFor.Text := fRetNomFornecedor(edtCodFor.Text);
          If fEmptyStr(edtNomFor.Text) Then
          Begin
            fMensagem('AVISO','Código do Fornecedor não encontrado.', ['&OK']);
            Result := False;
          End;
        End;
      End

      Else If (Sender = edtPath) Then
      Begin
        If fEmptyStr(edtPath.Text) Then
        Begin
          fMensagem('AVISO', 'O caminho do arquivo deve ser preenchido!', ['&OK']);
          Result := False;
        End
        Else If (Not FileExists(edtPath.Text)) Then
        Begin
          fMensagem('AVISO', 'Arquivo não encontrado: ' + edtPath.Text + ' !', ['&OK']);
          Result := False;
        End;
      End;
    End;
  Except
    On E: Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmImportCatalogoPreco.fValidaCampos]');
      Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmImportCatalogoPreco.fValidarAbvFiscal: boolean;
var
  strCodAbf: String;
begin
  If Not chkCadNovCat.Checked Then
    Exit(True);

  cdsItens.First;
  While not cdsItens.Eof Do
  Begin
    strCodAbf := cdsItens.FieldByName('CAT_CODABF').AsString;

    If (Not fEmptyStr(strCodAbf)) And fEmptyStr(fCampoTabela('ABF_CODABF', 'ABFICM', ['ABF_CODABF'], [strCodAbf])) Then
    Begin
      fMensagem('', 'A abreviação fiscal ' + QuotedStr(strCodAbf) +' da (coluna AL) não foi encontrada no sistema. Verifique o manual de importação',['&Ok']);
      Exit(False);
    End;

    cdsItens.Next;
  End;

  Result := True;
end;

procedure TfrmImportCatalogoPreco.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmImportCatalogoPreco.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtPath);
end;

procedure TfrmImportCatalogoPreco.FormCreate(Sender: TObject);
begin
  inherited;
  FLog := TStringList.Create;
  stlLErros := TStringList.Create;
  edtPath.Dialog.Dialog.Filter := 'Arquivos Suportados|*.xls;*.xlsx;*.csv';
  cpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao);

  intDecUni := fCfgSis('DECUNI', varInteger);
  strMarMkp := fCfgSis('MARMKP');
  strPcmPro := fCfgSis('PCMPRO');

  cdsItens := Nil;
  cdsExclu := Nil;
  qryLocIte := fCriaQuery(Self);

  qryLocCat := fCriaQuery(Self);
  qryCatIte := fCriarQuery('SELECT * FROM CATITE WHERE FALSE', Self);
  qryCatIte.Open;

  SetLength(arrValores, 38);
  qryConsulta:= fCriaQuery;
end;

procedure TfrmImportCatalogoPreco.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FLog);
  FreeAndNil(qryLocCat);
  FreeAndNil(qryConsulta);

  SetLength(arrValores, 0);

  If Assigned(cdsExclu) Then
    FreeAndNil(cdsExclu);

  If Assigned(cdsItens) Then
    FreeAndNil(cdsItens);

  FreeAndNil(qryLocIte);

  qryCatIte.Close;
  FreeAndNil(qryCatIte);

  If Assigned(stlLErros) Then
    FreeAndNil(stlLErros);
end;

procedure TfrmImportCatalogoPreco.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaLocIte;
end;

procedure TfrmImportCatalogoPreco.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
  begin
    frxSuframa.DotMatrixReport := False;
    frxSuframa.PrintOptions.PrintMode := pmScale;
    frxSuframa.PrintOptions.PrintOnSheet := 9;
    pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxSuframa);
  end
  else
  begin
    frxHelp.DotMatrixReport := False;
    frxHelp.PrintOptions.PrintMode := pmScale;
    frxHelp.PrintOptions.PrintOnSheet := 9;
    pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxHelp);
  end;
end;

procedure TfrmImportCatalogoPreco.btnImportaClick(Sender: TObject);
  Var
    intContador : Integer;
    intValIni : Integer;
    dteInicio, dteFim: TDateTime;
    objValidaExcel : TValidadorExcel;
    strNomeArquivo: string;
begin
  inherited;

  If Not fVerificaCampos Then
    Exit;

  btnImporta.Enabled := False;
  btnSair.Enabled := False;
  btnHlpImp.Enabled := False;
  edtPath.Enabled := False;
  edtCodFor.Enabled := False;
  gpbRecalcular.Enabled := False;
  blnVaiAtualizarItens := False;
  pnlInfo.Caption := 'Aguarde... Importando Catálogo de Preço...';
  Try
    Try
      If chkExcProdCat.Checked Then
        pCarregaExclusoes;

      edtPath.Text := AnsiReplaceStr(edtPath.Text,'"','');
      pCriarCds;

      //Este processo ira trocar o arquivo xls por um arquivo csv
      objValidaExcel := TValidadorExcel.Create(edtPath.Text,0,'','');
      Try
        strNomeArquivo := objValidaExcel.NomeArquivo;
        blnArqCsv := Copy(strNomeArquivo, Length(strNomeArquivo)-2, 3) = 'csv';

        If Not blnArqCsv Then
        Begin
          {**************************************}
          {* ABRE EXCEL E ARQUIVO XLS           *}
          {***********************************LU*}
          Excel := CreateOleObject('Excel.Application');
          Excel.Visible       := False;
          Excel.DisplayAlerts := False;
          Excel.WorkBooks.Open(Filename := edtPath.Text);

          {****************************************}
          {* VAI PARA A ULTIMA CELULA COM DADOS   *}
          {* PARA PEGAR A QUANTIDADE DE REGISTROS *}
          {*************************************LU*}

          {xlCellTypeLastCell. A última célula no intervalo usado}
          Excel.Selection.SpecialCells(11).Select;

          pgbGeral.Max := Excel.ActiveCell.Row -1;

          strList := TStringGrid.Create(Self);
          XlsToStringGrid(strList, edtPath.Text);
        End
        Else
        Begin
          stlArqCsv := TStringList.Create;
          stlArqCsv.LoadFromFile(strNomeArquivo);
          pgbGeral.Max := stlArqCsv.Count;
        End;

        pgbGeral.Position := 0;

        cdsItens.EmptyDataSet;

        If objValidaExcel.fTemTitulo(cCodIte) Then
          intValIni := 2
        Else
          intValIni := 1;

        pgbGeral.Position := 0;

        dteInicio := fNow();

        For intContador := intValIni To (pgbGeral.Max +1) Do
        Begin
          If blnArqCsv Then
          Begin
            If intContador > stlArqCsv.Count Then
              Continue;
          End;

          pInsereCatCDS(intContador);
          pgbGeral.StepBy(1);

          dteFim := fNow();

          pnlInfo.Caption := 'Importando Catálogo de Preço: ' + IntToStr(intContador) + ' de ' + IntToStr(pgbGeral.Max + 1)
            + ' - Tempo Restante: '
            + IntToStr(Trunc((pgbGeral.Max-IntContador)/(intcontador / ((((dteFim - dteInicio) * 86400)) / 60))+1)) +' min. (' +IntToStr(Trunc((intcontador / ((((dteFim - dteInicio) * 86400)) / 60)))) +'/min)';

          pnlInfo.Refresh;
        End;

        Try
          pIncluirExclusaoDeLinha;

          If (Not cdsItens.IsEmpty) Then
          Begin

            If Not fValidarAbvFiscal Then
              Exit;

            pCriarFormularios(TfrmImportCatalogoPrecoConfirma, frmImportCatalogoPrecoConfirma);
            frmImportCatalogoPrecoConfirma.edtCodFor.Text    := edtCodFor.Text;
            frmImportCatalogoPrecoConfirma.edtNomFor.Text    := edtNomFor.Text;
            frmImportCatalogoPrecoConfirma.edtArquivo.Text   := edtPath.Text;
            frmImportCatalogoPrecoConfirma.dtsDados.DataSet  := cdsItens;
            frmImportCatalogoPrecoConfirma.stlLErrosRel.Text := stlLErros.Text;
            frmImportCatalogoPrecoConfirma.ShowModal;
            If (frmImportCatalogoPrecoConfirma.blnConfirma) Then
            Begin
              If (Not blnVaiAtualizarItens) Or (fConfirmaData) then
              Begin
                Try
                  Try
                    pCriarFormularios(TfrmGravando, frmGravando);
                    frmGravando.fExecutarAcao := fConfirmarImportacao;
                    frmGravando.lblGravando.Caption := 'Aguarde... Processando Informações.';
                    frmGravando.ShowModal;

                    If (blnVaiAtualizarItens) Then
                    Begin
                      pCriarFormularios(TfrmAltEfetivacaoPrecos, frmAltEfetivacaoPrecos);
                      frmAltEfetivacaoPrecos.ShowModal;
                    End;

                    If (frmGravando.blnConfirma) Then
                    Begin
                      SetForegroundWindow(Handle);
                      fMensagem('Aviso', 'Importação concluída com sucesso!', ['&OK']);
                    End;
                  Except
                    On E: Exception Do
                    Begin
                      pMensagensErro(E.Message, '[TfrmImportCatalogoPreco.btnImportaClick]');
                    End;
                  End;
                Finally
                  pFreeAndNil(frmGravando);
                  If (blnVaiAtualizarItens) Then
                    pFreeAndNil(frmAltEfetivacaoPrecos);
                End;
              End;
            End;
            cdsItens.Close;
          End;
        Finally
          pFreeAndNil(frmImportCatalogoPrecoConfirma);
        End;
      Finally
        FreeAndNil(objValidaExcel);
      End;

    Except
      On E: Exception Do
        pMensagensErro(E.Message,'[TfrmImportCatalogoPreco.btnImportaClick]');
    End;
  Finally
    btnHlpImp.Enabled := True;
    btnImporta.Enabled := True;
    btnSair.Enabled := True;
    edtPath.Enabled := True;
    edtCodFor.Enabled := True;
    gpbRecalcular.Enabled := True;
    pnlInfo.Caption := '';
    pgbGeral.Position := 0;

    If (Not blnArqCsv) Then
    Begin
      Excel.WorkBooks.Close;
      Excel.Quit;
    End;

    pSetFocus(btnSair);
  End;
end;

procedure TfrmImportCatalogoPreco.chkExcProdCatClick(Sender: TObject);
begin
  inherited;
  If chkExcProdCat.Checked Then
    fMensagem('ATENÇÃO!', 'Ao marcar essa opção os itens do fornecedor que não estiverem no arquivo (Excel ou CSV) serão deletados do catálogo, no caso dos catálogos ativos, seus respectivos itens serão marcados como "Inativo para Compras"!', ['&OK']);
end;

function TfrmImportCatalogoPreco.fRetPrecoCusto(fltPreCom, fltDesF01, fltDesF02,
  fltDesF03, fltDesF04, fltDesF05, fltDesF06, fltICMEnt, fltSubFed, fltIpiEnt,
  fltFreEnt, fltAcrFin, fltSubsti, fltDesAdb, fltVrFret: Double; blnPreDol: Boolean;
  fltTCIFCu, fltTSCust, fltDePiCo, fltDeICMS, fltFatReg: Double): Double;
begin
  Try
    With cpcParams Do
    Begin
      curPreCom := fltPreCom;
      curDesF01 := fltDesF01;
      curDesF02 := fltDesF02;
      curDesF03 := fltDesF03;
      curDesF04 := fltDesF04;
      curDesF05 := fltDesF05;
      curDesF06 := fltDesF06;
      curICMSEnt:= fltICMEnt;
      curIPIEnt := fltIpiEnt;
      curFrete  := fltFreEnt;
      curAcrFin := fltAcrFin;
      curSubsti := fltSubsti;
      curDesAdb := fltDesAdb;
      curSubFed := fltSubFed;
      curValFre := fltVrFret;

      if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
      begin
        curTCIFCu := fltTCIFCu;
        curTSCust := fltTSCust;
        curDePiCo := fltDePiCo;
        curDeICMS := fltDeICMS;
        curFatReg := fltFatReg;
      end
      else
      begin
        curTCIFCu := 0;
        curTSCust := 0;
        curDePiCo := 0;
        curDeICMS := 0;
        curFatReg := 0;
      end;
    End;

    Result := cpcParams.fCalculaPrecoCusto(blnPreDol);

  Finally

  End;
end;

function TfrmImportCatalogoPreco.fSelectBase(blnExcLin: Boolean): string;
begin
  Result := '';
  Result := Result + ' CATITE.AUTOINCREM AS AUTINC, ';
  Result := Result + ' CAT_CODITE, ';
  Result := Result + ' CAT_CODFOR, ';
  Result := Result + ' CAT_CODFAB, ';
  Result := Result + ' CAT_DESITE, ';
  Result := Result + ' CAT_CODBAR, ';
  Result := Result + ' CAT_REFERE, ';
  Result := Result + ' CAT_APLICA, ';
  Result := Result + ' CAT_ITEALT, ';
  Result := Result + ' CAT_HORALT, ';
  Result := Result + ' CAT_DTAALT, ';
  Result := Result + ' CAT_ICMENT, ';
  Result := Result + ' CAT_IPIENT, ';
  Result := Result + ' CAT_FREENT, ';
  Result := Result + ' CAT_VALFRE, ';
  Result := Result + ' CAT_ACRFIN, ';
  Result := Result + ' CAT_SUBSTI, ';
  Result := Result + ' CAT_ICMSAI, ';
  Result := Result + ' CAT_PRECOM, ';
  Result := Result + ' CAT_PRECUS, ';
  Result := Result + ' CAT_COMVAR, ';
  Result := Result + ' CAT_PESOIT, ';
  Result := Result + ' CAT_EMBALA, ';
  Result := Result + ' CAT_OPEALT, ';
  Result := Result + ' CAT_HORATI, ';
  Result := Result + ' CAT_DTAATI, ';
  Result := Result + ' CAT_OPEATI, ';
  Result := Result + ' CAT_ITEPRO, ';
  Result := Result + ' CAT_PREORI, ';
  Result := Result + ' CAT_CODUNI, ';
  Result := Result + ' CAT_CLAIPI, ';
  Result := Result + ' CAT_CPRCEN, ';
  Result := Result + ' CAT_CODABF, ';
  Result := Result + ' CAT_CODMAR, ';
  Result := Result + ' CAT_BAREMB, ';
  Result := Result + ' CAT_MLTCOM, ';
  Result := Result + ' CAT_MLTVEN, ';
  Result := Result + ' CAT_PESLIQ, ';
  Result := Result + ' CAT_DESMAX, ';
  Result := Result + ' CAT_DESMGE, ';
  Result := Result + ' CAT_DESMSU, ';
  Result := Result + ' CAT_MARMIN, ';
  Result := Result + ' CAT_SUBFED, ';
  Result := Result + ' CAT_DESADB, ';
  Result := Result + ' CAT_PREDOL, ';
  Result := Result + ' CAT_IMPFED, ';
  Result := Result + ' CAT_OUTVAL, ';
  Result := Result + ' CAT_DESOPE, ';

  Result := Result + ' CAT_DESF01, ';
  Result := Result + ' CAT_DESF02, ';
  Result := Result + ' CAT_DESF03, ';
  Result := Result + ' CAT_DESF04, ';
  Result := Result + ' CAT_DESF05, ';
  Result := Result + ' CAT_DESF06, ';

  Result := Result + ' CAT_COMTB1, ';
  Result := Result + ' CAT_COMTB2, ';
  Result := Result + ' CAT_COMTB3, ';
  Result := Result + ' CAT_COMTB4, ';
  Result := Result + ' CAT_COMTB5, ';
  Result := Result + ' CAT_COMTB6, ';
  Result := Result + ' CAT_COMTB7, ';

  Result := Result + ' CAT_PREVE1, ';
  Result := Result + ' CAT_PREVE2, ';
  Result := Result + ' CAT_PREVE3, ';
  Result := Result + ' CAT_PREVE4, ';
  Result := Result + ' CAT_PREVE5, ';
  Result := Result + ' CAT_PREVE6, ';
  Result := Result + ' CAT_PREVE7, ';

  Result := Result + ' CAT_MARBR1, ';
  Result := Result + ' CAT_MARBR2, ';
  Result := Result + ' CAT_MARBR3, ';
  Result := Result + ' CAT_MARBR4, ';
  Result := Result + ' CAT_MARBR5, ';
  Result := Result + ' CAT_MARBR6, ';
  Result := Result + ' CAT_MARBR7, ';

  If (blnExcLin) Then
  Begin
    Result := Result + ' "' + arrSimNao[0] + '" AS NVOCAT, ';
    Result := Result + ' "' + arrSimNao[1] + '" AS EXCLIN, ';
    Result := Result + ' "' + arrSimNao[0] + '" AS ATPRCT, ';
    Result := Result + ' "' + arrSimNao[0] + '" AS ATPRIT, ';
    Result := Result + ' "' + arrSimNao[0] + '" AS CATATI, ';
  End
  Else
  Begin
    Result := Result + ' "   " AS NVOCAT, ';
    Result := Result + ' "   " AS EXCLIN, ';
    Result := Result + ' "   " AS ATPRCT, ';
    Result := Result + ' "   " AS ATPRIT, ';
    Result := Result + ' IF(CAT_DTAATI IS NULL, "' + arrSimNao[0] + '", "' + arrSimNao[1] + '") AS CATATI, ';
  End;

  Result := Result + ' 0     AS LINEXC,  ';
  Result := Result + ' CAT_CODMAR, ';
  Result := Result + ' CAT_CODUNI, ';
  Result := Result + ' CAT_TCIFCU, ';
  Result := Result + ' CAT_TSCUST, ';
  Result := Result + ' CAT_DEPICO, ';
  Result := Result + ' CAT_DEICMS, ';
  Result := Result + ' CAT_FATREG  ';
end;

procedure TfrmImportCatalogoPreco.pCriarCds;
  Var
    strSql: String;
begin
  strSql := '';
  strSql := strSql + 'SELECT ';
  strSql := strSql + fSelectBase(False);
  strSql := strSql + ',0 AS SITFOR '; //Situação do Fornecedor
  strSql := strSql + ',0 AS SITMAR '; //Situação da Marca
  strSql := strSql + ',0 AS SITUNI '; //Situação da Unidade

  strSql := strSql + '  FROM CATITE ';
  strSql := strSql + ' WHERE FALSE ';

  If Assigned(cdsItens) Then
    FreeAndNil(cdsItens);

  cdsItens := TZClient.Create(Self, strSql);
  cdsItens.fAbreClient(True,'[TfrmImportCatalogoPreco.pCriarCds]');
  cdsItens.IndexFieldNames := 'CAT_CODFOR;CAT_CODFAB;LINEXC';
end;

procedure TfrmImportCatalogoPreco.pDeletaCatalogo(strAutInc: String);
  Var
    qryDelete : TUniQuery;
begin
  qryDelete := fCriaQuery(Self);
  Try
    qryDelete.Close;
    qryDelete.SQL.Clear;
    qryDelete.SQL.Add('DELETE FROM CATITE WHERE AUTOINCREM = :AUTINC ');
    qryDelete.ParamByName('AUTINC').AsString := strAutInc;
    qryDelete.ExecSQL;
  Finally
    FreeAndNil(qryDelete);
  End;
end;

procedure TfrmImportCatalogoPreco.pInsereCatCDS(intLinha: Integer);
  Var
    intCnt: Integer;
    blnVerCadIte : Boolean;
begin
  Try
    cdsItens.Append;

    cdsItens.FieldByName('LINEXC').AsInteger := intLinha;

    If fLocCat(intLinha) Then
    Begin
      If (Not chkAtuPreCat.Checked) Then
      Begin
        cdsItens.Cancel;
        Exit;
      End;

      For intCnt := 0 to qryLocCat.Fields.Count -1 Do
      Begin
        If (cdsItens.FindField(qryLocCat.Fields[intCnt].FieldName) <> Nil) Then
          cdsItens.FieldByName(qryLocCat.Fields[intCnt].FieldName).Value := qryLocCat.Fields[intCnt].Value;
      End;

      cdsItens.FieldByName('NVOCAT').AsString := arrSimNao[0]; //---> NOVO CATALOGO                = NAO
      cdsItens.FieldByName('EXCLIN').AsString := arrSimNao[0]; //---> EXCLUSAO FORA LINHA          = NAO
      cdsItens.FieldByName('ATPRCT').AsString := arrSimNao[1]; //---> ATUALIZAR PRECO CATALOGO     = SIM

      If (qryLocCat.FieldByName('CATATI').AsString = arrSimNao[1]) Then
      Begin
        cdsItens.FieldByName('CATATI').AsString := arrSimNao[1]; //---> ATIVADO NO CAD.PRODUTOS      = SIM
        cdsItens.FieldByName('ATPRIT').AsString := arrSimNao[1]; //---> ATUALIZAR PRECO CAD.PRODUTOS = SIM
      End
      Else
      Begin
        cdsItens.FieldByName('CATATI').AsString := arrSimNao[0]; //---> ATIVADO NO CAD.PRODUTOS      = NAO
        cdsItens.FieldByName('ATPRIT').AsString := arrSimNao[0]; //---> ATUALIZAR PRECO CAD.PRODUTOS = NAO
      End;
    End
    Else
    Begin
      If (Not chkCadNovCat.Checked) Then
      Begin
        If FLog.Count > 0 Then
        Begin
          Try
            pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);
            frmMensagemExplicativa.mmoInstru.Lines.Text := FLog.Text;
            frmMensagemExplicativa.Width := 1000;
            frmMensagemExplicativa.Showmodal;
            FLog.Clear;
          Finally
            FreeAndNil(frmMensagemExplicativa);
          End;
        End;

        cdsItens.Cancel;
        Exit;
      End;

      cdsItens.FieldByName('NVOCAT').AsString := arrSimNao[1]; //---> NOVO CATALOGO                = SIM
      cdsItens.FieldByName('EXCLIN').AsString := arrSimNao[0]; //---> EXCLUSAO FORA LINHA          = NAO
      cdsItens.FieldByName('ATPRCT').AsString := arrSimNao[1]; //---> ATUALIZAR PRECO CATALOGO     = SIM
      cdsItens.FieldByName('CATATI').AsString := arrSimNao[0]; //---> ATIVADO NO CAD.PRODUTOS      = NAO
      cdsItens.FieldByName('ATPRIT').AsString := arrSimNao[0]; //---> ATUALIZAR PRECO CAD.PRODUTOS = NAO

      If Not blnArqCsv Then
      Begin
        cdsItens.FieldByName('CAT_CODITE').AsString := strList.Cells[iCodIte, intLinha - 1];
        cdsItens.FieldByName('CAT_CODFOR').AsString := strList.Cells[iCodFor, intLinha - 1];
        cdsItens.FieldByName('CAT_CODBAR').AsString := strList.Cells[iCodBar, intLinha - 1];
        cdsItens.FieldByName('CAT_CODFAB').AsString := strList.Cells[iCodFab, intLinha - 1];
      End
      Else
      Begin
        cdsItens.FieldByName('CAT_CODITE').AsString := fGetCampoCSV(tcCodIte, intLinha);
        cdsItens.FieldByName('CAT_CODFOR').AsString := fGetCampoCSV(tcCodFor, intLinha);
        cdsItens.FieldByName('CAT_CODBAR').AsString := fGetCampoCSV(tcCodBar, intLinha);
        cdsItens.FieldByName('CAT_CODFAB').AsString := fGetCampoCSV(tcCodFab, intLinha);
      End;

      If (fEmptyStr( cdsItens.FieldByName('CAT_CODITE').AsString +
                     cdsItens.FieldByName('CAT_CODFOR').AsString +
                     cdsItens.FieldByName('CAT_CODBAR').AsString +
                     cdsItens.FieldByName('CAT_CODFAB').AsString )) Then
      Begin
        cdsItens.Cancel;
        Exit;
      End;
    End;

    If (Not blnArqCsv) Then
    Begin
      If Not fEmptyStr(strList.Cells[iCodBar, intLinha - 1]) Then
        cdsItens.FieldByName('CAT_CODBAR').AsString := strList.Cells[iCodBar, intLinha - 1];

      If Not fEmptyStr(strList.Cells[iAcrFin, intLinha - 1]) Then
        cdsItens.FieldByName('CAT_ACRFIN').AsFloat := fStrToFloat(strList.Cells[iAcrFin, intLinha - 1]);

      If Not fEmptyStr(strList.Cells[iSubSti, intLinha - 1]) Then
        cdsItens.FieldByName('CAT_SUBSTI').AsFloat := fStrToFloat(strList.Cells[iSubSti, intLinha - 1]);

      If Not fEmptyStr(strList.Cells[iDesAdc, intLinha - 1]) Then
        cdsItens.FieldByName('CAT_DESADB').AsFloat := fStrToFloat(strList.Cells[iDesAdc, intLinha - 1]);

      If Not fEmptyStr(strList.Cells[iOutVal, intLinha - 1]) Then
        cdsItens.FieldByName('CAT_OUTVAL').AsFloat := fStrToFloat(strList.Cells[iOutVal, intLinha - 1]);

      If Not fEmptyStr(strList.Cells[iIcmSai, intLinha - 1]) Then
        cdsItens.FieldByName('CAT_ICMSAI').AsFloat := fStrToFloat(strList.Cells[iIcmSai, intLinha - 1]);

      If Not fEmptyStr(strList.Cells[iSubFed, intLinha - 1]) Then
        cdsItens.FieldByName('CAT_SUBFED').AsFloat := fStrToFloat(strList.Cells[iSubFed, intLinha - 1]);

      If Not fEmptyStr(strList.Cells[iImpFed, intLinha - 1]) Then
        cdsItens.FieldByName('CAT_IMPFED').AsFloat := fStrToFloat(strList.Cells[iImpFed, intLinha - 1]);

      If Not fEmptyStr(strList.Cells[iDesOpe, intLinha - 1]) Then
        cdsItens.FieldByName('CAT_DESOPE').AsFloat := fStrToFloat(strList.Cells[iDesOpe, intLinha - 1]);

      If Not fEmptyStr(strList.Cells[iPreCom, intLinha - 1]) Then
        cdsItens.FieldByName('CAT_PRECOM').AsFloat := fStrToFloat(strList.Cells[iPreCom, intLinha - 1]);

      If Not fEmptyStr(strList.Cells[iDesF01, intLinha - 1]) Then
        cdsItens.FieldByName('CAT_DESF01').AsFloat := fStrToFloat(strList.Cells[iDesF01, intLinha - 1]);

      If Not fEmptyStr(strList.Cells[iDesF02, intLinha - 1]) Then
        cdsItens.FieldByName('CAT_DESF02').AsFloat := fStrToFloat(strList.Cells[iDesF02, intLinha - 1]);

      If Not fEmptyStr(strList.Cells[iDesF03, intLinha - 1]) Then
        cdsItens.FieldByName('CAT_DESF03').AsFloat := fStrToFloat(strList.Cells[iDesF03, intLinha - 1]);

      If Not fEmptyStr(strList.Cells[iDesF04, intLinha - 1]) Then
        cdsItens.FieldByName('CAT_DESF04').AsFloat := fStrToFloat(strList.Cells[iDesF04, intLinha - 1]);

      If Not fEmptyStr(strList.Cells[iDesF05, intLinha - 1]) Then
        cdsItens.FieldByName('CAT_DESF05').AsFloat := fStrToFloat(strList.Cells[iDesF05, intLinha - 1]);

      If Not fEmptyStr(strList.Cells[iDesF06, intLinha - 1]) Then
        cdsItens.FieldByName('CAT_DESF06').AsFloat := fStrToFloat(strList.Cells[iDesF06, intLinha - 1]);

      If Not fEmptyStr(strList.Cells[iIcmEnt, intLinha - 1]) Then
        cdsItens.FieldByName('CAT_ICMENT').AsFloat := fStrToFloat(strList.Cells[iIcmEnt, intLinha - 1]);

      If Not fEmptyStr(strList.Cells[iIpiEnt, intLinha - 1]) Then
        cdsItens.FieldByName('CAT_IPIENT').AsFloat := fStrToFloat(strList.Cells[iIpiEnt, intLinha - 1]);

      If Not fEmptyStr(strList.Cells[iFreEnt, intLinha - 1]) Then
        cdsItens.FieldByName('CAT_FREENT').AsFloat := fStrToFloat(strList.Cells[iFreEnt, intLinha - 1]);

      If Not fEmptyStr(strList.Cells[iValFre, intLinha - 1]) Then
        cdsItens.FieldByName('CAT_VALFRE').AsFloat := fStrToFloat(strList.Cells[iValFre, intLinha - 1]);

      If Not fEmptyStr(strList.Cells[iDesIte, intLinha - 1]) Then
        cdsItens.FieldByName('CAT_DESITE').AsString := strList.Cells[iDesIte, intLinha - 1];

      If Not fEmptyStr(strList.Cells[iPesoIt, intLinha - 1]) Then
        cdsItens.FieldByName('CAT_PESOIT').AsFloat := fStrToFloat(strList.Cells[iPesoIt, intLinha - 1]);

      If Not fEmptyStr(strList.Cells[iEmbala, intLinha - 1]) Then
        cdsItens.FieldByName('CAT_EMBALA').AsFloat := fStrToFloat(strList.Cells[iEmbala, intLinha - 1]);

      If Not fEmptyStr(strList.Cells[iClaIpi, intLinha - 1]) Then
        cdsItens.FieldByName('CAT_CLAIPI').AsFloat := fStrToFloat(strList.Cells[iClaIpi, intLinha - 1]);

      If Not fEmptyStr(strList.Cells[iCodMar, intLinha - 1]) Then
        cdsItens.FieldByName('CAT_CODMAR').AsString := strList.Cells[iCodMar, intLinha - 1];

      If Not fEmptyStr(strList.Cells[iCodUni, intLinha - 1]) Then
        cdsItens.FieldByName('CAT_CODUNI').AsString := strList.Cells[iCodUni, intLinha - 1];

      If Not fEmptyStr(strList.Cells[iRefere, intLinha - 1]) Then
        cdsItens.FieldByName('CAT_REFERE').AsString := strList.Cells[iRefere, intLinha - 1];

      If Not fEmptyStr(strList.Cells[iAplica, intLinha - 1]) Then
        cdsItens.FieldByName('CAT_APLICA').AsString := strList.Cells[iAplica, intLinha - 1];

      If Not fEmptyStr(strList.Cells[iPredol, intLinha - 1]) Then
        cdsItens.FieldByName('CAT_PREDOL').AsString := strList.Cells[iPredol, intLinha - 1];

      If Not fEmptyStr(strList.Cells[iPredol, intLinha - 1]) Then
        cdsItens.FieldByName('CAT_TCIFCU').AsString := strList.Cells[iTCIFCu, intLinha - 1];

      If Not fEmptyStr(strList.Cells[iPredol, intLinha - 1]) Then
        cdsItens.FieldByName('CAT_TSCUST').AsString := strList.Cells[iTSCust, intLinha - 1];

      If Not fEmptyStr(strList.Cells[iPredol, intLinha - 1]) Then
        cdsItens.FieldByName('CAT_DEPICO').AsString := strList.Cells[iDePiCo, intLinha - 1];

      If Not fEmptyStr(strList.Cells[iPredol, intLinha - 1]) Then
        cdsItens.FieldByName('CAT_DEICMS').AsString := strList.Cells[iDeICMS, intLinha - 1];

      If Not fEmptyStr(strList.Cells[iPredol, intLinha - 1]) Then
        cdsItens.FieldByName('CAT_FATREG').AsString := strList.Cells[iFatReg, intLinha - 1];

      If Not fEmptyStr(strList.Cells[iPredol, intLinha - 1]) Then
        cdsItens.FieldByName('CAT_CODABF').AsString := strList.Cells[iFatReg, intLinha - 1];


    End
    Else
    Begin
      If fGetCampoCSV(tcCodBar, intLinha) <> '' Then
        cdsItens.FieldByName('CAT_CODBAR').Value := fGetCampoCSV(tcCodBar, intLinha);
      cdsItens.FieldByName('CAT_ACRFIN').Value := fGetCampoCSV(tcAcrFin, intLinha);
      cdsItens.FieldByName('CAT_SUBSTI').Value := fGetCampoCSV(tcSubSti, intLinha);
      cdsItens.FieldByName('CAT_DESADB').Value := fGetCampoCSV(tcDesAbd, intLinha);
      cdsItens.FieldByName('CAT_OUTVAL').Value := fGetCampoCSV(tcOutVal, intLinha);
      cdsItens.FieldByName('CAT_ICMSAI').Value := fGetCampoCSV(tcIcmSai, intLinha);
      cdsItens.FieldByName('CAT_SUBFED').Value := fGetCampoCSV(tcSubFed, intLinha);
      cdsItens.FieldByName('CAT_IMPFED').Value := fGetCampoCSV(tcImpFed, intLinha);
      cdsItens.FieldByName('CAT_DESOPE').Value := fGetCampoCSV(tcDesOpe, intLinha);
      cdsItens.FieldByName('CAT_PRECOM').Value := fGetCampoCSV(tcPreCom, intLinha);
      cdsItens.FieldByName('CAT_DESF01').Value := fGetCampoCSV(tcDesF01, intLinha);
      cdsItens.FieldByName('CAT_DESF02').Value := fGetCampoCSV(tcDesF02, intLinha);
      cdsItens.FieldByName('CAT_DESF03').Value := fGetCampoCSV(tcDesF03, intLinha);
      cdsItens.FieldByName('CAT_DESF04').Value := fGetCampoCSV(tcDesF04, intLinha);
      cdsItens.FieldByName('CAT_DESF05').Value := fGetCampoCSV(tcDesF05, intLinha);
      cdsItens.FieldByName('CAT_DESF06').Value := fGetCampoCSV(tcDesF06, intLinha);
      cdsItens.FieldByName('CAT_ICMENT').Value := fGetCampoCSV(tcIcmEnt, intLinha);
      cdsItens.FieldByName('CAT_IPIENT').Value := fGetCampoCSV(tcIpiEnt, intLinha);
      cdsItens.FieldByName('CAT_FREENT').Value := fGetCampoCSV(tcFreEnt, intLinha);
      cdsItens.FieldByName('CAT_VALFRE').Value := fGetCampoCSV(tcValFre, intLinha);
      cdsItens.FieldByName('CAT_DESITE').Value := fGetCampoCSV(tcDesIte, intLinha);
      cdsItens.FieldByName('CAT_PESOIT').Value := fGetCampoCSV(tcPesBru, intLinha);
      cdsItens.FieldByName('CAT_EMBALA').Value := fGetCampoCSV(tcEmbala, intLinha);
      cdsItens.FieldByName('CAT_CLAIPI').Value := fGetCampoCSV(tcClaIpi, intLinha);
      cdsItens.FieldByName('CAT_CODMAR').Value := fGetCampoCSV(tcCodMar, intLinha);
      cdsItens.FieldByName('CAT_CODUNI').Value := fGetCampoCSV(tcCodUni, intLinha);
      cdsItens.FieldByName('CAT_REFERE').Value := fGetCampoCSV(tcRefere, intLinha);
      cdsItens.FieldByName('CAT_APLICA').Value := fGetCampoCSV(tcAplica, intLinha);
      If fGetCampoCSV(tcPreDol, intLinha) <> null Then
        cdsItens.FieldByName('CAT_PREDOL').Value := fGetCampoCSV(tcPreDol, intLinha);
      cdsItens.FieldByName('CAT_TCIFCU').Value := fGetCampoCSV(tcTCIFCu, intLinha);
      cdsItens.FieldByName('CAT_TSCUST').Value := fGetCampoCSV(tcTSCust, intLinha);
      cdsItens.FieldByName('CAT_DEPICO').Value := fGetCampoCSV(tcDePiCo, intLinha);
      cdsItens.FieldByName('CAT_DEICMS').Value := fGetCampoCSV(tcDeICMS, intLinha);
      cdsItens.FieldByName('CAT_FATREG').Value := fGetCampoCSV(tcFatReg, intLinha);
      cdsItens.FieldByName('CAT_CODABF').Value := fGetCampoCSV(tcCodAbf, intLinha);


    End;

    blnVerCadIte := True;

    If fEmptyStr(cdsItens.FieldByName('CAT_CODITE').AsString) Then
    Begin
      qryLocIte.Filtered := False;
      qryLocIte.Filter := 'ITE_CODFOR = ' + QuotedStr(cdsItens.FieldByName('CAT_CODFOR').AsString) + ' AND ITE_CODFAB = ' + QuotedStr(cdsItens.FieldByName('CAT_CODFAB').AsString);
      qryLocIte.Filtered := True;

      If Not qryLocIte.IsEmpty Then
      Begin
        blnVerCadIte := False;
        cdsItens.FieldByName('CAT_CODITE').AsString := qryLocIte.FieldByName('ITE_CODITE').AsString;
      End;
    End;

    If (fEmptyStr(cdsItens.FieldByName('CAT_CODITE').AsString)) Then
      cdsItens.FieldByName('CAT_CODITE').Value := Null
    Else If (blnVerCadIte) Then
    Begin
      qryLocIte.Filtered := False;
      qryLocIte.Filter := 'ITE_CODITE = ' + QuotedStr(cdsItens.FieldByName('CAT_CODITE').AsString);
      qryLocIte.Filtered := True;

      If qryLocIte.IsEmpty Then
        cdsItens.FieldByName('CAT_CODITE').Value := Null;
    End;

    If (Not fEmptyStr(cdsItens.FieldByName('CAT_CODITE').AsString)) Then
    Begin
      cdsItens.FieldByName('CATATI').AsString := arrSimNao[1];
      cdsItens.FieldByName('ATPRIT').AsString := arrSimNao[1];
    End;

    pCalcularPrecos;

    If fEmptyStr(cdsItens.FieldByName('CAT_CODFOR').AsString) Then
      cdsItens.FieldByName('SITFOR').AsInteger := 1
    Else If Not(fExisteRegistro(cdsItens.FieldByName('CAT_CODFOR').AsString, 'CADFOR', 'FOR_CODFOR')) Then
      cdsItens.FieldByName('SITFOR').AsInteger := 2
    Else
      cdsItens.FieldByName('SITFOR').AsInteger := 0;

    If (Not fEmptyStr(cdsItens.FieldByName('CAT_CODMAR').AsString)) And
       (Not fExisteRegistro(cdsItens.FieldByName('CAT_CODMAR').AsString, 'CADMAR', 'MAR_CODMAR')) Then
      cdsItens.FieldByName('SITMAR').AsInteger := 1
    Else
      cdsItens.FieldByName('SITMAR').AsInteger := 0;

    If (Not fEmptyStr(cdsItens.FieldByName('CAT_CODUNI').AsString)) And
       (Not fExisteRegistro(cdsItens.FieldByName('CAT_CODUNI').AsString, 'CADUNI', 'UNI_CODUNI')) Then
      cdsItens.FieldByName('SITUNI').AsInteger := 1
    Else
      cdsItens.FieldByName('SITUNI').AsInteger := 0;

    cdsItens.Post;

    If (Not blnVaiAtualizarItens) Then
      blnVaiAtualizarItens := (cdsItens.FieldByName('ATPRIT').AsString = arrSimNao[1]);
  Except
    stlLErros.Add('Formato inválido na Linha: ' + fPadL(IntToStr(intLinha), 6, '0') + strCampo);
  End;
end;

procedure TfrmImportCatalogoPreco.pIncluirExclusaoDeLinha;
  Var
    intCnt : Integer;
begin
  If (Assigned(cdsExclu)) And (cdsExclu.Active) And (Not cdsExclu.IsEmpty) Then
  Begin
    cdsExclu.First;
    While Not cdsExclu.Eof Do
    Begin

      cdsItens.Append;
      For intCnt := 0 to cdsExclu.Fields.Count -1 do
        cdsItens.FieldByName(cdsExclu.Fields[intCnt].FieldName).Value := cdsExclu.Fields[intCnt].Value;
      cdsItens.Post;

      cdsExclu.Next;
    End;
  End;
end;

procedure TfrmImportCatalogoPreco.pSetaAtivoParaComprasNao(strCodIte, strCodBar,
  strCodFor, strCodFab: String);
  Var
    qryUpDate : TUniQuery;
begin
  qryUpDate := fCriaQuery(Self);
  Try
    qryUpDate.Close;
    qryUpDate.SQL.Clear;
    qryUpDate.SQL.Add('UPDATE CADITE SET ITE_ATICOM = "N" WHERE');

    If Not fEmptyStr(strCodIte) Then
    Begin
      qryUpDate.SQL.Add('ITE_CODITE = :CODITE');
      qryUpDate.ParamByName('CODITE').AsString := strCodIte;
      qryUpDate.ExecSQL;
    End

    Else If Not fEmptyStr(strCodBar) Then
    Begin
      qryUpDate.SQL.Add('ITE_CODBAR = :CODBAR');
      qryUpDate.ParamByName('CODBAR').AsString := strCodBar;
      qryUpDate.ExecSQL;
    End

    Else If (Not fEmptyStr(strCodFor)) And (Not fEmptyStr(strCodFab)) Then
    Begin
      qryUpDate.SQL.Add('ITE_CODFOR = :CODFOR AND ITE_CODFAB = :CODFAB');
      qryUpDate.ParamByName('CODFOR').AsString := strCodFor;
      qryUpDate.ParamByName('CODFAB').AsString := strCodFab;
      qryUpDate.ExecSQL;
    End;
  Finally
    FreeAndNil(qryUpDate);
  End;
end;

procedure TfrmImportCatalogoPreco.pAtivaCatalogoNaoAtivo(strAutInc: String);
  Var
    qryUpDate : TUniQuery;
begin
  qryUpDate := fCriaQuery(Self);
  Try
    qryUpDate.Close;
    qryUpDate.SQL.Clear;
    qryUpDate.SQL.Add(' UPDATE CATITE ');
    qryUpDate.SQL.Add('    SET CAT_DTAATI = :DTAATI  ');
    qryUpDate.SQL.Add('  WHERE AUTOINCREM = :AUTINC  ');
    qryUpDate.SQL.Add('    AND CAT_DTAATI IS NULL    ');
    qryUpDate.ParamByName('AUTINC').AsString := strAutInc;
    qryUpDate.ParamByName('DTAATI').AsDateTime := VS_Date;
    qryUpDate.ExecSQL;
  Finally
    FreeAndNil(qryUpDate);
  End;
end;

procedure TfrmImportCatalogoPreco.pAtualizaDadosInformativosDoCatalogo(
  strAutInc: String);
  Var
    qryUpDate : TUniQuery;
    intCnt : Integer;

  Const
    arrCam : Array[1..9] Of String = ('CAT_DESITE', 'CAT_CLAIPI', 'CAT_CODBAR', 'CAT_CODMAR', 'CAT_CODUNI', 'CAT_REFERE', 'CAT_APLICA', 'CAT_PESOIT', 'CAT_PREDOL');

begin
  qryUpDate := fCriaQuery(Self);
  Try
    For intCnt := Low(arrCam) To High(arrCam) Do
    Begin
      If (cdsItens.FindField(arrCam[intCnt]) <> Nil) And
         (Not cdsItens.FieldByName(arrCam[intCnt]).IsNull) And
         (Not fEmptyStr(cdsItens.FieldByName(arrCam[intCnt]).AsString)) Then
      Begin
        qryUpDate.Close;
        qryUpDate.SQL.Clear;
        qryUpDate.SQL.Add(' UPDATE CATITE ');

        qryUpDate.SQL.Add('    SET ' + arrCam[intCnt] + ' = :PARAM  ');

        qryUpDate.SQL.Add('  WHERE AUTOINCREM = :AUTINC  ');

        qryUpDate.SQL.Add('    AND ((' + arrCam[intCnt] + ' <> :PARAM) OR (' + arrCam[intCnt] + ' IS NULL)) ');

        qryUpDate.ParamByName('AUTINC').AsString := strAutInc;
        qryUpDate.ParamByName('PARAM').Value := cdsItens.FieldByName(arrCam[intCnt]).Value;
        qryUpDate.ExecSQL;
      End;
    End;
  Finally
    FreeAndNil(qryUpDate);
  End;
end;

procedure TfrmImportCatalogoPreco.pAtualizaDadosInformativosDoProduto(
  strCodIte: String);
  Var
    qryUpDate : TUniQuery;
    intCnt : Integer;
    strFieldCatIte : String;
    objCodBar: TIteBar;
    blnPrinc: Boolean;
  Const
    arrCam : Array[1..8] Of String = ('ITE_DESITE', 'ITE_CLAIPI', 'ITE_CODBAR', 'ITE_CODMAR', 'ITE_CODUNI', 'ITE_REFERE', 'ITE_APLICA', 'ITE_PESOIT');

begin
  qryUpDate := fCriaQuery(Self);
  Try
    For intCnt := Low(arrCam) To High(arrCam) Do
    Begin
      strFieldCatIte := AnsiReplaceStr(arrCam[intCnt], 'ITE_', 'CAT_');

      If (cdsItens.FindField(strFieldCatIte) <> Nil) And
         (Not cdsItens.FieldByName(strFieldCatIte).IsNull) Then
      Begin
        If arrCam[intCnt] = 'ITE_CODBAR' Then
        Begin
          If Not fEmptyStr(cdsItens.FieldByName(strFieldCatIte).AsString) Then
          Begin
            objCodBar := TIteBar.Create(opcOperacoes);
            objCodBar.pCarregaDados(strCodIte);
            // Se não tiver cod de barras cadastrado marca este como principal e atualiza a cadite
            blnPrinc := (fRetQtdIteBar(strCodIte) = 0);
            objCodBar.pIncluiCodigo(cdsItens.FieldByName(strFieldCatIte).Value, 1, blnPrinc,
                                    Not fTemPrincipalParaCompra(strCodIte),
                                    True, 0, '', '', '', 0,0,0,0,0,0,0,0, blnPrinc);

            objCodBar.pSalvaDados(strCodIte, True);
            objCodBar.pCarregaDados('');
          End;
        End
        Else
        Begin
          qryUpDate.Close;
          qryUpDate.SQL.Clear;
          qryUpDate.SQL.Add(' UPDATE CADITE ');
          qryUpDate.SQL.Add('    SET ' + arrCam[intCnt] + ' = :PARAM  ');
          qryUpDate.SQL.Add('  WHERE ITE_CODITE = :CODITE  ');
          qryUpDate.SQL.Add('    AND IFNULL(' + arrCam[intCnt] + ', "") <> :PARAM ');
          qryUpDate.ParamByName('CODITE').AsString := strCodIte;
          qryUpDate.ParamByName('PARAM').Value := cdsItens.FieldByName(strFieldCatIte).Value;
          qryUpDate.ExecSQL;
        end;
      End;
    End;
  Finally
    FreeAndNil(qryUpDate);
  End;
end;

procedure TfrmImportCatalogoPreco.pAtualizarPrecoCatalogo(strAutInc: String);
  Var
    qryUpDate : TUniQuery;
    intCnt : Integer;
    intPar : Integer;

  procedure pAddPar(strNome: String);
  begin
    If Not cdsItens.FieldByName('CAT_' + strNome).IsNull Then
    Begin
      qryUpDate.SQL.Add(IIF(intPar = 0, '', ',') + ' CAT_' + strNome + ' = :' + strNome);
      intPar := intPar + 1;
    End;
  end;

  procedure pSetPar(strNome: String);
  begin
    If (qryUpDate.Params.FindParam(strNome) <> Nil) Then
      qryUpDate.ParamByName(strNome).AsFloat := cdsItens.FieldByName('CAT_' + strNome).AsFloat;
  end;

begin
  intPar := 0;

  qryUpDate := fCriaQuery(Self);
  Try
    qryUpDate.Close;
    qryUpDate.SQL.Clear;
    qryUpDate.SQL.Add(' UPDATE CATITE SET ');

    pAddPar('ACRFIN');
    pAddPar('SUBSTI');
    pAddPar('DESADB');
    pAddPar('OUTVAL');
    pAddPar('ICMSAI');
    pAddPar('SUBFED');
    pAddPar('IMPFED');
    pAddPar('DESOPE');
    pAddPar('PRECOM');
    pAddPar('DESF01');
    pAddPar('DESF02');
    pAddPar('DESF03');
    pAddPar('DESF04');
    pAddPar('DESF05');
    pAddPar('DESF06');
    pAddPar('ICMENT');
    pAddPar('IPIENT');
    pAddPar('FREENT');
    pAddPar('PRECUS');

    For intCnt := 1 to 7 Do
    Begin
      pAddPar('MARBR' + IntToStr(intCnt));
      pAddPar('PREVE' + IntToStr(intCnt));
    End;

    pAddPar('VALFRE');
    pAddPar('TCIFCU');
    pAddPar('TSCUST');
    pAddPar('DEPICO');
    pAddPar('DEICMS');
    pAddPar('FATREG');

    qryUpDate.SQL.Add(' WHERE AUTOINCREM = :AUTINC ');
    qryUpDate.ParamByName('AUTINC').AsString := strAutInc;

    pSetPar('ACRFIN');
    pSetPar('SUBSTI');
    pSetPar('DESADB');
    pSetPar('OUTVAL');
    pSetPar('ICMSAI');
    pSetPar('SUBFED');
    pSetPar('IMPFED');
    pSetPar('DESOPE');
    pSetPar('PRECOM');
    pSetPar('DESF01');
    pSetPar('DESF02');
    pSetPar('DESF03');
    pSetPar('DESF04');
    pSetPar('DESF05');
    pSetPar('DESF06');
    pSetPar('ICMENT');
    pSetPar('IPIENT');
    pSetPar('FREENT');
    pSetPar('PRECUS');

    For intCnt := 1 to 7 Do
    Begin
      pSetPar('MARBR' + IntToStr(intCnt));
      pSetPar('PREVE' + IntToStr(intCnt));
    End;

    pSetPar('VALFRE');
    pSetPar('TCIFCU');
    pSetPar('TSCUST');
    pSetPar('DEPICO');
    pSetPar('DEICMS');
    pSetPar('FATREG');

    qryUpDate.ExecSQL;
  Finally
    FreeAndNil(qryUpDate);
  End;
end;

procedure TfrmImportCatalogoPreco.pCalcularPrecos;
  Var
    fltPreCus : Double;
    intTabela : Integer;
begin
  fltPreCus := fRetPrecoCusto(cdsItens.FieldByName('CAT_PRECOM').AsFloat,
                              cdsItens.FieldByName('CAT_DESF01').AsFloat,
                              cdsItens.FieldByName('CAT_DESF02').AsFloat,
                              cdsItens.FieldByName('CAT_DESF03').AsFloat,
                              cdsItens.FieldByName('CAT_DESF04').AsFloat,
                              cdsItens.FieldByName('CAT_DESF05').AsFloat,
                              cdsItens.FieldByName('CAT_DESF06').AsFloat,
                              cdsItens.FieldByName('CAT_ICMENT').AsFloat,
                              cdsItens.FieldByName('CAT_SUBFED').AsFloat,
                              cdsItens.FieldByName('CAT_IPIENT').AsFloat,
                              cdsItens.FieldByName('CAT_FREENT').AsFloat,
                              cdsItens.FieldByName('CAT_ACRFIN').AsFloat,
                              cdsItens.FieldByName('CAT_SUBSTI').AsFloat,
                              cdsItens.FieldByName('CAT_DESADB').AsFloat,
                              cdsItens.FieldByName('CAT_VALFRE').AsFloat,
                              cdsItens.FieldByName('CAT_PREDOL').AsString = 'S',
                              cdsItens.FieldByName('CAT_TCIFCU').AsFloat,
                              cdsItens.FieldByName('CAT_TSCUST').AsFloat,
                              cdsItens.FieldByName('CAT_DEPICO').AsFloat,
                              cdsItens.FieldByName('CAT_DEICMS').AsFloat,
                              cdsItens.FieldByName('CAT_FATREG').AsFloat);

  cdsItens.FieldByName('CAT_PRECUS').AsFloat := fltPreCus;

  If (Not fEmptyStr(cdsItens.FieldByName('CAT_CODITE').AsString)) Or
     (Not fEmptyStr(cdsItens.FieldByName('CAT_CODFAB').AsString)) Then
  Begin
    qryLocIte.Filtered := False;
    qryLocIte.Filter := 'ITE_CODITE = ' + QuotedStr(cdsItens.FieldByName('CAT_CODITE').AsString);
    qryLocIte.Filtered := True;

    For intTabela := 1 To 7 Do
    Begin
      If (rdbPreVen.Checked) Then
      Begin
        If not qryLocIte.IsEmpty Then
        Begin
          cdsItens.FieldByName('CAT_MARBR' + IntToStr(intTabela)).AsFloat := qryLocIte.Fieldbyname('ITE_MARBR' + IntToStr(intTabela)).AsFloat;
          cdsItens.FieldByName('CAT_COMTB' + IntToStr(intTabela)).AsFloat := qryLocIte.FieldByName('ITE_COMTB' + IntToStr(intTabela)).AsFloat;
        End;

        cdsItens.FieldByName('CAT_PREVE' + IntToStr(intTabela)).AsFloat := fCalculaPrecoVenda(1,
                                                                                           fltPreCus + cdsItens.FieldByName('CAT_OUTVAL').AsFloat,
                                                                                           IIf(qryLocIte.IsEmpty, cdsItens.Fieldbyname('CAT_PREVE' + IntToStr(intTabela)).AsFloat,
                                                                                                                 qryLocIte.Fieldbyname('ITE_PREVE' + IntToStr(intTabela)).AsFloat),
                                                                                           cdsItens.FieldByName('CAT_MARBR' + IntToStr(intTabela)).AsFloat,
                                                                                           cdsItens.FieldByName('CAT_ICMSAI').AsFloat,
                                                                                           cdsItens.FieldByName('CAT_IMPFED').AsFloat,
                                                                                           cdsItens.FieldByName('CAT_DESOPE').AsFloat,
                                                                                           cdsItens.FieldByName('CAT_COMTB' + IntToStr(intTabela)).AsFloat,
                                                                                           strMarMkp,
                                                                                           strPcmPro,
                                                                                           intDecUni);
      End
      Else
      Begin
        If not qryLocIte.IsEmpty Then
        Begin
          cdsItens.FieldByName('CAT_PREVE' + IntToStr(intTabela)).AsFloat := qryLocIte.Fieldbyname('ITE_PREVE' + IntToStr(intTabela)).AsFloat;
          cdsItens.FieldByName('CAT_COMTB' + IntToStr(intTabela)).AsFloat := qryLocIte.FieldByName('ITE_COMTB' + IntToStr(intTabela)).AsFloat;
        End;

        cdsItens.FieldByName('CAT_MARBR' + IntToStr(intTabela)).AsFloat := fCalculaPrecoVenda(2,
                                                                                           fltPreCus + cdsItens.FieldByName('CAT_OUTVAL').AsFloat,
                                                                                           cdsItens.FieldByName('CAT_PREVE' + IntToStr(intTabela)).AsFloat,
                                                                                           0,
                                                                                           cdsItens.FieldByName('CAT_ICMSAI').AsFloat,
                                                                                           cdsItens.FieldByName('CAT_IMPFED').AsFloat,
                                                                                           cdsItens.FieldByName('CAT_DESOPE').AsFloat,
                                                                                           cdsItens.FieldByName('CAT_COMTB' + IntToStr(intTabela)).AsFloat,
                                                                                           strMarMkp,
                                                                                           strPcmPro,
                                                                                           intDecUni);
      End;
    End;
  End;
end;

procedure TfrmImportCatalogoPreco.pCarregaExclusoes;
  Var
    strSql: String;
begin
  strSql := '';
  strSql := strSql + 'SELECT ';
  strSql := strSql + fSelectBase(True);
  strSql := strSql + '  FROM CATITE ';
  strSql := strSql + ' WHERE CAT_CODFOR = ' + QuotedStr(edtCodFor.Text);

  If Assigned(cdsExclu) Then
    FreeAndNil(cdsExclu);

  cdsExclu := TZClient.Create(Self, strSql);
  cdsExclu.fAbreClient(True,'[TfrmImportCatalogoPreco.pCarregaExclusoes]');
  cdsExclu.IndexFieldNames := 'AUTINC';
end;

procedure TfrmImportCatalogoPreco.pCarregaLocIte;
  Var
    strSql : String;
begin
  strSql := '';
  strSql := strSql + ' SELECT I.ITE_CODITE, I.ITE_CODFAB, I.ITE_CODFOR, ';
  strSql := strSql + '        G.ITE_PREVE1, G.ITE_PREVE2, G.ITE_PREVE3, ';
  strSql := strSql + '        G.ITE_PREVE4, G.ITE_PREVE5, G.ITE_PREVE6, ';
  strSql := strSql + '        G.ITE_PREVE7, G.ITE_MARBR1, G.ITE_MARBR2, ';
  strSql := strSql + '        G.ITE_MARBR3, G.ITE_MARBR4, G.ITE_MARBR5, ';
  strSql := strSql + '        G.ITE_MARBR6, G.ITE_MARBR7, G.ITE_COMTB1, ';
  strSql := strSql + '        G.ITE_COMTB2, G.ITE_COMTB3, G.ITE_COMTB4, ';
  strSql := strSql + '        G.ITE_COMTB5, G.ITE_COMTB6, G.ITE_COMTB7  ';
  strSql := strSql + '   FROM CADITE I ';
  strSql := strSql + '   JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE ';
  strSql := strSql + '                AND G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);

  With qryLocIte Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add( strSQL );
    Open;
  End;
end;

procedure TfrmImportCatalogoPreco.pGetCodigos(Var strCodIte, strCodBar, strCodFor, strCodFab: String; intLinha: Integer);
Begin
  If Not blnArqCsv Then
  Begin
    If Not fEmptyStr(Trim(fRetSomenteNumeros(Excel.Range[cCodIte + IntToStr(intLinha)].Value))) Then
      strCodIte := Format('%0.'+IntToStr(fTamCodIte)+'d', [StrToInt(Trim(Excel.Range[cCodIte + IntToStr(intLinha)].Value))])
    Else
      strCodIte := '';

    strCodBar := Trim(Excel.Range[cCodBar + IntToStr(intLinha)].Value);
    strCodFor := Trim(Excel.Range[cCodFor + IntToStr(intLinha)].Value);
    strCodFab := Trim(Excel.Range[cCodFab + IntToStr(intLinha)].Value);
  End
  Else
  Begin
    strCodIte := fGetCampoCSV(tcCodIte, intLinha);
    strCodBar := fGetCampoCSV(tcCodBar, intLinha);
    strCodFor := fGetCampoCSV(tcCodFor, intLinha);
    strCodFab := fGetCampoCSV(tcCodFab, intLinha);
  End;
End;

procedure TfrmImportCatalogoPreco.pGravaPreIteCat;
  Var
    qryPreIte : TUniQuery;
    strFieldName : String;
    strPrefCatIte : String;
    strPrefPreIte : String;
    intCnt : Integer;
begin
  strPrefCatIte := 'CAT';
  strPrefPreIte := 'PRE';

  qryPreIte := fCriaQuery(Self);
  Try
    With qryPreIte Do
    begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT * ');
      SQL.Add('   FROM PREITE ');
      SQL.Add('  WHERE PRE_DTAPRE = :DTAPRE ');
      SQL.Add('    AND PRE_CODITE = :CODITE ');
      SQL.Add('    AND PRE_CODEMP = :CODEMP ');
      ParamByName('DTAPRE').AsDateTime := dtaDtaAltera;
      ParamByName('CODITE').AsString := cdsItens.FieldByName('CAT_CODITE').AsString;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      If IsEmpty Then
      Begin
        Append;
        FieldByName('PRE_PROPRI').AsString := fRetSequencial('PROPRI', VS_strCodEmp);
        FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('PREITE', VS_strCodEmp);
        FieldByName('PRE_CODEMP').AsString := VS_strCodEmp;
      End
      Else
        Edit;

      For intCnt := 0 to qryPreIte.Fields.Count -1 Do
      Begin
        strFieldName := qryPreIte.Fields[intCnt].FieldName;
        strFieldName := AnsiReplaceStr(strFieldName, strPrefPreIte + '_', strPrefCatIte + '_');
        If (Not fEmptyStr(strFieldName)) And
           (cdsItens.FindField( strFieldName ) <> Nil) Then
        Begin
          qryPreIte.FieldByName(qryPreIte.Fields[intCnt].FieldName).Value := cdsItens.FieldByName(strFieldName).Value;
        End;
      End;

      qryPreIte.FieldByName('PRE_PRECUS_NOV').Value := cdsItens.FieldByName('CAT_PRECUS').Value;
      For intCnt := 1 To 7 Do
      Begin
        qryPreIte.FieldByName('PRE_MARBR' + IntToStr(intCnt)+ '_NOV').Value := cdsItens.FieldByName('CAT_MARBR' +IntToStr(intCnt)).Value;
        qryPreIte.FieldByName('PRE_PREVE' + IntToStr(intCnt)+ '_NOV').Value := cdsItens.FieldByName('CAT_PREVE' +IntToStr(intCnt)).Value;
      End;
      qryPreIte.FieldByName('PRE_PREDOL_NOV').Value := cdsItens.FieldByName('CAT_PREDOL').Value;

      FieldByName('PRE_DTAPRE').AsDateTime := dtaDtaAltera;
      FieldByName('PRE_NOMFRM').AsString := 'TfrmImportCatalogoPreco';
      Post;
    End;
  Finally
    FreeAndNil(qryPreIte);
  End;
end;

function TfrmImportCatalogoPreco.fLocCat(intLinha: Integer): Boolean;
  Var
    strCodIte : String;
    strCodBar : String;
    strCodFor : String;
    strCodFab : String;
    intCnt : Integer;
begin
  pGetCodigos(strCodIte, strCodBar, strCodFor, strCodFab, intLinha);

  With qryLocCat Do
  Begin
    For intCnt := 1 To 3 Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT IF(CAT_DTAATI IS NULL, " ", "X") AS CATATI, ');
      SQL.Add('        CATITE.AUTOINCREM AS AUTINC, ');
      SQL.Add('        CATITE.* ');
      SQL.Add('   FROM CATITE ');
      SQL.Add('  WHERE TRUE AND ' );
      If Not fEmptyStr(strCodFor) Then
         SQL.Add('  CAT_CODFOR = :CODFOR AND ');

      If (intCnt = 1) Then
      Begin
        If Not fEmptyStr(strCodIte) Then
        Begin
          SQL.Add(' CAT_CODITE = :CODITE  ');
          ParamByName('CODITE').AsString := strCodIte;
        End
        Else
          Continue;
      End
      Else If (intCnt = 2) Then
      Begin
        If Not fEmptyStr(strCodBar) Then
        Begin
          SQL.Add(' CAT_CODBAR = :CODBAR ');
          ParamByName('CODBAR').AsString := strCodBar;
        End
        Else
          Continue;
      End
      Else If (intCnt = 3) Then
      Begin
        If (Not fEmptyStr(strCodFab)) Then
        Begin
          SQL.Add(' CAT_CODFAB = :CODFAB ');
          ParamByName('CODFAB').AsString := strCodFab;
        End
        Else
          Continue;
      End;

      If Not fEmptyStr(strCodFor) Then
        ParamByName('CODFOR').AsString := strCodFor;

      Open;

      If (Not IsEmpty) Then
        Break;
    End;

    Result := (Active) And (Not IsEmpty);

    If (Result) And (cdsItens.State In [dsInsert, dsEdit]) Then
    Begin
      cdsItens.FieldByName('CAT_CODITE').AsString := strCodIte;
      cdsItens.FieldByName('CAT_CODFOR').AsString := strCodFor;
      cdsItens.FieldByName('CAT_CODBAR').AsString := strCodBar;
      cdsItens.FieldByName('CAT_CODFAB').AsString := strCodFab;
    End;

    If (Result) And (Assigned(cdsExclu)) And (cdsExclu.Active) And (Not cdsExclu.IsEmpty) Then
    Begin
      If cdsExclu.FindKey([qryLocCat.FieldByName('AUTOINCREM').AsString]) Then
        cdsExclu.Delete;
    End;

    If (Not Result) And (Not chkCadNovCat.Checked) Then
    Begin
      FLog.Add('Item não encontrado no catálogo Linha: ' + fPadL(IntToStr(intLinha), fTamCodite, '0') + ' ' +
               'Cód. Item: [' + strCodIte +  '] ' +
               'Cód. Barras: [' + strCodBar + '] ' +
               'Cód. Fabrica: [' + strCodFab + ']');

    End;
  End;
end;

function TfrmImportCatalogoPreco.fGetCampoCSV(tcCampo: TTipoCampo; intLinha: Integer): Variant;
  Var
    strLinha  : String;

    procedure pSetaValoresArr;
      Var
        intIndex: Integer;
        strConverte: String;
        stlDados: TStringList;
    Begin
      stlDados := TStringList.Create;
      stlDados.StrictDelimiter := True;

      strConverte := AnsiReplaceStr(strLinha, ',', '[^]');
      strConverte := AnsiReplaceStr(strConverte, ';', ',');

      stlDados.CommaText := strConverte;
      stlDados.Text := AnsiReplaceStr(stlDados.Text, '[^]', ',');

      For intIndex := Low(arrValores) To High(arrValores) Do
        If intIndex < stlDados.Count Then
          arrValores[intIndex] := stlDados[intIndex]
        Else
          arrValores[intIndex] := '';

      FreeAndNil(stlDados);
    End;

begin
  If (tcCampo = tcCodIte) Or
     (tcCampo = tcCodBar) Or
     (tcCampo = tcCodFab) Or
     (tcCampo = tcCodFor) Then
    Result := ''
  Else
    Result := Null;

  If intLinha > stlArqCsv.Count Then
    Exit;

  strLinha := stlArqCsv[intLinha-1];

  pSetaValoresArr;

  If (tcCampo = tcCodIte) Then
    Result := arrValores[0]
  Else If (tcCampo = tcCodBar) Then
    Result := arrValores[1]
  Else If (tcCampo = tcCodFab) Then
    Result := arrValores[2]
  Else If (tcCampo = tcCodFor) Then
    Result := arrValores[3]
  Else If (tcCampo = tcPreCom) And (Not fEmptyStr(arrValores[4])) Then
    Result := arrValores[4]
  Else If (tcCampo = tcDesF01) And (Not fEmptyStr(arrValores[5])) Then
    Result := arrValores[5]
  Else If (tcCampo = tcDesF02) And (Not fEmptyStr(arrValores[6])) Then
    Result := arrValores[6]
  Else If (tcCampo = tcDesF03) And (Not fEmptyStr(arrValores[7])) Then
    Result := arrValores[7]
  Else If (tcCampo = tcDesF04) And (Not fEmptyStr(arrValores[8])) Then
    Result := arrValores[8]
  Else If (tcCampo = tcDesF05) And (Not fEmptyStr(arrValores[9])) Then
    Result := arrValores[9]
  Else If (tcCampo = tcDesF06) And (Not fEmptyStr(arrValores[10])) Then
    Result := arrValores[10]
  Else If (tcCampo = tcIcmEnt) And (Not fEmptyStr(arrValores[11])) Then
    Result := arrValores[11]
  Else If (tcCampo = tcSubFed) And (Not fEmptyStr(arrValores[12])) Then
    Result := arrValores[12]
  Else If (tcCampo = tcIpiEnt) And (Not fEmptyStr(arrValores[13])) Then
    Result := arrValores[13]
  Else If (tcCampo = tcFreEnt) And (Not fEmptyStr(arrValores[14])) Then
    Result := arrValores[14]
  Else If (tcCampo = tcValFre) And (Not fEmptyStr(arrValores[15])) Then
    Result := arrValores[15]
  Else If (tcCampo = tcAcrFin) And (Not fEmptyStr(arrValores[16])) Then
    Result := arrValores[16]
  Else If (tcCampo = tcSubSti) And (Not fEmptyStr(arrValores[17])) Then
    Result := arrValores[17]
  Else If (tcCampo = tcDesAbd) And (Not fEmptyStr(arrValores[18])) Then
    Result := arrValores[18]
  Else If (tcCampo = tcOutVal) And (Not fEmptyStr(arrValores[19])) Then
    Result := arrValores[19]
  Else If (tcCampo = tcIcmSai) And (Not fEmptyStr(arrValores[20])) Then
    Result := arrValores[20]
  Else If (tcCampo = tcImpFed) And (Not fEmptyStr(arrValores[21])) Then
    Result := arrValores[21]
  Else If (tcCampo = tcDesOpe) And (Not fEmptyStr(arrValores[22])) Then
    Result := arrValores[22]
  Else If (tcCampo = tcDesIte) And (Not fEmptyStr(arrValores[23])) Then
    Result := arrValores[23]
  Else If (tcCampo = tcPesBru) And (Not fEmptyStr(arrValores[24])) Then
    Result := arrValores[24]
  Else If (tcCampo = tcEmbala) And (Not fEmptyStr(arrValores[25])) Then
    Result := arrValores[25]
  Else If (tcCampo = tcClaIpi) And (Not fEmptyStr(arrValores[26])) Then
    Result := arrValores[26]
  Else If (tcCampo = tcCodMar) And (Not fEmptyStr(arrValores[27])) Then
    Result := arrValores[27]
  Else If (tcCampo = tcCodUni) And (Not fEmptyStr(arrValores[28])) Then
    Result := arrValores[28]
  Else If (tcCampo = tcRefere) And (Not fEmptyStr(arrValores[29])) Then
    Result := arrValores[29]
  Else If (tcCampo = tcAplica) And (Not fEmptyStr(arrValores[30])) Then
    Result := arrValores[30]
  Else If (tcCampo = tcPreDol) And (Not fEmptyStr(arrValores[31])) Then
    Result := arrValores[31]
  Else If (tcCampo = tcTCIFCu) And (Not fEmptyStr(arrValores[32])) Then
    Result := arrValores[32]
  Else If (tcCampo = tcTSCust) And (Not fEmptyStr(arrValores[33])) Then
    Result := arrValores[33]
  Else If (tcCampo = tcDePiCo) And (Not fEmptyStr(arrValores[34])) Then
    Result := arrValores[34]
  Else If (tcCampo = tcdeICMS) And (Not fEmptyStr(arrValores[35])) Then
    Result := arrValores[35]
  Else If (tcCampo = tcFatReg) And (Not fEmptyStr(arrValores[36])) Then
    Result := arrValores[36]
  Else If (tcCampo = tcCodAbf) And (Not fEmptyStr(arrValores[37])) Then
    Result := arrValores[37];


  Case tcCampo Of
    tcCodIte : strCampo := ' Coluna: ' + cCodIte + ' - ' + 'Código do Item = '           + arrValores[0];
    tcCodBar : strCampo := ' Coluna: ' + cCodBar + ' - ' + 'Código de Barra = '          + arrValores[1];
    tcCodFab : strCampo := ' Coluna: ' + cCodFab + ' - ' + 'Código de Fábrica = '        + arrValores[2];
    tcCodFor : strCampo := ' Coluna: ' + cCodFor + ' - ' + 'Código do Fornecedor = '     + arrValores[3];
    tcPreCom : strCampo := ' Coluna: ' + cPrComp + ' - ' + 'Preço de Compra = '          + arrValores[4];
    tcDesF01 : strCampo := ' Coluna: ' + cDesFo1 + ' - ' + 'Desconto 01 % = '            + arrValores[5];
    tcDesF02 : strCampo := ' Coluna: ' + cDesFo2 + ' - ' + 'Desconto 02 % = '            + arrValores[6];
    tcDesF03 : strCampo := ' Coluna: ' + cDesFo3 + ' - ' + 'Desconto 03 % = '            + arrValores[7];
    tcDesF04 : strCampo := ' Coluna: ' + cDesFo4 + ' - ' + 'Desconto 04 % = '            + arrValores[8];
    tcDesF05 : strCampo := ' Coluna: ' + cDesFo5 + ' - ' + 'Desconto 05 % = '            + arrValores[9];
    tcDesF06 : strCampo := ' Coluna: ' + cDesFo6 + ' - ' + 'Desconto 06 % = '            + arrValores[10];
    tcIcmEnt : strCampo := ' Coluna: ' + cIcmEnt + ' - ' + 'ICMS Entrada = '             + arrValores[11];
    tcSubFed : strCampo := ' Coluna: ' + cSubFed + ' - ' + 'Impostos Federais = '        + arrValores[12];
    tcIpiEnt : strCampo := ' Coluna: ' + cIpiEnt + ' - ' + 'IPI Entrada = '              + arrValores[13];
    tcFreEnt : strCampo := ' Coluna: ' + cFrete_ + ' - ' + 'Frete % = '                  + arrValores[14];
    tcValFre : strCampo := ' Coluna: ' + cVrFret + ' - ' + fCfgSis('DESVFR') + ' = '              + arrValores[15];
    tcAcrFin : strCampo := ' Coluna: ' + cAcrFin + ' - ' + 'Acréscimo Finananceiro = '   + arrValores[16];
    tcSubSti : strCampo := ' Coluna: ' + cSubSti + ' - ' + 'Substituição. Tributária = ' + arrValores[17];
    tcDesAbd : strCampo := ' Coluna: ' + cDesAdc + ' - ' + 'Descontos Adicionais = '     + arrValores[18];
    tcOutVal : strCampo := ' Coluna: ' + cOutros + ' - ' + 'Outros Valores = '           + arrValores[19];
    tcIcmSai : strCampo := ' Coluna: ' + cIcmSai + ' - ' + 'ICMS Saída = '               + arrValores[20];
    tcImpFed : strCampo := ' Coluna: ' + cImpFed + ' - ' + 'Impostos Federais = '        + arrValores[21];
    tcDesOpe : strCampo := ' Coluna: ' + cDesOpe + ' - ' + 'Despesas Operacionais = '    + arrValores[22];
    tcDesIte : strCampo := ' Coluna: ' + cDesIte + ' - ' + 'Descrição Item = '           + arrValores[23];
    tcPesBru : strCampo := ' Coluna: ' + cPesBru + ' - ' + 'Peso Bruto = '               + arrValores[24];
    tcEmbala : strCampo := ' Coluna: ' + cEmbala + ' - ' + 'Embalagem = '                + arrValores[25];
    tcClaIpi : strCampo := ' Coluna: ' + cClaIpi + ' - ' + 'NCM = '                      + arrValores[26];
    tcCodMar : strCampo := ' Coluna: ' + cCodMar + ' - ' + 'Marca = '                    + arrValores[27];
    tcCodUni : strCampo := ' Coluna: ' + cCodUni + ' - ' + 'Unidade = '                  + arrValores[28];
    tcRefere : strCampo := ' Coluna: ' + cRefere + ' - ' + 'Referência = '               + arrValores[29];
    tcAplica : strCampo := ' Coluna: ' + cAplica + ' - ' + 'Aplicação = '                + arrValores[30];
    tcPreDol : strCampo := ' Coluna: ' + cPreDol + ' - ' + 'Preço Dólar = '              + arrValores[31];
    tcTCIFCu : strCampo := ' Coluna: ' + cTCIFCu + ' - ' + 'TCIF = '                     + arrValores[32];
    tcTSCust : strCampo := ' Coluna: ' + cTSCust + ' - ' + 'TS = '                       + arrValores[33];
    tcDePiCo : strCampo := ' Coluna: ' + cDePiCo + ' - ' + 'Desconto PIS/COFINS = '      + arrValores[34];
    tcDeICMS : strCampo := ' Coluna: ' + cDeICMS + ' - ' + 'Desconto de ICMS = '         + arrValores[35];
    tcFatReg : strCampo := ' Coluna: ' + cFatReg + ' - ' + 'Fator Regional = '           + arrValores[36];
    tcCodAbf : strCampo := ' Coluna: ' + cCodAbf + ' - ' + 'Abreviação. Fiscal = '       + arrValores[37];
  End

end;

function TfrmImportCatalogoPreco.fConfirmaData: Boolean;
  Var
    strMensagem: String;
Begin
  pCriarFormularios(TfrmAltPrecoDigData, frmAltPrecoDigData);
  frmAltPrecoDigData.Caption := 'Opção de Gravação dos Preços';
  frmAltPrecoDigData.ShowModal;
  Try
    If frmAltPrecoDigData.blnConfirma Then
    Begin
      If (frmAltPrecoDigData.dtaData = VS_Date) Then
        strMensagem := 'Os preços serão agendados para hoje. Confirma?'
      Else
        strMensagem := 'Os preços serão alterados no dia '+ DateToStr(frmAltPrecoDigData.dtaData) + '. Confirma?';

      Result := fMensagem('Confirmação', strMensagem, ['&Sim','&Não']) = 1;
    End
    Else
      Result := False;

    dtaDtaAltera := frmAltPrecoDigData.dtaData;
  Finally
    FreeAndNil(frmAltPrecoDigData);
  End;
End;

function TfrmImportCatalogoPreco.fConfirmarImportacao(pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := True;

  Try
    Try
      pgbProgresso.Position := 0;
      pgbProgresso.Properties.Max := cdsItens.RecordCount;
      pnlInfo.Caption := 'Aguarde, gravando informações...';

      cdsItens.First;
      While Not cdsItens.Eof Do
      Begin
        pgbProgresso.Position := cdsItens.RecNo;
        pnlInfo.Caption := 'Aguarde, gravando informações [' + IntToStr(cdsItens.RecNo) + '/' + IntToStr(cdsItens.RecordCount) + ']';
        Application.ProcessMessages;

        fStartTransaction;

        If fProcessarImportacaoItem Then
          fCommit
        Else
          fRollBack;

        cdsItens.Next;
      End;
    Except
      On E: Exception DO
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TfrmImportCatalogoPreco.fConfirmarImportacao]');
      End;
    End;
  Finally
    pgbProgresso.Position := 0;
    pnlInfo.Caption := '';
  End;
end;

function TfrmImportCatalogoPreco.fExisteRegistro(strCodigo, strTabela, strCampoCodigo: String): Boolean;
begin
  Result := False;
  qryConsulta.SQL.Clear;
  Try
     qryConsulta.SQL.Text := 'SELECT COUNT(1) AS QTD FROM ' + strTabela + ' WHERE ' + strCampoCodigo + ' = ' + QuotedStr(strCodigo);
     qryConsulta.Open;
     If Not qryConsulta.IsEmpty Then
       Result := qryConsulta.FieldByName('QTD').AsInteger > 0;
  Except
    on e: Exception do
      pMensagensErro(E.Message, '[TfrmImportCatalogoPreco.fExisteFornecedor]');
  End;
end;

function TfrmImportCatalogoPreco.fProcessarImportacaoItem: Boolean;
  Var
    intCnt : Integer;
begin
  Try
    Result := True;

    If (cdsItens.FieldByName('NVOCAT').AsString = arrSimNao[1]) Then
    Begin
      qryCatIte.Insert;
      (* Caso o forncedor estiver vazio ou informado errado
         código da marca errada ou
         código da unidade errada  no excel então não importa *)
      If (cdsItens.FieldByName('SITFOR').AsInteger <> 0) Or
         (cdsItens.FieldByName('SITMAR').AsInteger <> 0) Or
         (cdsItens.FieldByName('SITUNI').AsInteger <> 0) Then
         Exit;
      For intCnt := 0 to cdsItens.Fields.Count -1 Do
      Begin
        If (qryCatIte.FindField(cdsItens.Fields[intCnt].FieldName) <> Nil) Then
          qryCatIte.FieldByName(cdsItens.Fields[intCnt].FieldName).Value := cdsItens.Fields[intCnt].Value;
      End;

      If (cdsItens.FieldByName('CATATI').AsString = arrSimNao[1]) Then
        qryCatIte.FieldByName('CAT_DTAATI').AsDateTime := VS_Date
      Else
        qryCatIte.FieldByName('CAT_DTAATI').Value := Null;

      qryCatIte.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CATITE', VS_strCodEmp);
      qryCatIte.Post;
    End

    Else If (cdsItens.FieldByName('EXCLIN').AsString = arrSimNao[1]) Then
    Begin
      pSetaAtivoParaComprasNao(cdsItens.FieldByName('CAT_CODITE').AsString,
                               cdsItens.FieldByName('CAT_CODBAR').AsString,
                               cdsItens.FieldByName('CAT_CODFOR').AsString,
                               cdsItens.FieldByName('CAT_CODFAB').AsString);

      pDeletaCatalogo(cdsItens.FieldByName('AUTINC').AsString);
    End

    Else
    Begin

      If (cdsItens.FieldByName('CATATI').AsString = arrSimNao[1]) And
         (Not fEmptyStr(cdsItens.FieldByName('AUTINC').AsString)) Then
      Begin
        pAtivaCatalogoNaoAtivo(cdsItens.FieldByName('AUTINC').AsString);
      End;

      If (cdsItens.FieldByName('ATPRCT').AsString = arrSimNao[1]) And
         (Not fEmptyStr(cdsItens.FieldByName('AUTINC').AsString)) Then
      Begin
        pAtualizarPrecoCatalogo(cdsItens.FieldByName('AUTINC').AsString);
        pAtualizaDadosInformativosDoCatalogo(cdsItens.FieldByName('AUTINC').AsString);
      End;

      If (cdsItens.FieldByName('ATPRIT').AsString = arrSimNao[1]) Then
        pGravaPreIteCat;
      If (Not fEmptyStr(cdsItens.FieldByName('CAT_CODITE').AsString)) Then
        pAtualizaDadosInformativosDoProduto(cdsItens.FieldByName('CAT_CODITE').AsString);
    End;
  Except
    On E: Exception DO
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmImportCatalogoPreco.fProcessarImportacaoItem]');
    End;
  End;
end;

function TfrmImportCatalogoPreco.XlsToStringGrid(AGrid: TStringGrid; AXLSFile: string): Boolean;
const
	xlCellTypeLastCell = $0000000B;
var
	XLApp, Sheet: OLEVariant;
	RangeMatrix: Variant;
	x, y, k, r: Integer;
begin
  Result:=False;
  //Cria Excel- OLE Object
  XLApp:=CreateOleObject('Excel.Application');
try
	//Esconde Excel
	XLApp.Visible:=False;

	//Abre o Workbook
	XLApp.Workbooks.Open(Filename := edtPath.Text);
    XLApp.WorkSheets[1].Activate;
	Sheet := XLApp.Workbooks[ExtractFileName(AXLSFile)].WorkSheets[1];

	//Pegar o número da última linha
	x:=XLApp.ActiveCell.Row;

	//Pegar o número da última coluna
    y:= Sheet.Cells.SpecialCells(11).Column;
	//Seta Stringgrid linha e coluna

	AGrid.RowCount:=x;
	AGrid.ColCount:=y;

	//Associa a variant WorkSheet com a variant do Delphi
	RangeMatrix:=XLApp.Range['A1', XLApp.Cells.Item[X, Y]].Value;

	//Cria o loop para listar os registros no TStringGrid
	k:=1;

	repeat
		for r:=1 to y do
			AGrid.Cells[(r - 1),(k - 1)]:=RangeMatrix[K, R];
		Inc(k,1);
	until k > x;

	RangeMatrix := Unassigned;

  finally
    if not VarIsEmpty(XLApp) then
    begin
      XLApp.Quit;
      XLAPP := Unassigned;
      Sheet := Unassigned;
      Result := True;
    end;
	end;
end;

end.

