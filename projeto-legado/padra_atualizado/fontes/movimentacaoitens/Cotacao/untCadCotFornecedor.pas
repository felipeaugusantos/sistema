unit untCadCotFornecedor;

interface

uses
  Windows, Classes, Controls, Forms, untPaiOrdena, DB, UniClientDataSet,
  UniDataSetProvider, Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, DBCtrls, frxExportXLS, frxClass,
  frxExportPDF, frxDBSet, ComCtrls, untExcel, untGeraExcel, BitBtnLockedIncrem,
  MemDS, DBAccess, Provider, ExtCtrls, frxExportCSVTestabilidade;

type
  TfrmCadCotFornecedor = class(TfrmPaiOrdena)
    lblCliFor: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    pgbProgresso: TProgressBar;
    btnExpArq: TBitBtnLocked;
    btnImpArq: TBitBtnLocked;
    btnMarDes: TBitBtnLocked;
    btnForPre: TBitBtnLocked;
    btnIncluir: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnMarDesClick(Sender: TObject);
    procedure btnExpArqClick(Sender: TObject);
    procedure btnImpArqClick(Sender: TObject);
    procedure btnForPreClick(Sender: TObject);
    procedure dbgConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    strDirExp,
    strDirImp: String;

    FCodFor: String;
    cdsDados : TUniClientDataSet;

    Function fIncluiItensFornecedor(strCodFor: String): Boolean;
    Function fExcluiItensFornecedor(strCodFor: String): Boolean;
    Function fGetDadosFornecedor(strCodFor: String; Var strNomFor, strEmail, strContato: String): Boolean;

    procedure pExcluiFornecedor;
    procedure pIncluiFornecedor;
    procedure pLimpaFornecedor;

    procedure pExportarArquivos;
    procedure pImportaArquivos;

    procedure pExportarExcel(strNomArq: String; intOrdem: Integer);
    procedure pExcelImprimeFiltros(Excel: TExcel; Dados: TDataSet; Campos: TCampos; Filtros: array of String);
    procedure pFimGeracaoExcel(Excel: TExcel; Campos: TCampos);
    procedure pImprimeDetalhes(Excel: TExcel; Dados: TDataSet; Campos: TCampos; CorFundo: TCorExcel);
    function FRetCodIte: string;
  public
    { Public declarations }
    strSeqGer,
    strNumCot,
    strCodEmp: String;

    cdsItens,
    cdsItensFornec,
    cdsCotac: TUniClientDataSet;

    procedure pAbreConsulta;
    procedure pDesabilitaAlteracao;

  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
    function fGetSql(blnLike: Boolean): String; Override;
  end;

Const
  TIT_CODIGO = 'Código';
  TIT_PRECO  = 'Preço Unit.';
  TIT_IPI    = '% I.P.I.';
  TIT_ST     = '%Subs.';
var
  frmCadCotFornecedor: TfrmCadCotFornecedor;

implementation

uses SysUtils, Variants, StrUtils, untFuncoesSimples, untFuncoes, untTypesSistema,
  untModuloCotExportacao, untCadForPre, untConsultas, untConstantes,
  untCadCotEmail, untCadCotImportacao;

{$R *.dfm}

function TfrmCadCotFornecedor.fGetSql(blnLike: Boolean): String;
Begin

  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   COT_CODFOR AS AUTOINCREM, ';
  Result := Result + '   COT_CODFOR AS CODFOR,     ';
  Result := Result + '   COT_UTILIZ AS UTILIZ,     ';
  Result := Result + '   COT_DTAENT AS DTAENT,     ';
  Result := Result + '   COT_CONPAG AS CONPAG,     ';
  Result := Result + '   FOR_NOMFOR AS NOMFOR      ';
  Result := Result + ' FROM            ';
  Result := Result + '   COTCFO ';
  Result := Result + ' INNER JOIN CADFOR ON FOR_CODFOR = COT_CODFOR ';
  Result := Result + ' WHERE COT_SEQGER = ' + QuotedStr(strSeqGer);

End;

procedure TfrmCadCotFornecedor.FormShow(Sender: TObject);
begin
  inherited;
  pLimpaEventoEdits;

  btnExpArq.Enabled := Not fEmptyStr(strNumCot);
  btnImpArq.Enabled := Not fEmptyStr(strNumCot);
  btnMarDes.Enabled := Not fEmptyStr(strNumCot);
  btnForPre.Enabled := Not fEmptyStr(strNumCot);  

  btnForPre.Visible := fCfgSis('PRESPD', varBoolean);

  strDirExp := ExtractFilePath(Application.ExeName) + 'COTACOES\EXPORTAR';
  strDirImp := ExtractFilePath(Application.ExeName) + 'COTACOES\IMPORTAR';
end;

