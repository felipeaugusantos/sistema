unit untImagens;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxImage,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, Vcl.StdCtrls,
  Vcl.ExtCtrls, cxGridCustomView, cxGridCitel, cxClasses, cxGridLevel, cxGrid,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  BitBtnLockedIncrem, cxGridCustomLayoutView, cxGridCardView, cxCheckBox,
  cxGridDBCardView, untZClient, MemDS, DBAccess, Uni, Datasnap.DBClient,
  UniClientDataSet, Vcl.DBCtrls, cxContainer, cxDBEdit, dxLayoutContainer,
  cxGridViewLayoutContainer, cxGridLayoutView, cxGridDBLayoutView, cxRadioGroup,
  cxLabel, untFuncoesImagem, cxButtonEdit, System.Actions, Vcl.ActnList, untTypesSistema,
  Vcl.Grids, Vcl.DBGrids, JPEG, dxGDIPlusClasses, Vcl.Graphics, PNGImage,
  cxDataControllerConditionalFormattingRulesManagerDialog, untConstantes, idHTTP,
  StrUtils;

type
  TTabelaImagem = (tiProduto, tiLinhaGrupo, tiCliente, tiDiverso, tiEmpresa, tiConsertoEquip, tiGrupoProduto);
  TDirecao = (dirEsquerda, dirDireita);

  TfrmImagens = class(TfrmPai)
    cxgImagensLVL: TcxGridLevel;
    cxgImagens: TcxGridCitel;
    dtsImagens: TDataSource;
    cxStyleRepository1: TcxStyleRepository;
    cxgImagensDBLGroup_Root: TdxLayoutGroup;
    cxgImagensDBL: TcxGridDBLayoutView;
    cxgImagensDBLLayoutItem1: TcxGridLayoutItem;
    cxgImagensDBLIMAGEM: TcxGridDBLayoutViewItem;
    cxgImagensDBLLayoutItem2: TcxGridLayoutItem;
    cxgImagensDBLPRINCI: TcxGridDBLayoutViewItem;
    cxsGroupLayoutView: TcxStyle;
    cxsCaptionBold: TcxStyle;
    cxgImagensDBLLayoutItem3: TcxGridLayoutItem;
    cxgImagensDBLCAPPRI: TcxGridDBLayoutViewItem;
    cxgImagensDBLGroup1: TdxLayoutAutoCreatedGroup;
    cxgImagensDBLLayoutItem4: TcxGridLayoutItem;
    cxgImagensDBLEXCLUIR: TcxGridDBLayoutViewItem;
    cxgImagensDBLLayoutItem5: TcxGridLayoutItem;
    cxgImagensDBLINDICE: TcxGridDBLayoutViewItem;
    pnlLegenda: TPanel;
    lblDeletar: TLabel;
    Label1: TLabel;
    btnConfirmar: TBitBtnLocked;
    btnIncluir: TBitBtnLocked;
    btnEnviaWpp: TBitBtnLocked;

    procedure FormShow(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);

    procedure cxgImagensDBLEXCLUIRPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);

    procedure cxgImagensDBLPRINCIPropertiesEditValueChanged(
      Sender: TObject);

    procedure cxgImagensDBLKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

    procedure cxgImagensDBLFocusedRecordChanged(
      Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);

    procedure cxgImagensDBLEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);

    procedure FormCreate(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure cxgImagensDBLCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure btnEnviaWppClick(Sender: TObject);

  private
    qryImagens    : TUniQuery;
    cdsImagens    : TcdsImagens;
    strImagensDel : String;
    strTabela     : String;
    strCampoFK    : String;
    strPrefixo    : String;

    strCaminhoArquivoOrigem : String;

    procedure pZoom;

    procedure pCarregaImagens;
    function fVerificaPrincipal: Boolean;
    procedure pImportaImagensExecutar;
    procedure pSetTabela;
    procedure pImportarImagemArquivoExecutar;
    procedure pDeletaImagem;
    procedure pAdicionaImagemGS1CNP;

    function fImagemTemTamanhoIdeal(PathImagem: String): Boolean;

    function fValidaExclusaoConsertoEquip: Boolean;

    { Private declarations }
  public
    strCodigo    : String;
    enuTabela    : TTabelaImagem;
    blnConsulta  : Boolean;
    strImagemGS1CNP: String;
    strCodCli: String;
    blnExibeBotaoEnviaWhatsapp: Boolean;
    class procedure pAbrirImagens(enuTabela : TTabelaImagem; strCodigo: String; blnConsulta : Boolean = False; strImagemGS1CNP: String = ''; strCodCli: String = ''; blnEnviaWhatsapp: Boolean = False); static;
    { Public declarations }
  end;

var
  frmImagens: TfrmImagens;

implementation

{$R *.dfm}

uses untImagemBase64, untFuncoesSimples, untGravando, untCadProFoto, untILiberacao,
  untLiberacaoFactory, untFuncoes;

function TfrmImagens.fValidaExclusaoConsertoEquip: Boolean;
var
  objLiberacao: ILiberacao;
begin
  Result := True;

  if (enuTabela <> tiConsertoEquip) then
    Exit;

  objLiberacao := TLiberacaoFactory.fGetLiberacao;

  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('Deletar foto do equipamento');
  objLiberacao.objMsgLibera.pAddTexto('Nº O.S: ' + fCampoTabela('CONCAT(EQU_NUMOSE, "-", EQU_CODEMP)', 'EQUGER', ['AUTOINCREM'], [strCodigo]));

  objLiberacao.strDirAce := 'OSDFOT';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strMsgSen := 'Permitir deletar fotos do equipamento';

  Result := objLiberacao.fLibera;
end;

function TfrmImagens.fVerificaPrincipal : Boolean;
begin
  Result := cdsImagens.isEmpty;
  if not Result then
  begin
    try
      cdsImagens.DisableControls;
      cdsImagens.First;

      while not cdsImagens.Eof do
      begin
        if cdsImagens.FieldByName('PRINCI').AsString = 'S' then
        begin
          Result := True;
          Break;
        end;
        cdsImagens.Next;
      end;

    finally
      cdsImagens.First;
      cdsImagens.EnableControls;
    end;
  end;
end;

procedure TfrmImagens.btnConfirmarClick(Sender: TObject);
var
  qryAux         : TUniQuery;
  strPath        : String;
  strSQL         : String;
  qryIntegridade : TUniQuery;
  blnCriouPasta  : boolean;
begin
  inherited;
  if blnConsulta then
    exit;

  blnCriouPasta := True;
  if not fVerificaPrincipal then
  begin
    pMensagemOk('É necessário informar a imagem principal!');
    Exit;
  end;

  strPath := fCfgSis('PATIMG', varString);

  If (enuTabela = tiCliente) Then
  Begin
    If Not fEmptyStr(strPath) Then
    Begin
      strPath := IncludeTrailingPathDelimiter(strPath);

      If Not TryDirectoryExists(strPath) Then
      Begin
        If strPath.Contains(getCurrentDir) Then
          blnCriouPasta := CreateDir(strPath);
      End;

      strPath := strPath + 'Clientes';
      strPath := IncludeTrailingPathDelimiter(strPath);

      If blnCriouPasta Then
        If Not TryDirectoryExists(strPath) Then
          blnCriouPasta := CreateDir(strPath);

      If Not blnCriouPasta Then
      Begin
        fMensagem('', 'O sistema não pode criar uma pasta ["Clientes"] para receber as imagens dos clientes.' +#13+
                      'Verifique sua autoridade de acesso no sistema operacional ou informe o caminho na configuração do sistema ["PATIMG"].', ['&Ok']);
        Exit;
      End;

    End
    Else
      strPath := '';
  End;

  qryAux    := fCriaQuery;
  qryIntegridade := fCriaQuery;
  try
    cdsImagens.DisableControls;

    fStartTransaction;
    try
      if not fEmptyStr(strImagensDel) then
      begin
        qryAux.Close;
        qryAux.SQL.Text := 'SELECT * FROM '+strTabela+' WHERE AUTOINCREM IN ('+strImagensDel+')';
        qryAux.Open;

        qryAux.First;
        while not qryAux.Eof do
        begin
          strSQL := fVerificaIntegridade(Self.Name, strTabela, qryAux, False);

          qryAux.Delete;
          If Not fEmptyStr(strSQL) then
          begin
            qryIntegridade.SQL.Text := strSQL;

            qryIntegridade.ExecSQL;
            qryIntegridade.Close;
          end;
        End;

      end;

      cdsImagens.First;

      if not cdsImagens.isEmpty then
      begin
        qryAux.Close;
        qryAux.SQL.Clear;

        qryAux.SQL.Add('SELECT * FROM '+strTabela+' WHERE '+strCampoFK+' = :CODIGO');

        qryAux.ParamByName('CODIGO').AsString := strCodigo;
        qryAux.Open;

        while not cdsImagens.Eof do
        begin
          If fEmptyStr(cdsImagens.FieldByName('AUTINC').AsString) then
          begin
            qryAux.Append;
            qryAux.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem(strTabela, VS_strCodEmp);
            qryAux.FieldByName(strCampoFK).AsString   := strCodigo;
            qryAux.FieldByName(strPrefixo + 'PRINCI').AsString := cdsImagens.FieldByName('PRINCI').AsString;
            qryAux.FieldByName(strPrefixo + 'IMGB64').AsString := cdsImagens.FieldByName('IMGB64').AsString;
            If (strPrefixo = 'ITE_') Then
              qryAux.FieldByName('ITE_IMGURL').AsString := cdsImagens.FieldByName('IMGURL').AsString;
            qryAux.Post;
          end
          else if qryAux.Locate('AUTOINCREM', cdsImagens.FieldByName('AUTINC').AsString, []) and (cdsImagens.FieldByName('PRINCI').AsString <> qryAux.FieldByName(strPrefixo + 'PRINCI').AsString) then
          begin
            qryAux.Edit;
            qryAux.FieldByName(strPrefixo + 'PRINCI').AsString := cdsImagens.FieldByName('PRINCI').AsString;
            qryAux.Post;
          end;

          // se for principal subistitui na pasta
          if ((enuTabela = tiProduto) or (enuTabela = tiCliente)) and (cdsImagens.FieldByName('PRINCI').AsString = 'S') then
          try
            TBlobField(cdsImagens.FieldByName('IMAGEM')).SaveToFile(IncludeTrailingPathDelimiter(strPath) + strCodigo + '.jpg');
          except
            fMensagem('', 'O sistema não pode criar uma pasta ' + IIF((enuTabela = tiProduto), '["Imagens"]', '["Clientes"]') + ' para receber as imagens dos '+ IIF((enuTabela = tiProduto), 'produtos.', 'clientes.') +#13+
                          'Verifique sua autoridade de acesso no sistema operacional ou informe o caminho na configuração do sistema ["PATIMG"].', ['&Ok']);
            fRollBack;
          end;
          cdsImagens.Next;
        end;
      end
      else
      begin
        if (enuTabela = tiProduto) then
          fDeletaImagemArquivo(strCodigo);
      end;

      fCommit;
      close;

    except
      On E:Exception do
      begin
        pMensagensErro(E.Message, '[btnConfirmarClick]');
        fRollBack;
      end;
    end;
  finally
    FreeAndNil(qryAux);
    FreeAndNil(qryIntegridade);
    cdsImagens.EnableControls;
  end;

end;

procedure TfrmImagens.pImportarImagemArquivoExecutar;
var
  strBase64 : String;
  blnPrincipal : boolean;
begin
  try
    try
      strBase64 := fBase64FromFile(strCaminhoArquivoOrigem);
    except
      On E: Exception Do
      Begin
        If Not E.Message.Contains('Arquivo Inválido') Then
          Raise
        Else
          pMensagemOk('Não é possível recuperar a imagem deste produto ( ' + strCodigo + ' ), ela parece estar danificada. ' +
                      'Acesse neste cadastro de produtos, a opção para upload das imagens, e substitua por imagens válidas e permitidas. ' + sLineBreak +
                      'Caso o erro persista, procure o departamento de TI.');
      End;
    end;

    if Trim(strBase64) <> '' then
    begin
      If Not fImagemTemTamanhoIdeal(strCaminhoArquivoOrigem) Then
        Exit;

      blnPrincipal := cdsImagens.IsEmpty;

      cdsImagens.Append;
      cdsImagens.FieldByName('AUTINC').AsString := '';
      cdsImagens.FieldByName('PRINCI').AsString := IIF(blnPrincipal, 'S', 'N');
      cdsImagens.FieldByName('CAPPRI').AsString := 'Principal';
      cdsImagens.FieldByName('IMGB64').AsString := strBase64;
      cdsImagens.FieldByName('IMGURL').AsString := strCaminhoArquivoOrigem;
      TBlobField(cdsImagens.FieldByName('IMAGEM')).LoadFromFile(strCaminhoArquivoOrigem);
      cdsImagens.Post;
    end;
  except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmImagens.btnIncluirClick]');
    End;
  end;

