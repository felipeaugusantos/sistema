unit untImportacaoMetas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Buttons, BitBtnLockedIncrem, Data.DB, Vcl.Grids, Vcl.DBGrids, DBGridCitel,
  Datasnap.DBClient, UniClientDataSet, untTValidaExcel, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxProgressBar,
  Vcl.Menus, cxButtons, frxClass, untImportacaoArquivo, Math, Types, DBAccess,
  Uni, untTypesSistema, System.Generics.Collections, System.StrUtils;

type
  TfrmImportacaoMetas = class(TForm)
    pnlRodape: TPanel;
    btnImportacaoArquivo: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnSair: TBitBtnLocked;
    cdsDados: TUniClientDataSet;
    cdsDadosMET_CODVEN: TStringField;
    pnlFundo: TPanel;
    pgbBarraProgresso: TcxProgressBar;
    btnInfor: TcxButton;
    pnlInfor: TPanel;
    pnlInfo: TPanel;
    pnlNomeForm: TPanel;
    dtsDados: TUniDataSource;
    cdsDadosMET_CODEMP: TStringField;
    cdsDadosMET_MESANO: TStringField;
    pgcAbas: TPageControl;
    tbsDados: TTabSheet;
    dbgDados: TDBGridCitel;
    tbsErros: TTabSheet;
    pnlLegenda: TPanel;
    lblInfor: TLabel;
    dbgErros: TDBGridCitel;
    dtsErros: TUniDataSource;
    frxHelp: TfrxReport;
    procedure btnInforClick(Sender: TObject);
    procedure btnImportacaoArquivoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
  private
    strCaminhoArquivo: String;

    Const
      COL_CODEMP = 'A';
      COL_MESANO = 'B';
      COL_CODOPE = 'C';

      DES_CODEMP = 'Código Empresa';
      DES_MESANO = 'Período';
      DES_CODOPE = 'Código Operador';

    procedure pVerificaDadosImportados;
    procedure pAtualizaInfoValidador;
    procedure pMontaObjValidador;
    procedure pImportaDadosMetas;
    procedure pCarregaArquivo;
    procedure pAjustaPeriodo;
    procedure pValidaSomaPercentuais;
    procedure pLimpaCds;
    procedure pGravar;
    function fValidaCodEmp(strCodEmp: String; Var strMensagem: string): Boolean;
    function fValidaCodOpe(strCodOpe, strCodEmp: String; Var strMensagem: string): Boolean;
    function fValidaPeriodo(strMesAno: String; Var strMensagem: string): Boolean;
    function fValidaDadosBaseLinha(strCodEmp, strMesAno, strCodVen: String; intLinha: Integer): Boolean;
    function fPreencheDadosIniciasCds(intLinha: Integer): Boolean;
    function fValidaDadosArquivo: Boolean;
    function fTemTitulo: boolean;
    function fConfirmaGravacao: Boolean;

  protected
    objValidaExcel: TValidadorExcel;
    inlLinhasErro: TList<Integer>;
    intQtdColunas: Integer;
    blnTemTitulo: Boolean;

    function fValidaCodigo(strTabela: String; arrCampos: Array Of String; arrValores: Array Of Variant; Var strMensagem: String): Boolean;
    function fValidaPercentual(fltPercen: Double; Var strMensagem: string): Boolean;
    function fConverteStringPercentual(strConver: String): Double;
    function fGravar: Boolean; virtual; abstract;
    function fValidaPercentuais(cdsClone: TUniClientDataSet; strMesAno, strCodVen, strFiltro: String): Boolean; virtual; abstract;
    function fValidaSomaPercentuais(cdsClone: TUniClientDataSet; strMesAno, strCodVen, strFiltro, strCampo, strColuna: String): Boolean;
    procedure pLimpaDados;
    procedure pFormataCampoFloat(strNome: String);
    procedure pPreencheCdsDados(intLinha: Integer); virtual; abstract;
    procedure pMontaObjValidadorComplementar; virtual; abstract;
  public
    blnExibeMargem: Boolean;
  end;

implementation

uses untFuncoesSimples;

function TfrmImportacaoMetas.fValidaDadosArquivo: Boolean;
begin
  Result := False;

  pMontaObjValidador;

  If (objValidaExcel.intQtdLinhas < 0) Then
  Begin
    fMensagem('ATENÇÃO', 'Não foram encontrados dados para a importação. ', ['&Ok']);
    Exit;
  End;

  Result := True;
end;

procedure TfrmImportacaoMetas.pMontaObjValidador;
begin
  objValidaExcel := TValidadorExcel.Create(strCaminhoArquivo, intQtdColunas, COL_CODOPE, '', 0, [], True);
  objValidaExcel.FAtualizaStatus := pAtualizaInfoValidador;

  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(DES_CODOPE, COL_CODOPE, 3, False, False, '', '', True));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(DES_CODEMP, COL_CODEMP, 3, False, False, '', '', True));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(DES_MESANO, COL_MESANO, 0, False, False, '', '', False));

  pMontaObjValidadorComplementar;