procedure TfrmCadCotFornecedor.pAbreConsulta;
Begin
  blnSempreRelerBanco := FALSE;
  lflLastField.intIndCol := 0;
  lflLastField.strNomCam := dbgConsulta.Columns[0].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[0].Title.Caption;
  lflLastField.ftyTipCam := ftString;
  fAbreConsulta(TRUE);

  cdsConsulta.FieldByName('CONPAG').EditMask := '99.999.999.999.999.999.999.999.999.999.999.999.999;0;_';
  cdsConsulta.FieldByName('DTAENT').EditMask := '99/99/9999;1;_';
//  (cdsConsulta.FieldByName('DTAENT') As TDateField).DisplayFormat := '99/99/9999;1;_';
End;

function TfrmCadCotFornecedor.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If Sender = edtCodFor Then
    Begin

      If (Not fEmptyStr(edtCodFor.Text)) Then
      Begin

        edtNomFor.Text := fRetNomFornecedor(edtCodFor.Text);
        If fEmptyStr(edtNomFor.Text) Then
        Begin
          fMensagem('AVISO','Código do fornecedor não encontrado.', ['&O K']);
          edtCodFor.Clear;
          Result := FALSE;
        End Else
        If blnValidaIndividual Then
        Begin
          cdsConsulta.Locate('CODFOR',edtCodFor.Text,[]);
          pIncluiFornecedor;
          blnMudarFoco := FALSE;
        End;

      End Else
      Begin
        fMensagem('AVISO','Código do fornecedor em branco.', ['&O K']);
        Result := FALSE;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
    
end;

procedure TfrmCadCotFornecedor.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCotFornecedor.btnIncluirClick(Sender: TObject);
begin
  inherited;

  pIncluiFornecedor;

end;

procedure TfrmCadCotFornecedor.pLimpaFornecedor;
Begin
  edtCodFor.Clear;
  edtNomFor.Clear;
  pSetFocus(edtCodFor);
End;

Function TfrmCadCotFornecedor.fIncluiItensFornecedor(strCodFor: String): Boolean;
Begin
  Try
    cdsItensFornec.Tag := 1;

    With cdsItens Do
    Begin
      DisableControls;

      First;
      While Not Eof Do
      Begin

        cdsItensFornec.Insert;

        cdsItensFornec.FieldByName('AUTOINCREM').AsString := FieldByName('CODITE').AsString;
        cdsItensFornec.FieldByName('CODFOR').AsString     := cdsConsulta.FieldByName('CODFOR').AsString;
        cdsItensFornec.FieldByName('NOMFOR').AsString     := cdsConsulta.FieldByName('NOMFOR').AsString;
        cdsItensFornec.FieldByName('CODITE').AsString     := FieldByName('CODITE').AsString;
        cdsItensFornec.FieldByName('CODFAB').AsString     := FieldByName('CODFAB').AsString;
        cdsItensFornec.FieldByName('CODSIM').AsString     := FieldByName('CODSIM').AsString;
        cdsItensFornec.FieldByName('CODSEM').AsString     := FieldByName('CODSEM').AsString;
        cdsItensFornec.FieldByName('CODGRU').AsString     := FieldByName('CODGRU').AsString;
        cdsItensFornec.FieldByName('REFERE').AsString     := FieldByName('REFERE').AsString;
        cdsItensFornec.FieldByName('SIGUNI').AsString     := FieldByName('SIGUNI').AsString;
        cdsItensFornec.FieldByName('DESMAR').AsString     := FieldByName('DESMAR').AsString;        
        cdsItensFornec.FieldByName('DESITE').AsString     := FieldByName('DESITE').AsString;
        cdsItensFornec.FieldByName('QTDITE').AsFloat      := FieldByName('QTDITE').AsFloat;
        cdsItensFornec.FieldByName('IPIENT').AsFloat      := FieldByName('IPIENT').AsFloat;
        cdsItensFornec.FieldByName('SUBSTI').AsFloat      := FieldByName('SUBSTI').AsFloat;
        cdsItensFornec.FieldByName('VALUNI').AsFloat      := 0;
        cdsItensFornec.FieldByName('VALTOT').AsFloat      := 0;
        cdsItensFornec.FieldByName('PREESC').AsInteger    := 0;
        cdsItensFornec.FieldByName('CODUNI').AsString     := FieldByName('CODUNI').AsString;;

        cdsItensFornec.FieldByName('DTAULT').Value        := FieldByName('DTAULT').Value;
        cdsItensFornec.FieldByName('FORULT').Value        := FieldByName('FORULT').Value;
        cdsItensFornec.FieldByName('PREULT').Value        := FieldByName('PREULT').Value;
        cdsItensFornec.FieldByName('APLICA').Value        := Trim(FieldByName('APLICA').Value);

        cdsItensFornec.Post;

        Next;
      End;

      EnableControls;

    End;

    cdsItensFornec.Tag := 0;

    Result := TRUE;

  Except
    On E: Exception Do
    Begin
      cdsItensFornec.Tag := 0;
      cdsItens.EnableControls;
      Result := False;
      pMensagensErro(E.Message, '[fIncluiItensFornecedor]');
    End;
  End;