end;


procedure TfrmImagens.btnEnviaWppClick(Sender: TObject);
var
  recImagem: TArray<TRecArquivosGatilhos>;
begin
  inherited;

  if cdsImagens.IsEmpty then
    Exit;

  if fEmptyStr(cdsImagens.FieldByName('IMGB64').AsString) then
    Exit;

  SetLength(recImagem, 1);
  recImagem[0] := TRecArquivosGatilhos.Create('IMAGEM PRODUTO_'+strCodigo+'-'+Copy(fRetNomProduto(strCodigo),1,10),
                                               cdsImagens.FieldByName('IMGB64').AsString,
                                               EmptyStr,
                                               tpaImagem);

  if fDisparaWhatsappAutomatico('',
                                'PR',
                                '',
                                '',
                                'FP',
                                '',
                                '',
                                '',
                                False,
                                '',
                                nil,
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                False,
                                False,
                                nil,
                                '',
                                '',
                                recImagem,
                                strCodigo) then
    fMensagem('', 'Whatsapp enviado com sucesso!', ['&Ok'])
  else
    fMensagem('', 'Whatsapp não enviado!', ['&Ok']);
end;

procedure TfrmImagens.btnIncluirClick(Sender: TObject);
begin
  inherited;
  if blnConsulta then
    exit;

  strCaminhoArquivoOrigem := fSelecionaArquivo('', 'Imagens|*.jpeg;*.jpg;*.png', [ofFileMustExist]);
  If Not fEmptyStr(strCaminhoArquivoOrigem) Then
    TfrmGravando.fExecutarModalA(pImportarImagemArquivoExecutar, 'Aguarde, importando imagem...', '');