end;

procedure TfrmImportacaoMetas.pAtualizaInfoValidador;
begin
  pnlInfo.Caption := objValidaExcel.TempoExtimado;
end;

procedure TfrmImportacaoMetas.pImportaDadosMetas;
  Var
    intValIni: Integer;
    intContador: Integer;
begin
  blnTemTitulo := fTemTitulo;
  intValIni := IIf(blnTemTitulo, 1 , 0);
  pgbBarraProgresso.Properties.Max := objValidaExcel.ArquivoCSV.Count - intValIni;
  pgbBarraProgresso.Position := 0;

  For intContador := intValIni To (objValidaExcel.ArquivoCSV.Count -1) Do
  Begin
    pnlInfo.Caption := 'Importando metas...'+ IIf(blnTemTitulo, IntToStr(intContador),
      IntToStr(intContador + 1)) + '/' + IntToStr(objValidaExcel.ArquivoCSV.Count - intValIni);

    pgbBarraProgresso.Position := pgbBarraProgresso.Position + 1;
    Application.ProcessMessages;

    If (intContador > objValidaExcel.ArquivoCSV.Count) Or (inlLinhasErro.IndexOf(intContador) <> -1) Then
      Continue;

    If (fPreencheDadosIniciasCds(intContador)) Then
      pPreencheCdsDados(intContador);
  End;

  pValidaSomaPercentuais;
  pVerificaDadosImportados;
end;

procedure TfrmImportacaoMetas.pVerificaDadosImportados;
begin
  If (Not objValidaExcel.getCdsErros.IsEmpty) And (objValidaExcel.getCdsErros.RecordCount > 0) Then
  Begin
    dtsErros.DataSet := objValidaExcel.getCdsErros;
    tbsErros.TabVisible := True;
  End;

  If (cdsDados.IsEmpty) Or (cdsDados.RecordCount <= 0) Then
  Begin
    fMensagem('ATENÇÃO', 'Não foram encontrados dados válidos para a importação', ['&Ok']);
    pgcAbas.ActivePage := tbsErros;
  End;
end;

function TfrmImportacaoMetas.fPreencheDadosIniciasCds(intLinha: Integer): Boolean;
  Var
    strCodEmp: String;
    strMesAno: String;
    strCodVen: String;
begin
  Result := False;

  strCodEmp := objValidaExcel.fGetValueCSV(intLinha, COL_CODEMP);
  strMesAno := objValidaExcel.fGetValueCSV(intLinha, COL_MESANO);
  strCodVen := objValidaExcel.fGetValueCSV(intLinha, COL_CODOPE);

  If (Not fValidaDadosBaseLinha(strCodEmp, strMesAno, strCodVen, intLinha)) Then
    Exit;

  cdsDados.Append;
  cdsDados.FieldByName('MET_CODEMP').AsString := strCodEmp;
  cdsDados.FieldByName('MET_MESANO').AsString := strMesAno;
  cdsDados.FieldByName('MET_CODVEN').AsString := strCodVen;
  cdsDados.Post;

  Result := True;
end;

procedure TfrmImportacaoMetas.FormCreate(Sender: TObject);
begin
  tbsErros.TabVisible := False;
  inlLinhasErro := TList<Integer>.Create;
  blnExibeMargem := False;
end;

procedure TfrmImportacaoMetas.FormDestroy(Sender: TObject);
begin
  If (Assigned(objValidaExcel)) Then
    FreeAndNil(objValidaExcel);
end;

procedure TfrmImportacaoMetas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key Of
    VK_ESCAPE: Close;
  End;
end;

function TfrmImportacaoMetas.fValidaPercentual(fltPercen: Double; Var strMensagem: string): Boolean;
begin
  Result := False;

  If (CompareValue(fltPercen, 0) <> GreaterThanValue) Or
    (CompareValue(fltPercen, 100) = GreaterThanValue) Then
  Begin
    strMensagem := 'Valor deve ser maior que 0 e menor ou igual a 100';
    Exit;
  End;

  Result := True;
end;

function TfrmImportacaoMetas.fValidaCodOpe(strCodOpe, strCodEmp: String; Var strMensagem: string): Boolean;
begin
  Result := False;

  If (fRetEmpresaOperador(strCodOpe) <> strCodEmp) Then
  Begin
    strMensagem := 'Vendedor '+ strCodOpe + ' não encontrado para a empresa '+ strCodEmp;
    Exit;
  End;

  Result := True;
end;

