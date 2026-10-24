unit untExportarImagensProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  untPaiConfirma, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus,
  Vcl.Buttons, Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  EditFocus, Vcl.Samples.Gauges, cxGroupBox, cxProgressBar, Data.DB, MemDS,
  DBAccess, Uni, JPEG, PNGImage, untTypesSistema, System.UITypes;

type
  TfrmExportarImagensProdutos = class(TfrmPaiConfirma)
    pnlPrincipal: TPanel;
    pnlCaminhoExportacao: TPanel;
    cxGbCaminhoExportacao: TcxGroupBox;
    lblSelecionarCaminho: TLabel;
    spbAbrirSelecaoCaminho: TSpeedButton;
    edtCaminhoExportacao: TEditFocus;
    pnlFiltros: TPanel;
    cxGbFiltros: TcxGroupBox;
    edtCodProdutoDescricao: TEditFocus;
    edtCodProdutoCodigo: TEditFocus;
    lblCodProduto: TLabel;
    edtDescricao: TEditFocus;
    lblDescricao: TLabel;
    edtLinhaGrupoDescricao: TEditFocus;
    edtLinhaGrupoCodigo: TEditFocus;
    lblLinhaGrupo: TLabel;
    edtDepartamentoDescricao: TEditFocus;
    edtDepartamentoCodigo: TEditFocus;
    lblDepartamento: TLabel;
    edtUnidadeDescricao: TEditFocus;
    edtUnidadeCodigo: TEditFocus;
    lblUnidade: TLabel;
    edtFornecedorDescricao: TEditFocus;
    edtFornecedorCodigo: TEditFocus;
    lblFornecedor: TLabel;
    edtGrupoProdutosDescricao: TEditFocus;
    edtGrupoProdutosCodigo: TEditFocus;
    lblGrupoProdutos: TLabel;
    procedure spbAbrirSelecaoCaminhoClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtFornecedorCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure edtUnidadeCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure edtLinhaGrupoCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure edtDepartamentoCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure edtGrupoProdutosCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodProdutoCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure edtFornecedorCodigoExit(Sender: TObject);
    procedure edtCodProdutoCodigoExit(Sender: TObject);
    procedure edtLinhaGrupoCodigoExit(Sender: TObject);
    procedure edtDepartamentoCodigoExit(Sender: TObject);
    procedure edtUnidadeCodigoExit(Sender: TObject);
    procedure edtGrupoProdutosCodigoExit(Sender: TObject);
  private
    { Private declarations }

    arrFornecedor: TConsultasArray;
    arrUnidades: TConsultasArray;
    arrLinhasGrupos: TConsultasArray;
    arrDepartamento: TConsultasArray;
    arrGrupo: TConsultasArray;
    arrProdutos: TConsultasArray;

    oMmoLog: TMemo;

    function fExportarImagens(cxProgresso: TcxProgressBar): Boolean;
    procedure pExportarImagens(strCodIte: string);
    procedure pSalvarImagem(ABase64: string; AFile: string);
  public
    { Public declarations }
  end;

var
  frmExportarImagensProdutos: TfrmExportarImagensProdutos;

implementation

uses
  untGravando, untFuncoesSimples, untImagemBase64, untConsultas,
  untFuncoesConsulta;

{$R *.dfm}

procedure TfrmExportarImagensProdutos.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If Not DirectoryExists(edtCaminhoExportacao.Text) Then
  Begin
    MessageDlg('O diretório não existe. Verifique!', mtError, [mbOK], 0);
    Exit;
  End;
end;

procedure TfrmExportarImagensProdutos.edtUnidadeCodigoExit(Sender: TObject);
Var
  intContador: Integer;
begin
  inherited;

  if not fEmptyStr(edtUnidadeCodigo.Text) then
    edtUnidadeCodigo.Text := fStrZero(edtUnidadeCodigo.Text, 2);

  if (edtUnidadeCodigo.Text <> '00') OR (edtUnidadeDescricao.Text <> '+1') then
    edtUnidadeDescricao.Text := fRetNomUnidade(edtUnidadeCodigo.Text);

  if (fEmptyStr(edtUnidadeCodigo.Text)) OR (fEmptyStr(edtUnidadeDescricao.Text)) then
  begin
    edtUnidadeCodigo.Text := EmptyStr;
    edtUnidadeDescricao.Text := EmptyStr;

    For intContador := Low(arrUnidades) To High(arrUnidades) Do
      arrUnidades[intContador].strCodigo := '';
  end;
end;