end;

procedure TfrmImagens.pZoom;
begin
  inherited;
  if (not cdsImagens.IsEmpty) and (cdsImagens.fieldByName('IMGB64').AsString <> '') then
    TfrmCadProFoto.pAmpliaFoto(cdsImagens.fieldByName('IMGB64').asString, cdsImagens, strCodigo, strCodcli, btnEnviaWpp.Visible);
end;

{procedure TfrmImagens.pMovimentaGrid(enuDirecao : TDirecao);
var
  intPosicaoFinal : Integer;
  intPosicaoNova  : Integer;
  intQtdImagens   : Integer;
begin
  intQtDimagens := cxgImagensDBL.OptionsView.MaxColumnCount * cxgImagensDBL.OptionsView.MaxRowCount;

  case enuDirecao of
  dirEsquerda :
    begin
      for intPosicaoFinal := cdsImagens.RecNo -1 downto 1 do
      begin
        if  (intPosicaoFinal mod intQtDimagens = 0) then
          break;
      end;

      intPosicaoNova  := intPosicaoFinal - intQtDimagens;

      if intPosicaoNova >= 1 then
        cdsImagens.RecNo := intPosicaoNova
      else
        cdsImagens.RecNo := 1;
    end;
  dirDireita :
    begin
      for intPosicaoFinal := cdsImagens.RecNo + 1 to cdsImagens.RecordCount do
      begin
        if  (intPosicaoFinal mod intQtDimagens = 0) then
          break;
      end;

      intPosicaoNova  := intPosicaoFinal + intQtDimagens;

      if intPosicaoNova <= cdsImagens.RecordCount then
        cdsImagens.RecNo := intPosicaoNova
      else
        cdsImagens.RecNo := cdsImagens.RecordCount;

    end;
  end;


end;}