End;

procedure TfrmCadCotFornecedor.pIncluiFornecedor;
Begin
  Try
    pLimpaPesquisa;

    If cdsItens.IsEmpty Then
    Begin
      fMensagem('AVISO','Para inclusão de Fornecedores é necessário incluir pelo menos 1 item!', ['&O K']);
      Exit;
    End;

    If fVerificaCampos Then
    With cdsConsulta Do
    Begin
      cdsConsulta.Tag := 1;
      DisableControls;
      If Not Locate('CODFOR',edtCodFor.Text,[]) Then
      Begin
        Insert;
        FieldByName('AUTOINCREM').AsString := edtCodFor.Text;
        FieldByName('CODFOR').AsString     := edtCodFor.Text;
        FieldByName('NOMFOR').AsString     := edtNomFor.Text;
        FieldByName('UTILIZ').AsString     := 'S';        

        If fIncluiItensFornecedor(edtCodFor.Text) Then
          Post
        Else
          Cancel;

      End;
      cdsConsulta.Tag := 0;

      EnableControls;
    End;

    pLimpaFornecedor;

  Except
    On E: Exception Do
    Begin
      cdsConsulta.Tag := 0;
      cdsConsulta.EnableControls;
      pMensagensErro(E.Message, '[pIncluiFornecedor]');
    End;
  End;

End;

Function TfrmCadCotFornecedor.fExcluiItensFornecedor(strCodFor: String): Boolean;
Begin
  Try

    With cdsItensFornec Do
    Begin
      DisableControls;
      Filtered := FALSE;
      While Locate('CODFOR', strCodFor, []) Do
        Delete;
      Filtered := TRUE;
      EnableControls;
    End;

    Result := TRUE;

  Except
    On E: Exception Do
    Begin
      Result := False;
      cdsItensFornec.EnableControls;
      pMensagensErro(E.Message, '[fExcluiItensFornecedor]');
    End;
  End;

End;

procedure TfrmCadCotFornecedor.pExcluiFornecedor;
Begin

  With cdsConsulta Do
  Begin
    If IsEmpty Then
      Exit;
      
    If (fMensagem('', 'Confirma a exclusão do Fornecedor ' + FieldbyName('CODFOR').AsString +
                 '-' + FieldbyName('NOMFOR').AsString + '?', ['&Sim', '&Não']) = 1) Then
    Begin
      If fExcluiItensFornecedor(FieldbyName('CODFOR').AsString) Then
        Delete;
    End;
  End;    

End;

procedure TfrmCadCotFornecedor.btnForPreClick(Sender: TObject);
  var
    objForPre: TForPre;
    intIndice: Integer;
    strFiltro: String;
begin
  inherited;

  If Not btnForPre.Visible Then
    Exit;  

  If stlListSelecao.Count = 0 Then
  Begin
    fMensagem('','Selecione os fornecedores!', ['&O K']);
    Exit;
  End;

  If fMensagem('','Deseja utilizar preços do cadastro de Fornecedor (Produtos/Preços)!', ['', '']) <> 1 Then
    Exit;

  Try

    objForPre := TForPre.Create(Self);

    strFiltro := cdsItensFornec.Filter;

    cdsItensFornec.DisableControls;
    pgbProgresso.Visible := True;

    For intIndice := 0 To stlListSelecao.Count - 1 Do
    Begin
      objForPre.strCodFor := Copy(stlListSelecao[intIndice],2,8);
      objForPre.pCarregarItens;

      cdsItensFornec.Filtered := False;
      cdsItensFornec.Filter   := 'CODFOR = ' + QuotedStr(objForPre.strCodFor);
      cdsItensFornec.Filtered := True;

      pgbProgresso.Max := cdsItensFornec.RecordCount;
      pgbProgresso.Position := 0;

      cdsItensFornec.First;

      While Not cdsItensFornec.Eof Do
      Begin
        Application.ProcessMessages;

        cdsItensFornec.Edit;

        cdsItensFornec.FieldByName('VALUNI').AsFloat := 0.00;
        cdsItensFornec.FieldByName('IPIENT').AsFloat := 0.00;
        cdsItensFornec.FieldByName('SUBSTI').AsFloat := 0.00;

        If objForPre.cdsItens.Locate('CODITE', cdsItensFornec.FieldByName('CODITE').AsString, []) Then
          cdsItensFornec.FieldByName('VALUNI').AsFloat := objForPre.cdsItens.FieldByName('VALITE').AsFloat;

        cdsItensFornec.Post;

        cdsItensFornec.Next;
        pgbProgresso.StepBy(1);
      End;

    End;

    FreeAndNil(objForPre);

    fMensagem('','Atualização realizada com sucesso!', ['&OK']);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;

  cdsItensFornec.EnableControls;

  pgbProgresso.Visible    := False;
  cdsItensFornec.Filtered := False;
  cdsItensFornec.Filter   := strFiltro;
  cdsItensFornec.Filtered := True;