procedure TfrmExportarImagensProdutos.edtUnidadeCodigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if fPesqUnidade(Self, edtUnidadeCodigo, edtUnidadeDescricao, Nil, Nil, Key, arrUnidades, False) then
  begin
    fValidaCampos(edtUnidadeCodigo, True);
  end;
end;

procedure TfrmExportarImagensProdutos.edtLinhaGrupoCodigoExit(Sender: TObject);
Var
  intContador: Integer;
begin
  inherited;

  if not fEmptyStr(edtLinhaGrupoCodigo.Text) then
    edtLinhaGrupoCodigo.Text := fStrZero(edtLinhaGrupoCodigo.Text, 6);

  if (edtLinhaGrupoCodigo.Text <> '000000') OR (edtLinhaGrupoDescricao.Text <> '+1') then
    edtLinhaGrupoDescricao.Text := fRetNomeLinhaGrupo(edtLinhaGrupoCodigo.Text);

  if (fEmptyStr(edtLinhaGrupoCodigo.Text)) OR (fEmptyStr(edtLinhaGrupoDescricao.Text)) then
  begin
    edtLinhaGrupoCodigo.Text := EmptyStr;
    edtLinhaGrupoDescricao.Text := EmptyStr;

    For intContador := Low(arrLinhasGrupos) To High(arrLinhasGrupos) Do
      arrLinhasGrupos[intContador].strCodigo := '';
  end;
end;

procedure TfrmExportarImagensProdutos.edtLinhaGrupoCodigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupo(Self, edtLinhaGrupoCodigo, edtLinhaGrupoDescricao, Nil, Key, arrLinhasGrupos, False) Then
  Begin
    fValidaCampos(edtLinhaGrupoCodigo, True);
  End;
end;

procedure TfrmExportarImagensProdutos.edtGrupoProdutosCodigoExit(
  Sender: TObject);
Var
  intContador: Integer;
begin
  inherited;

  if not fEmptyStr(edtGrupoProdutosCodigo.Text) then
    edtGrupoProdutosCodigo.Text := fStrZero(edtGrupoProdutosCodigo.Text, 5);

  if (edtGrupoProdutosCodigo.Text <> '00000') OR (edtGrupoProdutosDescricao.Text <> '+1') then
    edtGrupoProdutosDescricao.Text := fRetNomGrupoProdutos(edtGrupoProdutosCodigo.Text);

  if (fEmptyStr(edtGrupoProdutosCodigo.Text)) OR (fEmptyStr(edtGrupoProdutosDescricao.Text)) then
  begin
    edtGrupoProdutosCodigo.Text := EmptyStr;
    edtGrupoProdutosDescricao.Text := EmptyStr;

    For intContador := Low(arrGrupo) To High(arrGrupo) Do
      arrGrupo[intContador].strCodigo := '';
  end;
end;

procedure TfrmExportarImagensProdutos.edtGrupoProdutosCodigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupoProduto(Self, edtGrupoProdutosCodigo, edtGrupoProdutosDescricao, Nil, Key, arrGrupo, False) Then
  Begin
    fValidaCampos(edtGrupoProdutosCodigo, True);
  End;
end;

procedure TfrmExportarImagensProdutos.edtCodProdutoCodigoExit(Sender: TObject);
Var
  intContador: Integer;
begin
  inherited;

  if not fEmptyStr(edtCodProdutoCodigo.Text) then
    edtCodProdutoCodigo.Text := fStrZero(edtCodProdutoCodigo.Text, 5);

  if (edtCodProdutoCodigo.Text <> '00000') OR (edtCodProdutoDescricao.Text <> '+1') then
    edtCodProdutoDescricao.Text := fRetNomProduto(edtCodProdutoCodigo.Text);

  if (fEmptyStr(edtCodProdutoCodigo.Text)) OR (fEmptyStr(edtCodProdutoDescricao.Text)) then
  begin
    edtCodProdutoCodigo.Text := EmptyStr;
    edtCodProdutoDescricao.Text := EmptyStr;

    For intContador := Low(arrProdutos) To High(arrProdutos) Do
      arrProdutos[intContador].strCodigo := '';
  end;
end;

procedure TfrmExportarImagensProdutos.edtCodProdutoCodigoKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  if fPesqItem(conIteSimples, Self, edtCodProdutoCodigo, edtCodProdutoDescricao, nil, Key, arrProdutos, False) then
  begin
    fValidaCampos(edtCodProdutoCodigo, True);
  end;
end;

procedure TfrmExportarImagensProdutos.edtDepartamentoCodigoExit(
  Sender: TObject);