procedure TfrmImagens.cxgImagensDBLCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
var
  AColumn: TcxGridDBLayoutViewItem;
begin
  inherited;
  AColumn := ACellViewInfo.Item as TcxGridDBLayoutViewItem;

  if TcxGridDBLayoutViewItem(AColumn) = cxgImagensDBLIMAGEM then
    pZoom;
end;
procedure TfrmImagens.cxgImagensDBLEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;
  cxgImagensDBLKeyDown(Sender, Key, Shift);

end;

procedure TfrmImagens.cxgImagensDBLEXCLUIRPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  pDeletaImagem;
end;

procedure TfrmImagens.pDeletaImagem;
Begin

  if blnConsulta then
    exit;

  if (not cdsImagens.isEmpty) and (fMensagem('','Deseja realmente excluir a imagem?', ['','']) = 1) then
  begin
    if not fEmptyStr(cdsImagens.FieldByName('AUTINC').ASString) then
    begin
      if (not fValidaExclusaoConsertoEquip) then
        Exit;

      //monta uma string com o autoincrem de cada imagem deletada para excluir no banco de dados posteriormente
      if fEmptyStr(strImagensDel) then
        strImagensDel := QuotedStr(cdsImagens.FieldByName('AUTINC').AsString)
      else
        strImagensDel := strImagensDel + ', ' + QuotedStr(cdsImagens.FieldByName('AUTINC').AsString);
    end;

    cdsImagens.Delete;

  end;