end;

procedure TfrmCadCotFornecedor.btnExcluirClick(Sender: TObject);
begin
  inherited;
  pExcluiFornecedor;  
end;

procedure TfrmCadCotFornecedor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  Action := caNone;

end;

procedure TfrmCadCotFornecedor.FormCreate(Sender: TObject);
begin
  inherited;

  blnFecharComEscape := False;
end;

Function TfrmCadCotFornecedor.fGetDadosFornecedor(strCodFor: String; Var strNomFor, strEmail, strContato: String): Boolean;
  Var
    qryCadFor: TUniQuery;
Begin
  Result := FALSE;

  Try
    qryCadFor := fCriaQuery;
    With qryCadFor, SQL Do
    Begin
      Clear;
      Add('SELECT');
      Add('  FOR_NOMFOR,');
      Add('  FOR_CONTAT,');
      Add('  FOR_EMAIL_ ');
      Add('FROM');
      Add('  CADFOR');
      Add('WHERE');
      Add('  FOR_CODFOR = :CODFOR');

      ParamByName('CODFOR').AsString := strCodFor;

      Open;

      If Not IsEmpty Then
      Begin
        strNomFor  := FieldByName('FOR_NOMFOR').AsString;
        strContato := FieldByName('FOR_CONTAT').AsString;
        strEmail   := FieldByName('FOR_EMAIL_').AsString;
        Result := TRUE;
      End

    End;
    FreeAndNil(qryCadFor);

  Except

    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fGetDadosFornecedor]');
    End;

  End;

End;

procedure TfrmCadCotFornecedor.pExportarArquivos;
  Var
    strIndNam,
    strNomArq: String;
    intIndice: Integer;
    blnFilter: Boolean;
    strNomFor,
    strEmail,
    strContato: String;

    frxReportJ: TfrxReport;