Var
  intContador: Integer;
begin
  inherited;

  if not fEmptyStr(edtDepartamentoCodigo.Text) then
    edtDepartamentoCodigo.Text := fStrZero(edtDepartamentoCodigo.Text, 3);

  if (edtDepartamentoCodigo.Text <> '000') OR (edtDepartamentoDescricao.Text <> '+1') then
    edtDepartamentoDescricao.Text := fRetDescDepartamento(edtDepartamentoCodigo.Text);

  if (fEmptyStr(edtDepartamentoCodigo.Text)) OR (fEmptyStr(edtDepartamentoDescricao.Text)) then
  begin
    edtDepartamentoCodigo.Text := EmptyStr;
    edtDepartamentoDescricao.Text := EmptyStr;

    For intContador := Low(arrDepartamento) To High(arrDepartamento) Do
      arrDepartamento[intContador].strCodigo := '';
  end;
end;

procedure TfrmExportarImagensProdutos.edtDepartamentoCodigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqDepartamento(Self, edtDepartamentoCodigo, edtDepartamentoDescricao, Nil, Key, arrDepartamento, False) Then
  Begin
    fValidaCampos(edtDepartamentoCodigo, True);
  End;
end;

procedure TfrmExportarImagensProdutos.edtFornecedorCodigoExit(Sender: TObject);
Var
  intContador: Integer;
begin
  inherited;

  if not fEmptyStr(edtFornecedorCodigo.Text) then
    edtFornecedorCodigo.Text := fStrZero(edtFornecedorCodigo.Text, 8);

  if (edtFornecedorCodigo.Text <> '00000000') OR (edtFornecedorDescricao.Text <> '+1') then
    edtFornecedorDescricao.Text := fRetNomFornecedor(edtFornecedorCodigo.Text);

  if (fEmptyStr(edtFornecedorCodigo.Text)) OR (fEmptyStr(edtFornecedorDescricao.Text)) then
  begin
    edtFornecedorCodigo.Text := EmptyStr;
    edtFornecedorDescricao.Text := EmptyStr;

    For intContador := Low(arrFornecedor) To High(arrFornecedor) Do
      arrFornecedor[intContador].strCodigo := '';
  end;
end;

procedure TfrmExportarImagensProdutos.edtFornecedorCodigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtFornecedorCodigo, edtFornecedorDescricao, Nil, Key, arrFornecedor, False) Then
    fValidaCampos(edtFornecedorCodigo, True);
end;

function TfrmExportarImagensProdutos.fExportarImagens(cxProgresso: TcxProgressBar): Boolean;
Var
  qryProdutos: TUniQuery;
begin
  oMmoLog.Clear;

  Result := False;

  qryProdutos := fCriaQuery;
  try
    qryProdutos.SQL.Add('SELECT DISTINCT IMG.ITE_CODITE FROM ITEIMG IMG');
    qryProdutos.SQL.Add('LEFT JOIN ITEGER IG ON IG.ITE_CODITE = IMG.ITE_CODITE');
    qryProdutos.SQL.Add('LEFT JOIN CADITE CI ON CI.ITE_CODITE = IMG.ITE_CODITE');
    qryProdutos.SQL.Add('WHERE TRUE');

    if edtCodProdutoCodigo.Text <> EmptyStr then
      qryProdutos.SQL.Add('AND IMG.ITE_CODITE in (' + fArrCodigosToLista(edtCodProdutoCodigo.text, arrProdutos) + ')');

    if edtDescricao.Text <> EmptyStr then
      qryProdutos.SQL.Add('AND CI.ITE_DESITE like :ITE_DESITE');

    if edtLinhaGrupoCodigo.Text <> EmptyStr then
      qryProdutos.SQL.Add('AND CI.ITE_CODGRU in (' + fArrCodigosToLista(edtLinhaGrupoCodigo.text, arrLinhasGrupos) + ')');

    if edtDepartamentoCodigo.Text <> EmptyStr then
      qryProdutos.SQL.Add('AND CI.ITE_CODDEP in (' + fArrCodigosToLista(edtDepartamentoCodigo.text, arrDepartamento) + ')');

    if edtUnidadeCodigo.Text <> EmptyStr then
      qryProdutos.SQL.Add('AND CI.ITE_CODUNI in (' + fArrCodigosToLista(edtUnidadeCodigo.text, arrUnidades) + ')');

    if edtFornecedorCodigo.Text <> EmptyStr then
      qryProdutos.SQL.Add('AND CI.ITE_CODFOR in (' + fArrCodigosToLista(edtFornecedorCodigo.text, arrFornecedor) + ')');

    if edtGrupoProdutosCodigo.Text <> EmptyStr then
      qryProdutos.SQL.Add('AND CI.ITE_PRDGRU in (' + fArrCodigosToLista(edtGrupoProdutosCodigo.text, arrGrupo) + ')');

    if edtDescricao.Text <> EmptyStr then
      qryProdutos.ParamByName('ITE_DESITE').AsString := '%' + edtDescricao.Text + '%';

    qryProdutos.SQL.Add('ORDER BY ITE_CODITE');
    qryProdutos.Open;

    if not (qryProdutos.RecordCount > 0) then
    begin
      MessageDlg('Nenhuma imagem encontrada para os filtros esolhidos!', mtError, [mbOK], 0);
      Exit;
    end;

    cxProgresso.Properties.Max := qryProdutos.RecordCount;

    qryProdutos.First;
    while not qryProdutos.Eof do
    begin
      pExportarImagens(qryProdutos.FieldByName('ITE_CODITE').AsString);
      qryProdutos.Next;

      cxProgresso.Position := qryProdutos.RecNo;
      Application.ProcessMessages;
    end;

    if oMmoLog.Text <> EmptyStr then
    begin
      try
        oMmoLog.Lines.SaveToFile(edtCaminhoExportacao.Text + '/log.txt');
      except
        on e: Exception do
        begin
          MessageDlg('Erro ao gravar arquivos!', mtError, [mbOK], 0);
          Exit;
        end;
      end;
    end;

    Result := True;
  finally
    FreeAndNil(qryProdutos);
  end;