End;


procedure TfrmImagens.cxgImagensDBLFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  inherited;
  if not cxgImagensDBLPRINCI.Focused then
    cxgImagensDBLPRINCI.Focused := True
end;

procedure TfrmImagens.cxgImagensDBLKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  case Key of
    VK_DOWN, VK_UP:
      if cxgImagensDBL.Controller.FocusedItem = cxgImagensDBLPRINCI then
        cxgImagensDBL.Controller.FocusedItem := nil;
    VK_ESCAPE:
      pEscapePressed;
    VK_F3 : pZoom;
  end;
end;

procedure TfrmImagens.cxgImagensDBLPRINCIPropertiesEditValueChanged(
  Sender: TObject);
var
  strIndex : String;
begin
  cdsImagens.DisableControls;
  strIndex := cdsImagens.FieldByName('INDICE').AsString;
  try
    cdsImagens.First;
    while not cdsImagens.Eof do begin
      if (cdsImagens.FieldByName('INDICE').AsString <> strIndex) and (cdsImagens.FieldByName('PRINCI').AsString = 'S') then
      begin
        cdsImagens.Edit;
        cdsImagens.FieldByName('PRINCI').AsString := 'N';
        cdsImagens.Post;
      end
      else if (cdsImagens.FieldByName('INDICE').AsString = strIndex) and (cdsImagens.FieldByName('PRINCI').AsString <> 'S') then
      begin
        cdsImagens.Edit;
        cdsImagens.FieldByName('PRINCI').AsString := 'S';
        cdsImagens.Post;
      end;

      cdsImagens.Next;
    end;
  finally
    cdsImagens.Locate('INDICE', strIndex, []);
    cdsImagens.EnableControls;
  end;
end;

function TfrmImagens.fImagemTemTamanhoIdeal(PathImagem: String): Boolean;
Var
  JPG : TJPEGImage;
  PNG : TPNGImage;
  imgHeight: Integer;
begin
  Result := True;

  If enuTabela = tiProduto Then
  Begin
    {*************************************************************************}
    {* Bloquear tamanho mínimo da imagem somente se utilizar AUTOATENDIMENTO *}
    {*************************************************************************}
    If (fArqIni(0, 'GERAL', 'AUTOATENDIMENTO', '') = 'S') Then
    Begin
      If ContainsStr(strCaminhoArquivoOrigem, '.png') Then
      Begin
        PNG := TPngImage.Create;
        PNG.LoadFromFile(strCaminhoArquivoOrigem);
        imgHeight := PNG.Height;
      End
      Else
      Begin
        JPG := TJpegImage.Create;
        JPG.LoadFromFile(strCaminhoArquivoOrigem);
        imgHeight := JPG.Height;
      End;

      if (imgHeight < 500) Then
      Begin
        pMensagemOk('A imagem deve ter no mínimo 500 px de altura para ser importada' + #13 + #13 +
                    'Tamanho da imagem selecionada: ' + imgHeight.ToString() + ' px');
        Result := False;
      End;
    End;
  End;
end;

procedure TfrmImagens.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  fLock_Unlock(strTabela+'_' + strCodigo, False, False, False, '', False);
end;

procedure TfrmImagens.FormCreate(Sender: TObject);
begin
  inherited;
  strImagensDel := '';
  strCodigo     := '';
  strTabela     := '';
  strCampoFK    := '';
  strPrefixo    := '';
  blnConsulta   := False;
  strCodCli     := '';
  blnExibeBotaoEnviaWhatsapp := False;
end;