Begin
  If stlListSelecao.Count = 0 Then
  Begin
    fMensagem('','Selecione os fornecedores para exportação!', ['&O K']);
    Exit;
  End;

  Try

    If Not DirectoryExists(ExtractFilePath(Application.ExeName) + 'COTACOES') Then
      CreateDir(ExtractFilePath(Application.ExeName) + 'COTACOES');

    If Not DirectoryExists(strDirExp) Then
      CreateDir(strDirExp);

    If Not DirectoryExists(ExtractFilePath(Application.ExeName) + 'COTACOES\IMPORTAR') Then
      CreateDir(ExtractFilePath(Application.ExeName) + 'COTACOES\IMPORTAR');

    pCriarFormularios(TfrmModuloCotExportacao, frmModuloCotExportacao);

    With frmModuloCotExportacao Do
    Begin
      cdsItensMod := cdsItens;
      cdsItensFornecMod := cdsItensFornec;

      cdsItens.DisableControls;
      cdsItensFornecMod.DisableControls;
      cdsItensFornecMod.Filtered := FALSE;

      dtsItens.DataSet := cdsItens;

      strIndNam := cdsItens.IndexFieldNames;
      blnFilter := cdsItens.Filtered;

      cdsItens.IndexFieldNames := 'CODITE';
      cdsItens.Filtered := FALSE;

      For intIndice := 0 To stlListSelecao.Count - 1 Do
      Begin
        strCodFor := Copy(stlListSelecao[intIndice],2,8);

        FCodFor := strCodFor;

        If fGetDadosFornecedor(strCodFor, strNomFor, strEmail, strContato) Then
        Begin

          pCriarFormularios(TfrmCadCotEmail, frmCadCotEmail);
          frmCadCotEmail.lblFornecedor.Caption := 'Fornecedor: ' + strCodFor + ' - ' + strNomFor;
          frmCadCotEmail.edtEmail.Text         := strEmail;
          frmCadCotEmail.edtContato.Text       := strContato;

          If frmCadCotEmail.ShowModal = mrOk Then
          Begin
            Case frmCadCotEmail.rdgOrdenacao.ItemIndex Of
              1:   cdsItens.IndexFieldNames := 'DESITE';
              2:   cdsItens.IndexFieldNames := 'DESMAR;DESITE';
              Else cdsItens.IndexFieldNames := 'CODITE';
            End;

            cdsItens.First;

            strNomArq := 'COT' + strNumCot + '_' + strCodEmp + '_' + strCodFor;

            If frmCadCotEmail.rdgGerArq.ItemIndex = 0 Then
            Begin
              strNomArq := strDirExp + '\' + strNomArq + '.xls';
              pExportarExcel(strNomArq, frmCadCotEmail.rdgOrdenacao.ItemIndex);
            End
            Else
            Begin
              TfrxMemoView(frxReportPDF.FindComponent('rdbMsgLv1')).Visible := frmCadCotEmail.chkMsgLivre.Checked;
              TfrxMemoView(frxReportPDF.FindComponent('rdbAplica')).Visible := frmCadCotEmail.chkExbAplicProd.Checked;

              frxReportJ := frxReportPDF;
              frxPDFExport.FileName    := strNomArq + '.pdf';
              frxPDFExport.DefaultPath := strDirExp;
              frxPDFExport.ShowDialog  := False;

              If FileExists(fCfgSis('PATLOG')) Then
                frxReportJ.Script.Variables['IMAGEM'] := fCfgSis('PATLOG')
              Else
                frxReportJ.Script.Variables['IMAGEM'] := '';

              If frmCadCotEmail.chkExbAplicProd.Checked Then
                frxReportJ.Script.Variables['BLNAPLICA'] := 'T'
              Else
                frxReportJ.Script.Variables['BLNAPLICA'] := 'F';

              frxReportJ.Script.Variables['BLNMSGLIV']   := frmCadCotEmail.chkMsgLivre.Checked;

              frxReportJ.Script.Variables['COTACAO']     := 'COTAÇÃO DE PREÇOS: ' + strNumCot;
              frxReportJ.Script.Variables['COMPRADOR']   :=  fRetNomVendRep(cdsCotac.FieldByName('COT_CODCMP').AsString);
              frxReportJ.Script.Variables['FORNECEDOR']  :=  strCodFor + '-' +
                                                             fRetNomFornecedor(Copy(stlListSelecao[intIndice],2,8));
              frxReportJ.PrepareReport;

              frxReportJ.Export(frxPDFExport);
              strNomArq := frxPDFExport.FileName;
            End;

            If frmCadCotEmail.chkEnvEma.Checked Then
            Begin
              EnviarEMailComAnexo('', AnsiString(frmCadCotEmail.edtEmail.Text), 'COTAÇÃO Nº ' + AnsiString(strNumCot), 'Segue arquivo em anexo.',
                                  AnsiString(strNomArq), TRUE);
            End
            Else
              fMensagem('ATENÇÃO', 'Arquivo Salvo em: ' + strNomArq, ['&OK']);


          End; {If frmCadCotEmail.ShowModal = mkOk Then}

          FreeAndNil(frmCadCotEmail);

        End; {If fGetDadosFornecedor(strCodFor, strNomFor, strEmail, strContato) Then}

      End;

      cdsItens.IndexFieldNames := strIndNam;
      cdsItens.Filtered        := blnFilter;
      cdsItens.EnableControls;

      cdsItensFornecMod.EnableControls;
      cdsItensFornecMod.Filtered := TRUE;
    End;

    FreeAndNil(frmModuloCotExportacao);

  Except

    On E: Exception Do
    Begin
      cdsItens.EnableControls;
      pMensagensErro(E.Message, '[pExportarArquivos]');
    End;

  End;

End;

procedure TfrmCadCotFornecedor.btnMarDesClick(Sender: TObject);
begin
  inherited;

  pAddListaQuery;
  dbgConsulta.Repaint;
  pSetFocus(dbgConsulta);
end;

procedure TfrmCadCotFornecedor.dbgConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_ESCAPE: Begin
                 If Shift = [ssCtrl] Then
                   Key := 0;
               End;
  End;
end;

procedure TfrmCadCotFornecedor.btnExpArqClick(Sender: TObject);
begin
  inherited;

  pExportarArquivos;
end;


procedure TfrmCadCotFornecedor.pImportaArquivos;
//  Const
//    LINHA_INICIAL = 13;
  var
    strNomArq,
    strCodFor: String;
    intIndice,
    intConLin,
    intMaxLin: Integer;
    Excel    : TExcel;
    strCodIte: String;

    fltValUni,
    fltIPIEnt,
    fltSubsti: Double;

    intColCod,
    intColUni,
    intColIpi,
    intColSub: Integer;

    intLinhaInicial: Integer;

    function fEncontrouColunas: Boolean;
    begin
      Result := True;

      If Result And Excel.LocalizarCelula(TIT_CODIGO) Then
        intColCod := Excel.ColunaAtual
      Else
        Result := False;

      If Result And Excel.LocalizarCelula(TIT_PRECO) Then
        intColUni := Excel.ColunaAtual
      Else
        Result := False;

      If Result And Excel.LocalizarCelula(TIT_IPI) Then
        intColIpi := Excel.ColunaAtual
      Else
        Result := False;

      If Result And Excel.LocalizarCelula(TIT_ST) Then
        intColSub := Excel.ColunaAtual
      Else
        Result := False;

      If Result Then
        intLinhaInicial := Excel.LinhaAtual + 1
      Else
        pMensagemOk('O Layout do arquivo ' + ExtractFileName(strNomArq) + ' é inválido, ' + #13#10 +
                    'o mesmo deve conter as colunas: ' + #13#10 +
                    TIT_CODIGO + ', ' + TIT_PRECO + ', ' + TIT_IPI + ' e ' + TIT_ST + ' !');
    end;