end;

procedure TfrmExportarImagensProdutos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If (ModalResult = MrOk) Then
  Begin
    If TfrmGravando.fExecuta(fExportarImagens,  frmGravando, 'AGUARDE, EXPORTANDO IMAGENS ...') Then
    begin
      MessageDlg('Processo de exportação finalizado!', mtInformation, [mbOK], 0);
    end
    else
    begin
      Action := CaNone;
      Exit;
    end;
  End;

  FreeAndNil(oMmoLog);
end;

procedure TfrmExportarImagensProdutos.FormCreate(Sender: TObject);
begin
  inherited;

  oMmoLog := TMemo.Create(Self);
  oMmoLog.Parent := Self;
  oMmoLog.Visible := False;
end;

procedure TfrmExportarImagensProdutos.pExportarImagens(strCodIte: string);
var
  LFileName: string;
  qryImagens: TUniQuery;
begin
  qryImagens := fCriaQuery;
  try
    qryImagens.SQL.Add('SELECT ITE_IMGB64 FROM ITEIMG WHERE ITE_CODITE = :ITE_CODITE');
    qryImagens.ParamByName('ITE_CODITE').AsString := strCodIte;
    qryImagens.Open;

    qryImagens.First;
    while not qryImagens.Eof do
    begin
      if qryImagens.RecordCount = 1 then
        LFileName := strCodIte
      else
        LFileName := strCodIte + '_' + qryImagens.RecNo.ToString();

      LFileName := edtCaminhoExportacao.Text + '\' + LFileName;

      try
        if not qryImagens.FieldByName('ITE_IMGB64').AsString.IsEmpty then
          pSalvarImagem(qryImagens.FieldByName('ITE_IMGB64').AsString,
            LFileName);
      except
        on e: Exception do
        begin
          oMmoLog.Lines.Add('Erro ao exportar produto "' + strCodIte + '": ' +
            e.Message);
        end;
      end;

      qryImagens.Next;
    end;
  finally
    qryImagens.Free;
  end;
end;

procedure TfrmExportarImagensProdutos.pSalvarImagem(ABase64, AFile: string);
var
  objPicture: TPicture;
begin
  objPicture := TPicture.Create;
  try
    pImagemFromBase64(ABase64, objPicture);

    if objPicture.Graphic is TPngImage then
      AFile := AFile + '.png'
    else
      AFile := AFile + '.jpg';

    objPicture.SaveToFile(AFile);
  finally
    FreeAndNil(objPicture);
  end;
end;

procedure TfrmExportarImagensProdutos.spbAbrirSelecaoCaminhoClick(Sender: TObject);
var
  oFileDialog: TFileOpenDialog;
begin
  oFileDialog := TFileOpenDialog.Create(Self);
  oFileDialog.Options := [fdoPickFolders, fdoPathMustExist, fdoForceFileSystem];

  If oFileDialog.Execute Then
    edtCaminhoExportacao.Text := oFileDialog.FileName;
end;

end.