procedure TfrmImagens.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key of
    VK_F1:
      btnIncluir.Click;
    VK_DELETE: Begin
                 Self.OnKeyDown := Nil;
                 pDeletaImagem;
                 Self.OnKeyDown := FormKeyDown;
               End;
    VK_F10:
      btnConfirmar.Click;
    VK_F6:
      btnEnviaWpp.Click;
  End;

end;

procedure TfrmImagens.FormShow(Sender: TObject);
begin
  inherited;

  pSetTabela;

  if blnConsulta then
  begin
    cxgImagensDBLEXCLUIR.Visible := False;
    cxgImagensDBLCAPPRI.Visible  := False;
    cxgImagensDBLPRINCI.Visible  := False;
    btnConfirmar.Visible             := False;
    btnIncluir.Visible               := False;
    lblDeletar.Visible               := False;
  end;

  btnEnviaWpp.Visible := (blnExibeBotaoEnviaWhatsapp) and (fCfgSis('UTIWPP', varBoolean));
end;

procedure TfrmImagens.pImportaImagensExecutar;
begin
  pImportaImagens(strCodigo);
end;


procedure TfrmImagens.pSetTabela;
begin
  case enuTabela of
    tiProduto      : begin
                       Self.Caption := 'Imagens do Produto ' + strCodigo + ' - ' + fRetNomProduto(strCodigo);
                       strTabela    := 'ITEIMG';
                       strCampoFK   := 'ITE_CODITE';
                       strPrefixo   := 'ITE_';
                     end;
    tiLinhaGrupo   : begin
                       Self.Caption := 'Imagens da Linha / Grupo ' + strCodigo + ' - ' + fRetNomeLinhaGrupo(strCodigo);
                       strTabela    := 'GRUIMG';
                       strCampoFK   := 'GRU_CODGRU';
                       strPrefixo   := 'GRU_';
                     end;
    tiCliente      : begin
                       Self.Caption := 'Imagens do Cliente ' + strCodigo + ' - ' + fCampoTabela('CLI_NOMCLI','CADCLI',['CLI_CODCLI'],[strCodigo]);
                       strTabela    := 'CLIIMG';
                       strCampoFK   := 'CLI_CODCLI';
                       strPrefixo   := 'CLI_';
                     end;
    tiDiverso      : begin
                       Self.Caption := 'Imagens do Diverso ' + strCodigo + ' - ' + fCampoTabela('DIV_NOMDIV','CADDIV',['DIV_CODDIV'],[strCodigo]);
                       strTabela    := 'DIVIMG';
                       strCampoFK   := 'DIV_CODDIV';
                       strPrefixo   := 'DIV_';
                     end;
    tiEmpresa      : begin
                       Self.Caption := 'Imagens da Empresa ' + strCodigo + ' - ' + fCampoTabela('EMP_NOMEMP','CADEMP',['EMP_CODEMP'],[strCodigo]);
                       strTabela    := 'EMPIMG';
                       strCampoFK   := 'EMP_CODEMP';
                       strPrefixo   := 'EMP_';
                     end;
    tiConsertoEquip: begin
                       Self.Caption := 'Imagens do Equipamento da O.S ' + fCampoTabela('CONCAT(EQU_NUMOSE, "-", EQU_CODEMP)', 'EQUGER', ['AUTOINCREM'], [strCodigo]);
                       strTabela    := 'EQUIMG';
                       strCampoFK   := 'EQU_SEQEQU';
                       strPrefixo   := 'EQU_';
                     end;
    tiGrupoProduto:  begin
                       Self.Caption := 'Imagens do Grupo ' + strCodigo + ' - ' + fRetNomeGrupoProduto(strCodigo);
                       strTabela    := 'PRDIMG';
                       strCampoFK   := 'PRD_CODGRU';
                       strPrefixo   := 'PRD_';
                     end;
  end;
end;

procedure TfrmImagens.pCarregaImagens;
var
  objStream: TBytesStream;