function TfrmImportacaoMetas.fValidaCodEmp(strCodEmp: String; Var strMensagem: string): Boolean;
  Const
    TABELA = 'CADEMP';
    CODEMP = 'EMP_CODEMP';
begin
  Result := False;

  If (Not fValidaCodigo(TABELA, [CODEMP], [strCodEmp], strMensagem)) Then
    Exit;

  Result := True;
end;

function TfrmImportacaoMetas.fValidaCodigo(strTabela: String; arrCampos: Array Of String;
  arrValores: Array Of Variant; Var strMensagem: String): Boolean;
begin
  Result := False;

  If (fEmptyStr(fCampoTabela(arrCampos[0], strTabela, arrCampos, arrValores))) Then
  Begin
    strMensagem := 'Código não encontrado';
    Exit;
  End;

  Result := True;
end;

function TfrmImportacaoMetas.fValidaPeriodo(strMesAno: String; Var strMensagem: string): Boolean;
begin
  Result := False;

  Try
    strMesAno := fTrataAnoDataMesAno(strMesAno);
    StrToDate('01/' + strMesAno);

    Result := True;
  Except
    strMensagem := 'Período '+ strMesAno + ' inválido';
  End;
end;

procedure TfrmImportacaoMetas.pValidaSomaPercentuais;
  Var
    cdsClone: TUniClientDataSet;
    stlFiltros: TStringList;
    strBase: String;
    stlErros: TStringList;
    strCodVen: String;
    strMesAno: String;
begin
  cdsClone := TUniClientDataSet.Create(Nil);
  stlFiltros := TStringList.Create;
  stlErros := TStringList.Create;
  pnlInfo.Caption := 'Validando soma dos percentuais...';
  pgbBarraProgresso.Properties.Max := cdsDados.RecordCount;
  pgbBarraProgresso.Position := 0;

  Try
    pCloneDataSet(cdsClone, cdsDados, False, True);
    cdsDados.First;

    While (Not cdsDados.Eof) Do
    Begin
      pgbBarraProgresso.Position := pgbBarraProgresso.Position + 1;
      Application.ProcessMessages;

      strCodVen := cdsDados.FieldByName('MET_CODVEN').AsString;
      strMesAno := cdsDados.FieldByName('MET_MESANO').AsString;

      strBase := 'MET_MESANO = ' + QuotedStr(strMesAno) + ' AND '+
                 'MET_CODVEN = ' + QuotedStr(strCodVen);

      If (stlFiltros.IndexOf(strBase) > -1) Then
      Begin
        If (stlErros.IndexOf(strBase) > -1) Then
          cdsDados.Delete
        Else
          cdsDados.Next;

        Continue;
      End
      Else
        stlFiltros.Add(strBase);

      If (Not fValidaPercentuais(cdsClone, strMesAno, strCodVen, strBase)) Then
      Begin
        cdsDados.Delete;
        stlErros.Add(strBase);
        Continue;
      End;

      cdsDados.Next;
    End;

    pnlInfo.Caption := '';
  Finally
    FreeAndNil(cdsClone);
    FreeAndNil(stlFiltros);
    FreeAndNil(stlErros);
  End;
end;

function TfrmImportacaoMetas.fValidaSomaPercentuais(cdsClone: TUniClientDataSet;
  strMesAno, strCodVen, strFiltro, strCampo, strColuna: String): Boolean;
  Var
    fltSoma: Double;
    strErro: String;
begin
  Result := False;
  fltSoma := 0;

  cdsClone.Filtered := False;
  cdsClone.Filter := strFiltro;
  cdsClone.Filtered := True;
  cdsClone.First;

  While (Not cdsClone.Eof) Do
  Begin
    fltSoma := fltSoma + cdsClone.FieldByName(strCampo).AsFloat;
    cdsClone.Next;
  End;

  If (CompareValue(fltSoma, 100) = LessThanValue) Or
     (CompareValue(fltSoma, 100) = GreaterThanValue) Then
  Begin
    strErro := IIF(fltSoma < 100, 'inferior', 'superior');
    objValidaExcel.pIncluirErroCds('Percentual', strColuna, '-',
      'Soma '+strErro+ ' a 100 no período '+strMesAno+ ' e vendedor '+ strCodVen +
      '. Valor total: '+ FloatToStr(fltSoma));
    Exit;
  End;

  Result := True;
end;

procedure TfrmImportacaoMetas.btnGravarClick(Sender: TObject);
begin
  pAjustaPeriodo;
  pGravar;
end;

procedure TfrmImportacaoMetas.btnImportacaoArquivoClick(Sender: TObject);
begin
  pCarregaArquivo;
end;

procedure TfrmImportacaoMetas.pCarregaArquivo;
  Var
    frmImportacaoArquivo: TfrmImportacaoArquivo;