Begin
  Try
    pCriarFormularios(TfrmCadCotImportacao, frmCadCotImportacao);

    With frmCadCotImportacao Do
    Begin
      chlLisArq.Clear;

      With cdsConsulta Do
      Begin
        DisableControls;
        First;
        While Not Eof Do
        Begin
          strNomArq := strDirImp +  '\COT' + strNumCot + '_' +  strCodEmp + '_' + FieldByName('CODFOR').AsString + '.xls';

          If FileExists(strNomArq) Then
          Begin
            chlLisArq.Items.Add(FieldByName('CODFOR').AsString + ' - ' + FieldByName('NOMFOR').AsString);
            chlLisArq.Checked[Pred(chlLisArq.Count)] := TRUE;
          End;

          Next;
        End;
        EnableControls;
      End;

      If ShowModal = mrOk Then
      Begin

        cdsItensFornec.DisableControls;
        cdsItensFornec.Filtered := FALSE;
        pgbProgresso.Visible := TRUE;

        For IntIndice := 0 To chlLisArq.Count - 1 Do
        If chlLisArq.Checked[IntIndice] Then
        Begin
          strCodFor := LeftStr(chlLisArq.Items[intIndice],8);

          strNomArq := strDirImp + '\COT' + strNumCot + '_' +  strCodEmp + '_' + strCodFor + '.xls';

          Try
            Excel := TExcel.fCriarExcel(Self);

            Excel.AbrirArquivo(strNomArq);

            Excel.DesprotegerPlanilha(SEN_ADM);
            Excel.DesprotegerEstrutura(SEN_ADM);

            If fEncontrouColunas Then
            Begin
              intMaxLin := Excel.MaximodeLinhas;

              pgbProgresso.Max := intMaxLin - intLinhaInicial + 1;
              pgbProgresso.Position := 0;

              For intConLin := intLinhaInicial To intMaxLin Do
              Begin
                Application.ProcessMessages;

                strCodIte := Excel.Ler_Celula(fGetLetraAlfa(intColCod) + IntToStr(intConLin));

                If Not fEmptyStr(strCodIte) Then
                Begin

                  fltValUni := fStrToFloat(AnsiReplaceStr(Excel.Ler_Celula(fGetLetraAlfa(intColUni) + IntToStr(intConLin)),'.',','));
                  fltIpiEnt := fStrToFloat(AnsiReplaceStr(Excel.Ler_Celula(fGetLetraAlfa(intColIpi) + IntToStr(intConLin)),'.',','));
                  fltSubsti := fStrToFloat(AnsiReplaceStr(Excel.Ler_Celula(fGetLetraAlfa(intColSub) + IntToStr(intConLin)),'.',','));

                  If cdsItensFornec.Locate('CODFOR;CODITE', VarArrayOf([strCodFor, strCodIte]), []) Then
                  Begin
                    cdsItensFornec.Edit;
                    cdsItensFornec.FieldByName('VALUNI').AsFloat := fltValUni;
                    cdsItensFornec.FieldByName('IPIENT').AsFloat := fltIPIEnt;
                    cdsItensFornec.FieldByName('SUBSTI').AsFloat := fltSubsti;
                    cdsItensFornec.Post;
                  End;
                End;

                pgbProgresso.StepBy(1);
              End;

            End;

          Except
            On E: Exception Do
            Begin
              pMensagensErro(E.Message, '');
            End;
          End;

          Excel.FecharArquivo;

        End;

        pgbProgresso.Visible := FAlSE;
        cdsItensFornec.Filtered := TRUE;
        cdsItensFornec.EnableControls;

        fMensagem('','Arquivos importados com sucesso!', ['&O K']);
      End;

    End;

    FreeAndNil(frmCadCotImportacao);

  Except

    On E: Exception Do
    Begin
      cdsConsulta.EnableControls;
      cdsItensFornec.EnableControls;
      cdsItensFornec.Filtered := TRUE;
      pMensagensErro(E.Message, '[pExportarArquivos]');
    End;

  End;
    
End;

procedure TfrmCadCotFornecedor.btnImpArqClick(Sender: TObject);
begin
  inherited;
  pImportaArquivos;