begin
  qryImagens := fCriaQuery(Self);
  dtsImagens.DataSet := cdsImagens;

  qryImagens.SQL.Add('SELECT                               ');
  qryImagens.SQL.Add('  AUTOINCREM,                        ');
  qryImagens.SQL.Add('  '+ strPrefixo +'IMGB64 AS IMGB64, ');
  qryImagens.SQL.Add('  '+ strPrefixo +'PRINCI AS PRINCI  ');

  If (strPrefixo = 'ITE_') Then
    qryImagens.SQL.Add(',  '+ strPrefixo +'IMGURL AS IMGURL  ');

  qryImagens.SQL.Add('FROM                        ');
  qryImagens.SQL.Add('  '+strTabela+'             ');
  qryImagens.SQL.Add('WHERE                       ');
  qryImagens.SQL.Add('  '+strCampoFK+' = :CODIGO  ');
  qryImagens.SQL.Add('ORDER BY                    ');
  qryImagens.SQL.Add('  PRINCI DESC,              ');
  qryImagens.SQL.Add('  AUTOINCREM ASC            ');

  qryImagens.ParamByName('CODIGO').AsString := strCodigo;
  qryImagens.Open;

  // se não houver nenhuma imagem do item, verifica a pasta para importá-lo.
  if (enuTabela = tiProduto) and qryImagens.isEmpty then
  begin
    TfrmGravando.fExecutarModalA(pImportaImagensExecutar, 'Aguarde, importando imagens do produto...', '');
    qryImagens.Refresh;
  end;

  qryImagens.first;

  cdsImagens := TcdsImagens.Create(Self);
  dtsImagens.DataSet := cdsImagens;

  while not qryImagens.Eof do
  begin
    objStream := TBytesStream.Create;
    if fStreamFromBase64(qryImagens.FieldByName('IMGB64').AsString, objStream) then
    begin
      cdsImagens.Append;
      cdsImagens.FieldByName('AUTINC').AsString := qryImagens.FieldByName('AUTOINCREM').AsString;
      cdsImagens.FieldByName('PRINCI').AsString := qryImagens.FieldByName('PRINCI').AsString;
      cdsImagens.FieldByName('CAPPRI').AsString := 'Principal';
      cdsImagens.FieldByName('IMGB64').AsString := qryImagens.FieldByName('IMGB64').AsString;

      if Assigned(qryImagens.FindField('IMGURL')) then
        cdsImagens.FieldByName('IMGURL').AsString := qryImagens.FieldByName('IMGURL').AsString;

      TBlobField(cdsImagens.FieldByName('IMAGEM')).LoadFromStream(objStream);
      cdsImagens.Post;
    end;
    if Assigned(objStream) then
      objStream.Free;
    qryImagens.next;
  end;

  cxgImagensDBL.Controller.GoToFirst;
end;

class procedure TfrmImagens.pAbrirImagens(enuTabela : TTabelaImagem; strCodigo : String; blnConsulta : Boolean = False; strImagemGS1CNP: String = ''; strCodCli: String = ''; blnEnviaWhatsapp: Boolean = False);
  Var
    LfrmImagens: TfrmImagens;
    strLock: String;
    LfrmAbrirImagens: TfrmGravando;