begin
  pCriarFormularios(TfrmImportacaoArquivo, frmImportacaoArquivo);

  Try
    If (frmImportacaoArquivo.ShowModal = mrOk) Then
    Begin
      strCaminhoArquivo := frmImportacaoArquivo.edtCaminhoArquivo.Text;

      pLimpaDados;

      If (fValidaDadosArquivo) Then
        pImportaDadosMetas;
    End;

    btnGravar.Enabled := cdsDados.RecordCount > 0;
  Finally
    pFreeAndNil(frmImportacaoArquivo);
  End;
end;

procedure TfrmImportacaoMetas.pLimpaDados;
begin
  inlLinhasErro.Clear;
  dtsErros.DataSet := Nil;
  tbsErros.TabVisible := False;
  pgbBarraProgresso.Position := 0;
  pnlInfo.Caption := '';
  pLimpaCds;
end;

procedure TfrmImportacaoMetas.pLimpaCds;
begin
  If (cdsDados <> Nil) And (cdsDados.RecordCount > 0) Then
    cdsDados.EmptyDataSet;
end;

procedure TfrmImportacaoMetas.btnInforClick(Sender: TObject);
begin
  frxHelp.DotMatrixReport           := False;
  frxHelp.PrintOptions.PrintMode    := pmScale;
  frxHelp.PrintOptions.PrintOnSheet := 9;
  If blnExibeMargem Then
    frxHelp.Variables['blnExibeMargem'] := blnExibeMargem;

  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxHelp);
end;

procedure TfrmImportacaoMetas.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmImportacaoMetas.pFormataCampoFloat(strNome: String);
begin
  If cdsDados.FindField(strNome) <> nil Then
    TFloatField(cdsDados.FieldByName(strNome)).DisplayFormat := '#,##0.00';
end;

function TfrmImportacaoMetas.fTemTitulo: boolean;
  Var
    intValDef: Integer;
begin
  If objValidaExcel.fGetValueCSV(0, COL_CODOPE) <> '' Then
    Result := not TryStrToInt(Trim(objValidaExcel.fGetValueCSV(0, COL_CODOPE)), intValDef)
  Else
    Result := False;
end;

procedure TfrmImportacaoMetas.pAjustaPeriodo;
  Var
    strMesAno: String;
begin
  cdsDados.IndexFieldNames := '';
  cdsDados.First;

  While (Not cdsDados.Eof) Do
  Begin
    strMesAno := AnsiReplaceStr(cdsDados.FieldByName('MET_MESANO').AsString, '/', '');

    cdsDados.Edit;
    cdsDados.FieldByName('MET_MESANO').AsString := strMesAno;
    cdsDados.Post;

    cdsDados.Next;
  End;
end;

procedure TfrmImportacaoMetas.pGravar;
begin
  Try
    If (fConfirmaGravacao) And (fGravar) Then
    Begin
      fMensagem('INFORMAÇÃO', 'Dados gravados com sucesso', ['&Ok']);
      pLimpaDados;
      btnGravar.Enabled := False;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pGravar]');
    End;
  End;
end;

function TfrmImportacaoMetas.fConfirmaGravacao: Boolean;
begin
  Result := fMensagem('ATENÇÃO','Caso sejam encontrados dados já gravados para os '+
                                'períodos e vendedores que estão sendo importados, '+
                                'esses dados serão substituidos por os da importação atual. '+
                                'Confirma a importação das Metas?',['&Sim','&Não']) = 1;
end;

function TfrmImportacaoMetas.fConverteStringPercentual(strConver: String): Double;
  Var
    strNovVlr: String;
begin
  strNovVlr := fTiraCaracEspeciais(strConver, False, False, False, True, True, False, True, '%');
  Result := StrToFloatDef(strNovVlr, 0);
end;

function TfrmImportacaoMetas.fValidaDadosBaseLinha(strCodEmp, strMesAno, strCodVen: String; intLinha: Integer): Boolean;
  Var
    strMensagem: String;
    strLinha: String;
begin
  Result := False;
  strlinha := IntToStr(intLinha + 1);

  If (Not fValidaCodEmp(strCodEmp, strMensagem)) Then
  Begin
    objValidaExcel.pIncluirErroCds('Cód. Empresa', COL_CODEMP, strlinha, strMensagem);
    Exit;
  End;

  If (Not fValidaPeriodo(strMesAno, strMensagem)) Then
  Begin
    objValidaExcel.pIncluirErroCds('Período', COL_MESANO, strlinha, strMensagem);
    Exit;
  End;

  If (Not fValidaCodOpe(strCodVen, strCodEmp, strMensagem)) Then
  Begin
    objValidaExcel.pIncluirErroCds('Cód. Vendedor', COL_CODOPE, strlinha, strMensagem);
    Exit;
  End;

  Result := True;
end;

{$R *.dfm}

end.