end;

procedure TfrmCadCotFornecedor.pDesabilitaAlteracao;
Begin
  pnlTail.Visible   := FALSE;
  btnMarDes.Visible := FALSE;
  btnImpArq.Visible := FALSE;
  btnExpArq.Visible := FALSE;
End;

procedure TfrmCadCotFornecedor.pExcelImprimeFiltros(Excel: TExcel; Dados: TDataSet;
  Campos: TCampos; Filtros: Array Of String);

  procedure pTitulo(intLinha: Integer; CorDaFonte: TCorExcel; intFonte: Integer; opcAlinhamento: TAlinhamentoExcel; strTitulo: String);
    var
      strLinha: String;
  begin
    strLinha := IntToStr(intLinha);

    With Excel, Campos Do
    Begin
      Mesclar     ('A' + strLinha, fGetLetraAlfa(Colunas.Count) + strLinha);
      Alinhamento ('A' + strLinha, fGetLetraAlfa(Colunas.Count) + strLinha, opcAlinhamento);
      Negrito     ('A' + strLinha, fGetLetraAlfa(Colunas.Count) + strLinha, True);
      CorFonte    ('A' + strLinha, fGetLetraAlfa(Colunas.Count) + strLinha, CorDaFonte);
      DefinirFonte('A' + strLinha, fGetLetraAlfa(Colunas.Count) + strLinha, Arial, intFonte);

      Escrever(intLinha, 1, strTitulo);
    End;
  end;

begin
  Excel.PintarTudo(Branco);

  pTitulo(1, Preto, 16, Centro, fRetNomeEmpresa);

  pTitulo(Excel.ProximaLinha, Preto, 16, Centro,'DEPARTAMENTO DE COMPRAS');

  pTitulo(Excel.ProximaLinha, Vermelho, 16, Centro, 'COTAÇÃO DE PREÇOS: ' + strNumCot);

  pTitulo(Excel.ProximaLinha, Preto, 10, Centro, 'FORNECEDOR: ' + FCodFor + '-' + fRetNomFornecedor(FCodFor));
  pTitulo(Excel.ProximaLinha, Preto, 10, Centro, 'COMPRADOR: ' + fRetNomVendRep(cdsCotac.FieldByName('COT_CODCMP').AsString));
end;


procedure TfrmCadCotFornecedor.pFimGeracaoExcel(Excel: TExcel; Campos: TCampos);
begin
//  Excel.ExcluirPlanilha(3);
//  Excel.ExcluirPlanilha(2);

  Excel.ProtegerEstrutura(SEN_ADM);
  Excel.ProtegerPlanilha(SEN_ADM);
end;

procedure TfrmCadCotFornecedor.pImprimeDetalhes(Excel: TExcel; Dados: TDataSet; Campos: TCampos; CorFundo: TCorExcel);

  function fCelula(strCampo: String): String;
  begin
    Result := Campos.ColunaPorNome[strCampo].Letra + IntToStr(Excel.LinhaAtual);
  end;

begin

  With Excel, Campos Do
  Begin
    BloquearCelulas(fCelula('VALUNI'), fCelula('VALUNI'), False);
    BloquearCelulas(fCelula('IPIENT'), fCelula('IPIENT'), False);
    BloquearCelulas(fCelula('SUBSTI'), fCelula('SUBSTI'), False);

    ValidarCelulas(fCelula('VALUNI'), fCelula('VALUNI'), '0', '99999999');
    ValidarCelulas(fCelula('IPIENT'), fCelula('IPIENT'), '0', '100');
    ValidarCelulas(fCelula('SUBSTI'), fCelula('SUBSTI'), '0', '100');


    If frmCadCotEmail.chkExbAplicProd.Checked And
      Not fEmptyStr(Dados.FieldByName('APLICA').AsString) Then
    Begin
      Escrever(LinhaAtual,Campos.ColunaPorNome['DESITE'].Coluna,Dados.FieldByName('DESITE').AsString);
      FormatoNumerico(LinhaAtual, Campos.ColunaPorNome['DESITE'].Coluna, '');
      AlinhamentoVertical('A' + intToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + intToStr(LinhaAtual), xlsTop);
    End;
  End;

end;