Begin
  case enuTabela of
    tiProduto      : strLock := 'ITEIMG_';
    tiLinhaGrupo   : strLock := 'GRUIMG_';
    tiCliente      : strLock := 'CLIIMG_';
    tiDiverso      : strLock := 'DIVIMG_';
    tiEmpresa      : strLock := 'EMPIMG_';
    tiConsertoEquip: strLock := 'EQUIMG_';
    tiGrupoProduto : strLock := 'PRDIMG_';
  end;

  If (Not blnConsulta) and (Not fLock_Unlock(strLock + strCodigo, True, False, False, '', False)) Then
  Begin
    case enuTabela of
      tiProduto      : pMensagemOk( 'As Imagens deste produto estão sendo editadas por ' + fGetHostLock(strLock + strCodigo)  + '!');
      tiLinhaGrupo   : pMensagemOk( 'As Imagens desta Linha / Grupo estão sendo editadas por ' + fGetHostLock(strLock + strCodigo)  + '!');
      tiCliente      : pMensagemOk( 'As Imagens deste Cliente estão sendo editadas por ' + fGetHostLock(strLock + strCodigo)  + '!');
      tiDiverso      : pMensagemOk( 'As Imagens deste Diverso estão sendo editadas por ' + fGetHostLock(strLock + strCodigo)  + '!');
      tiEmpresa      : pMensagemOk( 'As Imagens desta Empresa estão sendo editadas por ' + fGetHostLock(strLock + strCodigo)  + '!');
      tiConsertoEquip: pMensagemOk( 'As Imagens deste Equipamento estão sendo editadas por ' + fGetHostLock(strLock + strCodigo)  + '!');
      tiGrupoProduto : pMensagemOk( 'As Imagens deste Grupo estão sendo editadas por ' + fGetHostLock(strLock + strCodigo)  + '!');
    end;

    Exit;
  End;

  Try
    pCriarFormularios(TfrmImagens, LfrmImagens);

    LfrmImagens.strCodigo   := strCodigo;
    LfrmImagens.strCodigo   := strCodigo;
    LfrmImagens.enuTabela   := enuTabela;
    LfrmImagens.blnConsulta := blnConsulta;
    LfrmImagens.strImagemGS1CNP := strImagemGS1CNP;
    LfrmImagens.strCodCli := strCodCli;
    LfrmImagens.blnExibeBotaoEnviaWhatsapp := blnEnviaWhatsapp;
    LfrmImagens.pSetTabela;

    pCriarFormularios(TfrmGravando, LfrmAbrirImagens);
    try
      case enuTabela of
        tiProduto      : LfrmAbrirImagens.fExecutarModalA(LfrmImagens.pCarregaImagens, 'Aguarde, carregando imagens do produto...', '');
        tiLinhaGrupo   : LfrmAbrirImagens.fExecutarModalA(LfrmImagens.pCarregaImagens, 'Aguarde, carregando imagens da linha / grupo...', '');
        tiCliente      : LfrmAbrirImagens.fExecutarModalA(LfrmImagens.pCarregaImagens, 'Aguarde, carregando imagens do cliente...', '');
        tiDiverso      : LfrmAbrirImagens.fExecutarModalA(LfrmImagens.pCarregaImagens, 'Aguarde, carregando imagens do diverso...', '');
        tiEmpresa      : LfrmAbrirImagens.fExecutarModalA(LfrmImagens.pCarregaImagens, 'Aguarde, carregando imagens da empresa...', '');
        tiConsertoEquip: LfrmAbrirImagens.fExecutarModalA(LfrmImagens.pCarregaImagens, 'Aguarde, carregando imagens do equipamento...', '');
        tiGrupoProduto : LfrmAbrirImagens.fExecutarModalA(LfrmImagens.pCarregaImagens, 'Aguarde, carregando imagens do grupo do produto...', '');
      end;
    finally
      pFreeAndNil(LfrmAbrirImagens);
    end;

    If Not fEmptyStr(strImagemGS1CNP) Then
    begin
      pCriarFormularios(TfrmGravando, LfrmAbrirImagens);
      try
        LfrmAbrirImagens.fExecutarModalA(LfrmImagens.pAdicionaImagemGS1CNP, 'Aguarde, carregando imagens do produto...', '');
      finally
        pFreeAndNil(LfrmAbrirImagens);
      end;
    end;

    If Assigned(LfrmImagens.cdsImagens) And LfrmImagens.cdsImagens.Active Then
    Begin
      if blnConsulta and (LfrmImagens.cdsImagens.RecordCount = 1) then
        LfrmImagens.pZoom
      else
        LfrmImagens.ShowModal;
    End;

  Finally
     pFreeAndNil(LfrmImagens);
  end;

end;

procedure TfrmImagens.pAdicionaImagemGS1CNP;
var
  blnPrincipal: Boolean;

  Jpeg: TJPEGImage;
  Strm: TMemoryStream;
  vIdHTTP: TIdHTTP;
begin
  Jpeg := TJPEGImage.Create;
  Strm := TMemoryStream.Create;
  vIdHTTP := TIdHTTP.Create(nil);
  try
    vIdHTTP.Get(strImagemGS1CNP, Strm);
    if (Strm.Size > 0) then
    begin
      Strm.Position := 0;
      Jpeg.LoadFromStream(Strm);
    end;

    blnPrincipal := cdsImagens.IsEmpty;

    cdsImagens.Insert;
    cdsImagens.FieldByName('AUTINC').AsString := '';
    cdsImagens.FieldByName('PRINCI').AsString := IIF(blnPrincipal, 'S', 'N');
    cdsImagens.FieldByName('CAPPRI').AsString := 'Principal';
    cdsImagens.FieldByName('IMGB64').AsString := fBase64FromJPEG(Jpeg);
    cdsImagens.FieldByName('IMGURL').AsString := strImagemGS1CNP;
    TBlobField(cdsImagens.FieldByName('IMAGEM')).LoadFromStream(Strm);
    cdsImagens.Post;
  finally
    Strm.Free;
    Jpeg.Free;
    vIdHTTP.Free;
  end;
end;

end.