procedure TfrmCadCotFornecedor.pExportarExcel(strNomArq: String; intOrdem: Integer);
  var
    qryCadEmp: TUniQuery;
    strFilAnt: String;
    objGeraExcel: TGeraExcel;

  procedure pCriaDados;
  begin
    strFilAnt := cdsItensFornec.Filter;

    cdsItensFornec.Filtered := False;
    cdsItensFornec.Filter   := 'CODFOR = ' + QuotedStr(FCodFor);
    cdsItensFornec.Filtered := True;

    cdsDados := fCriaClientDatset(cdsItensFornec);

    Case intOrdem Of
      1:   cdsDados.IndexFieldNames := 'DESITE';
      2:   cdsDados.IndexFieldNames := 'DESMAR;DESITE';
      Else cdsDados.IndexFieldNames := 'CODITE';
    End;

    cdsItensFornec.Filtered := False;
    cdsItensFornec.Filter   := strFilAnt;
    cdsItensFornec.Filtered := True;
    cdsItensFornec.First;
  End;

  procedure pLeEmpresa;
    Var
      strSQL: String;
  Begin
    qryCadEmp := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  EMP_NOMEMP, ';
    strSQL := strSQL + '  EMP_NOMFAN, ';
    strSQL := strSQL + '  CONCAT(EMP_ENDERE, ", ", IFNULL(EMP_ENDNUM,""), "  ", IF(IFNULL(EMP_ENDCMP, "") = "", "", CONCAT("  ", EMP_ENDCMP)), " - ", EMP_BAIRRO) AS EMP_ENDERE, ';
    strSQL := strSQL + '  CONCAT(CADCID.CID_NOMCID, "-", CADCID.CID_ESTADO, "   CEP: ", EMP_C_E_P_) AS EMP_NOMCID, ';
    strSQL := strSQL + '  EMP_FONE01, ';
    strSQL := strSQL + '  EMP_F_A_X_, ';
    strSQL := strSQL + '  EMP_EMAIL_ ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP, ';
    strSQL := strSQL + '  CADCID ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CADEMP.EMP_CODCID = CADCID.CID_CODCID AND ';
    strSQL := strSQL + '  CADEMP.EMP_CODEMP = :CODEMP ';

    With qryCadEmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
    End;

  end;

begin

  If FileExists(strNomArq) Then
    If Not DeleteFile(strNomArq) Then
    Begin
      fMensagem('','Não é possível gerar o arquivo, ' +
                   'verifique se o mesmo está sendo utilizado!', ['&Ok']);
      Exit;
    End;

  Try

    pCriaDados;

    objGeraExcel := TGeraExcel.Create(cdsDados, pgbProgresso);

    objGeraExcel.strNomArq := strNomArq;
    objGeraExcel.blnImpEmp := False;

    pLeEmpresa;

    objGeraExcel.strNomRel := fRetFantasiaEmpresa;
    objGeraExcel.intFonteNomRel := 16;

    objGeraExcel.AddFiltro(qryCadEmp.FieldByName('EMP_ENDERE').AsString);
    objGeraExcel.AddFiltro(qryCadEmp.FieldByName('EMP_NOMCID').AsString);
    objGeraExcel.AddFiltro('Fone.: ' + qryCadEmp.FieldByName('EMP_FONE01').AsString);
    objGeraExcel.AddFiltro('Fax..: ' + qryCadEmp.FieldByName('EMP_F_A_X_').AsString);
    objGeraExcel.AddFiltro('Email: ' + qryCadEmp.FieldByName('EMP_EMAIL_').AsString);

    objGeraExcel.OnImpFiltros  := pExcelImprimeFiltros;
    objGeraExcel.OnImpDetalhes := pImprimeDetalhes;
    objGeraExcel.OnFimGeracao  := pFimGeracaoExcel;

    objGeraExcel.AddCampo(FRetCodIte, 'CODITE', TIT_CODIGO);
    objGeraExcel.AddCampo('CODFAB', 'Código Fábrica');
    objGeraExcel.AddCampo('DESITE', 'Descrição');
    objGeraExcel.AddCampo('REFERE', 'Referência');
    objGeraExcel.AddCampo('DESMAR', 'Marca');
    objGeraExcel.AddCampo('SIGUNI', 'UN');
    objGeraExcel.AddCampo('QTDITE', 'Quant.');
    objGeraExcel.AddCampo('VALUNI', TIT_PRECO);
    objGeraExcel.AddCampo('IPIENT', TIT_IPI);
    objGeraExcel.AddCampo('SUBSTI', TIT_ST);
    objGeraExcel.AddCampo('APLICA', 'Aplicação');
    objGeraExcel.AddCampo('CODSEM', 'Semelhantes');

    objGeraExcel.fGerarRelatorio;

  Except
    On E: Exception Do
    Begin
      If Not VarIsEmpty(objGeraExcel.objExcel.Excel) Then
        objGeraExcel.objExcel.FecharArquivo;

      pMensagensErro(E.Message, '');
    End;
  End;

  FreeAndNil(objGeraExcel);
  FreeAndNil(qryCadEmp);
  FreeAndNil(cdsDados);

end;

function TfrmCadCotFornecedor.FRetCodIte: string;
begin
  Result := '''' + cdsDados.FieldByName('CODITE').AsString;
end;

end.


