unit Autoatendimento.ConsultaPreco.View.ConsultarPreco;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.Effects, Autoatendimento.ConsultaPreco.Interfaces,
  FMX.TabControl, AVPlayer, FMX.Ani, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.Edit, System.StrUtils, FMX.ListBox,
  Autoatendimento.ConsultaPreco.Frame.DadosTecnicos,
  Autoatendimento.ConsultaPreco.Frame.ProdutosSimilares,
  Autoatendimento.ConsultaPreco.Frame.ComprarJunto,
  Autoatendimento.ConsultaPreco.View.Mensagem, System.ImageList,
  FMX.ImgList, FMX.MultiResBitmap, Autoatendimento.ConsultaPreco.Frame.Precos;

type
  TfmxConsultaPreco = class(TForm)
    layTopo: TLayout;
    recLogoEmpresa: TRectangle;
    imgVoltar: TImage;
    imgHome: TImage;
    efeSombraVoltar: TShadowEffect;
    efeSombraHome: TShadowEffect;
    tabTelas: TTabControl;
    tabCodigoBarras: TTabItem;
    recFundoAzulCodBar: TRectangle;
    recFundoImagem: TRectangle;
    recPubli: TRectangle;
    recCarregando: TRectangle;
    aniCarregando: TFloatAnimation;
    recMedia: TAVView;
    lblOrientacao: TLabel;
    efeSombraOrientacao: TShadowEffect;
    patSetaBaixo: TPath;
    efeSombraSetaBaixo: TShadowEffect;
    edtCodigoBarras: TEdit;
    timerFoco: TTimer;
    tabProduto: TTabItem;
    recFundoAzulProduto: TRectangle;
    recFundoBrancoProduto: TRectangle;
    recPubli2: TRectangle;
    recCarregando2: TRectangle;
    aniCarregando2: TFloatAnimation;
    recMedia2: TAVView;
    recDadosTecnicos: TRectangle;
    efeSombraDadosTecnicos: TShadowEffect;
    lblDadosTecnicos: TLabel;
    recProdutosSimilares: TRectangle;
    efeSombraProdutosSimilares: TShadowEffect;
    lblProdutosSimilares: TLabel;
    recComprarJunto: TRectangle;
    efeSombraComprarJunto: TShadowEffect;
    lblComprarJunto: TLabel;
    lblDescricaoProduto: TLabel;
    imgProduto: TImage;
    lblErro: TLabel;
    tabDadosTecnicos: TTabItem;
    recFundoAzulDadosTecnicos: TRectangle;
    recFundoDadosTecnicos: TRectangle;
    btnAssistirVideo: TRectangle;
    ShadowEffect1: TShadowEffect;
    lblAssistirVideo: TLabel;
    lstDadosTecnicos: TListBox;
    lstIteModelo: TListBoxItem;
    recVideo3: TAVView;
    playerDadosTecnicos: TAVPlayer;
    tabProdutosSimilares: TTabItem;
    recFundoAzul: TRectangle;
    lstProdutosSimilares: TListBox;
    lstProduto1: TListBoxItem;
    frameDadosTecnicos1: TframeDadosTecnicos;
    tabComprarJunto: TTabItem;
    recFundoAzulComprarJunto: TRectangle;
    lstComprarJunto: TListBox;
    ListBoxItem1: TListBoxItem;
    imgFundos: TImageList;
    player: TAVPlayer;
    timerAds: TTimer;
    playerProduto: TAVPlayer;
    timerAdsProduto: TTimer;
    patFecharVideo: TPath;
    btnFecharVideo: TSpeedButton;
    StyleBook1: TStyleBook;
    layPrecos: TLayout;
    fraPrecosCodBar: TframePrecos;
    frameComprarJunto1: TframeComprarJunto;
    frameProdutosSimilares1: TframeProdutosSimilares;
    recFundo: TRectangle;
    layFundoCodigoBarras: TLayout;
    layBotoes: TLayout;
    lblCarregando: TLabel;
    edtCodBar: TEdit;
    timerIdle: TTimer;
    procedure timerFocoTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tabTelasChange(Sender: TObject);
    procedure edtCodigoBarrasChange(Sender: TObject);
    procedure imgHomeClick(Sender: TObject);
    procedure edtCodigoBarrasChangeTracking(Sender: TObject);
    procedure recDadosTecnicosClick(Sender: TObject);
    procedure imgVoltarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAssistirVideoClick(Sender: TObject);
    procedure recProdutosSimilaresClick(Sender: TObject);
    procedure recComprarJuntoClick(Sender: TObject);
    procedure playerDadosTecnicosPlaybackFinished(Sender: TObject);
    procedure recVideo3Click(Sender: TObject);
    procedure recVideo3DblClick(Sender: TObject);
    procedure timerAdsTimer(Sender: TObject);
    procedure playerPlaybackFinished(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure aniCarregandoFinish(Sender: TObject);
    procedure playerStart(Sender: TObject);
    procedure timerAdsProdutoTimer(Sender: TObject);
    procedure playerProdutoPlaybackFinished(Sender: TObject);
    procedure playerProdutoStart(Sender: TObject);
    procedure aniCarregando2Finish(Sender: TObject);
    procedure btnFecharVideoClick(Sender: TObject);
    procedure timerIdleTimer(Sender: TObject);
  private
    { Private declarations }
    FConsultaPreco: IAutoatendimentoConsultaPreco;
    LProduto : IAutoatendimentoConsultaProduto;
    FArquivosAds: TStringList;

    procedure CarregarProduto(ACodigoBarras: String);
    procedure CarregarDadosTecnicos;
    procedure CarregarProdutosSimilares;
    procedure CarregarComprarJunto;

    procedure AddGrupo(AGrupo: String; AIndex: Integer);
    procedure AddAtributo(AAtributo: IAutoatendimentoConsultaAtributos; AIndex: Integer);
    procedure AddProdutoSimilar(ASimilar: IAutoatendimentoConsultaProduto; AIndex: Integer);
    procedure AddComprarJunto(AAgregado: IAutoatendimentoConsultaProduto; AIndex: Integer);

    procedure FreeComprarJunto;
    procedure FreeProdutoSimilar;
    procedure FreeDadosTecnicos;

    procedure ListarAds(Var Lista: TStringList);
    procedure CarregaAd(AArquivo: String);
    procedure StopAds;
    procedure PlayAds;

    procedure StopAdsProduto;
    procedure PlayAdsProduto;

    procedure AjustaAlturaDaLista(AQtdeItens: Integer;
                                  AItem : TListBoxItem;
                                  AFrame: TframeComprarJunto);

    procedure MensagemOk(ATitulo, AMensagem: String);
    procedure MostrarBotoesTelaProduto;

    Function FormatarTexto(ATexto: String): String;
    Function LowerCaseComAcento(ATexto: String): String;
    Function ProdutoTemVideoCadastrado: Boolean;

    procedure DisparaContadorInatividade;

  public
    { Public declarations }
    MostrarPrecos : Boolean;
    procedure OnMensagemAoUsuario(AMsg: String);
    procedure OnMensagemDeErro(AMsg: String);
    procedure OnMensagemAguarde(AMsg: String);
  published
    property ConsultaPreco: IAutoatendimentoConsultaPreco Read FConsultaPreco write FConsultaPreco;
  end;

var
  fmxConsultaPreco: TfmxConsultaPreco;

Const
  ExtensaoImagens = 'jpg_jpeg_bmp_png_';
  ExtensaoVideos  = 'avi_mp4_wmv_mov_';

implementation

Uses IOUtils;

{$R *.fmx}

{ TfmxConsultaPreco }

procedure TfmxConsultaPreco.AddAtributo(AAtributo: IAutoatendimentoConsultaAtributos; AIndex: Integer);
Var
  LFrame   : TframeDadosTecnicos;
  LItem    : TListBoxItem;
begin
  LItem         := TListBoxItem.Create(Self);
  LItem.Margins.Right := 30;
  LFrame        := TframeDadosTecnicos.Create(Self);
  LFrame.Name   := 'FrameAtributo' + AIndex.ToString();
  LFrame.Parent := LItem;
  LFrame.Align  := TAlignLayout.Contents;

  LFrame.recGrupo.Visible    := False;
  LFrame.recAtributo.Visible := True;
  LFrame.lblDescricao.Text   := AAtributo.Descricao + ': ';
  LFrame.lblValor.Text       := Trim(AAtributo.Valor);

  if (AAtributo.Valor.Length > 45) Then
    LItem.Height := ((AAtributo.Valor.Length Div 45) + 1) * 30
  Else
    LItem.Height := 40;

  LItem.Parent      := lstDadosTecnicos;
end;

procedure TfmxConsultaPreco.AddComprarJunto(
  AAgregado: IAutoatendimentoConsultaProduto; AIndex: Integer);
Var
  LFrame   : TframeComprarJunto;
  LItem    : TListBoxItem;
  Item     : TCustomBitmapItem;
  Size     : TSize;
begin
  LItem         := TListBoxItem.Create(Self);
  LItem.Height  := 523;
  LItem.Width   := 510;

  LFrame        := TframeComprarJunto.Create(Self);
  LFrame.Name   := 'FrameCompraJunto' + AIndex.ToString();
  LFrame.Parent := LItem;
  LFrame.Align  := TAlignLayout.Contents;

  AjustaAlturaDaLista(LProduto.ProdutosAgregados.Count, LItem, LFrame);

  LFrame.lblDescricao.Text := FormatarTexto(AAgregado.Descricao);
  LFrame.fraPrecos.lblPrecoTabela.Text := 'R$ ' + FormatFloat('#,##0.00', AAgregado.PrecoTabela);
  LFrame.fraPrecos.lblPrecoVenda.Text  := 'R$ ' + FormatFloat('#,##0.00', AAgregado.PrecoVenda) + ' ' + LowerCase(AAgregado.UnidadeVenda);
  LFrame.fraPrecos.lblCondicao.Text    := AAgregado.TextoAdicionalPreco;
  LFrame.fraPrecos.lblDesconto.Text    := Round((100 - (AAgregado.PrecoVenda * 100) / AAgregado.PrecoTabela)).ToString() + '%';
  LFrame.fraPrecos.lblDesconto.Margins.Right := 5;
  LFrame.fraPrecos.recDesconto.Margins.Left  := 0;
  LFrame.fraPrecos.LEmPromocao         := AAgregado.EmPromocao;
  LFrame.layRodape.Visible             := MostrarPrecos;
  LFrame.fraPrecos.AjustarLayout;

  If Not AAgregado.PathImagemPrincipal.IsEmpty Then
    LFrame.imgProduto.Bitmap.LoadFromFile(AAgregado.PathImagemPrincipal)
  Else
  Begin
    imgFundos.BitmapItemByName('Indisponivel', Item, Size);
    LFrame.imgProduto.Bitmap := Item.MultiResBitmap.Bitmaps[1.0];
  End;

  LItem.Parent  := lstComprarJunto;
end;

procedure TfmxConsultaPreco.AddGrupo(AGrupo: String; AIndex: Integer);
Var
  LFrame   : TframeDadosTecnicos;
  LItem    : TListBoxItem;
begin
  LItem         := TListBoxItem.Create(Self);
  LItem.Height  := 100;
  LItem.Margins.Right := 30;
  LFrame        := TframeDadosTecnicos.Create(Self);
  LFrame.Name   := 'FrameGrupo' + AIndex.ToString();
  LFrame.Parent := LItem;
  LFrame.Align  := TAlignLayout.Contents;

  LFrame.recGrupo.Visible    := True;
  LFrame.recAtributo.Visible := False;
  LFrame.lblGrupo.Text       := AGrupo;

  LItem.Parent      := lstDadosTecnicos;
end;

procedure TfmxConsultaPreco.AddProdutoSimilar(ASimilar: IAutoatendimentoConsultaProduto; AIndex: Integer);
Var
  LFrame   : TframeProdutosSimilares;
  LItem    : TListBoxItem;
  Item     : TCustomBitmapItem;
  Size     : TSize;
begin
  LItem         := TListBoxItem.Create(Self);
  LItem.Height  := 522;
  LFrame        := TframeProdutosSimilares.Create(Self);
  LFrame.Name   := 'FrameSimilar' + AIndex.ToString();
  LFrame.Parent := LItem;
  LFrame.Align  := TAlignLayout.Contents;

  LItem.Margins.Top    := 15;
  LItem.Margins.Bottom := 15;

  LFrame.lblDescricao.Text := FormatarTexto(ASimilar.Descricao);
  LFrame.lblDetalhes.Text  := AnsiReplaceText(ASimilar.DetalhesUtilizacao, '<<csq>>', #13);
  LFrame.fraPrecos.lblPrecoTabela.Text   := 'R$ ' + FormatFloat('#,##0.00', ASimilar.PrecoTabela);
  LFrame.fraPrecos.lblPrecoVenda.Text    := 'R$ ' + FormatFloat('#,##0.00', ASimilar.PrecoVenda) + ' ' + LowerCase(ASimilar.UnidadeVenda);
  LFrame.fraPrecos.lblCondicao.Text      := ASimilar.TextoAdicionalPreco;
  LFrame.fraPrecos.lblDesconto.Text      := Round((100 - (ASimilar.PrecoVenda * 100) / ASimilar.PrecoTabela)).ToString() + '%';
  LFrame.fraPrecos.lblDesconto.Font.Size        := 12;
  LFrame.fraPrecos.recDesconto.Margins.Left     := 0;
  LFrame.fraPrecos.lblPrecoTabela.Margins.Right := 5;
  LFrame.fraPrecos.LEmPromocao           := ASimilar.EmPromocao;
  LFrame.layRodape.Visible               := MostrarPrecos;

  If Not ASimilar.PathImagemPrincipal.IsEmpty Then
    LFrame.imgProduto.Bitmap.LoadFromFile(ASimilar.PathImagemPrincipal)
  Else
  Begin
    imgFundos.BitmapItemByName('Indisponivel', Item, Size);
    LFrame.imgProduto.Bitmap := Item.MultiResBitmap.Bitmaps[1.0];
  End;

  LItem.Parent      := lstProdutosSimilares;
end;

procedure TfmxConsultaPreco.AjustaAlturaDaLista(AQtdeItens: Integer;
                                  AItem : TListBoxItem;
                                  AFrame: TframeComprarJunto);
begin
  If (AQtdeItens <= 6) Then
  Begin
    AItem.Height := 552;
    AFrame.lblDescricao.Font.Size             := 25;
    AFrame.lblDescricao.Height                := 100;
    AFrame.fraPrecos.lblPrecoTabela.Font.Size := 17;
    AFrame.fraPrecos.lblPrecoVenda.Font.Size  := 35;
    AFrame.fraPrecos.lblCondicao.Font.Size    := 17;
    AFrame.fraPrecos.lblCondicao.Height       := 20;
    AFrame.fraPrecos.lblDesconto.Font.Size    := 12;
    AFrame.fraPrecos.layPreco.Height          := 45;
    AFrame.fraPrecos.layCondicao.Height       := 20;
    AFrame.fraPrecos.layPromocao.Height       := 20;
    AFrame.fraPrecos.recDesconto.Height       := 20;
    AFrame.fraPrecos.recDesconto.Width        := 50;
    AFrame.fraPrecos.recDesconto.XRadius      := 10;
    AFrame.fraPrecos.recDesconto.YRadius      := 10;
    AFrame.fraPrecos.patSetaBaixo.Width       := 12;
    AFrame.layRodape.Height                   := 85;
  End
  Else If (AQtdeItens <= 8) Then
  Begin
    AItem.Height := 415;
    AFrame.lblDescricao.Font.Size := 20;
    AFrame.lblDescricao.Height    := 73;
    AFrame.fraPrecos.lblPrecoTabela.Font.Size := 13;
    AFrame.fraPrecos.lblPrecoVenda.Font.Size  := 29;
    AFrame.fraPrecos.lblCondicao.Font.Size    := 13;
    AFrame.fraPrecos.lblCondicao.Height       := 17.5;
    AFrame.fraPrecos.lblDesconto.Font.Size    := 10;
    AFrame.fraPrecos.layPreco.Height          := 30;
    AFrame.fraPrecos.layCondicao.Height       := 17.5;
    AFrame.fraPrecos.layPromocao.Height       := 17.5;
    AFrame.fraPrecos.recDesconto.Height       := 17.5;
    AFrame.fraPrecos.recDesconto.Width        := 45;
    AFrame.fraPrecos.recDesconto.XRadius      := 5;
    AFrame.fraPrecos.recDesconto.YRadius      := 5;
    AFrame.fraPrecos.patSetaBaixo.Width       := 10;
    AFrame.layRodape.Height                   := 65;
  End
  Else
  Begin
    AItem.Height := 331;
    AFrame.lblDescricao.Font.Size := 16;
    AFrame.lblDescricao.Height    := 46;
    AFrame.fraPrecos.lblPrecoTabela.Font.Size := 13;
    AFrame.fraPrecos.lblPrecoVenda.Font.Size  := 29;
    AFrame.fraPrecos.lblCondicao.Font.Size    := 13;
    AFrame.fraPrecos.lblCondicao.Height       := 17.5;
    AFrame.fraPrecos.lblDesconto.Font.Size    := 10;
    AFrame.fraPrecos.layPreco.Height          := 30;
    AFrame.fraPrecos.layCondicao.Height       := 17.5;
    AFrame.fraPrecos.layPromocao.Height       := 17.5;
    AFrame.fraPrecos.recDesconto.Height       := 17.5;
    AFrame.fraPrecos.recDesconto.Width        := 45;
    AFrame.fraPrecos.recDesconto.XRadius      := 5;
    AFrame.fraPrecos.recDesconto.YRadius      := 5;
    AFrame.fraPrecos.patSetaBaixo.Width       := 10;
    AFrame.layRodape.Height                   := 65;
  End;
end;

procedure TfmxConsultaPreco.aniCarregando2Finish(Sender: TObject);
begin
  aniCarregando2.Enabled := False;
end;

procedure TfmxConsultaPreco.aniCarregandoFinish(Sender: TObject);
begin
  aniCarregando.Enabled := False;
end;

procedure TfmxConsultaPreco.btnAssistirVideoClick(Sender: TObject);
begin
  If Not recVideo3.TagString.IsEmpty Then
  Begin
    btnFecharVideo.Visible   := False;

    TAnimator.AnimateFloat(recFundoDadosTecnicos, 'Height', recFundoImagem.Height, 0.5, TAnimationType.Out, TInterpolationType.Cubic);
    TAnimator.AnimateFloatWait(btnAssistirVideo, 'Opacity', 0, 0.5, TAnimationType.Out, TInterpolationType.Cubic);

    btnAssistirVideo.Visible := False;
    recVideo3.Visible        := True;

    If TFile.Exists(recVideo3.TagString) Then
      playerDadosTecnicos.OpenMovie(recVideo3.TagString);
  End;
end;

procedure TfmxConsultaPreco.btnFecharVideoClick(Sender: TObject);
begin
  playerDadosTecnicosPlaybackFinished(playerDadosTecnicos);
end;

procedure TfmxConsultaPreco.CarregaAd(AArquivo: String);
Var
  LMedia    : TAVView;
  LAnimation: TFloatAnimation;
  LPlayer   : TAVPlayer;
  LTimer    : TTimer;
begin
  LMedia    := recMedia;
  LAnimation:= aniCarregando;
  LPlayer   := player;
  LTimer    := timerAds;

  Case tabTelas.TabIndex Of
    1:
    Begin
      LMedia    := recMedia2;
      LAnimation:= aniCarregando2;
      LPlayer   := playerProduto;
      LTimer    := timerAdsProduto;
    End;
  End;

  If ContainsStr(ExtensaoImagens, RightStr(AArquivo,3)) Then
  Begin
    LMedia.Bitmap.LoadFromFile(AArquivo);
    LAnimation.Duration := 9.5;
    LAnimation.Start;
  End
  Else if ContainsStr(ExtensaoVideos, RightStr(AArquivo,3)) Then
  Begin
    LTimer.Enabled      := False;
    LAnimation.Duration := player.Duration;
    LAnimation.Stop;

    LPlayer.OpenMovie(AArquivo);
  End;
end;

procedure TfmxConsultaPreco.CarregarComprarJunto;
Var
  LAgregado: IAutoatendimentoConsultaProduto;
  LCount: Integer;
begin
  LCount := 0;
  If LProduto.ProdutosAgregados.Count > 0 Then
  Begin
    lstComprarJunto.Items.Clear;
    lstComprarJunto.BeginUpdate;

    For LAgregado In LProduto.ProdutosAgregados Do
    Begin
      Inc(LCount);

      If (LCount <= 10) Then
      Begin
        Try
          AddComprarJunto(LAgregado, LCount);
        Except
          // Famoso Do Nothing
        End;
      End;
    End;

    lstComprarJunto.EndUpdate;
    DisparaContadorInatividade;
    tabTelas.TabIndex := 4;
  End;
end;

procedure TfmxConsultaPreco.CarregarDadosTecnicos;
Var
  LAtributo: IAutoatendimentoConsultaAtributos;
  LGrupo   : String;
  LCount   : Integer;
begin
  LCount := 0;
  If LProduto.DadosTecnicos.Count > 0 Then
  Begin
    If Not LProduto.PathVideoApresentacao.IsEmpty Then
      recVideo3.TagString := LProduto.PathVideoApresentacao;

    lstDadosTecnicos.Items.Clear;
    lstDadosTecnicos.BeginUpdate;

    For LAtributo In LProduto.DadosTecnicos Do
    Begin
      If LGrupo <> LAtributo.Grupo Then
      Begin
        Inc(LCount);
        AddGrupo(LAtributo.Grupo, LCount);
      End;

      LGrupo := LAtributo.Grupo;

      Inc(LCount);
      AddAtributo(LAtributo, LCount);
    End;

    lstDadosTecnicos.EndUpdate;
    DisparaContadorInatividade;
    tabTelas.TabIndex := 2;
  End;
end;

procedure TfmxConsultaPreco.CarregarProduto(ACodigoBarras: String);
Var
  Item : TCustomBitmapItem;
  Size : TSize;
begin
  LProduto := FConsultaPreco.Consultar(ACodigoBarras);

  If Assigned(LProduto) Then
  Begin
    lblDescricaoProduto.Text            := FormatarTexto(LProduto.Descricao);
    fraPrecosCodBar.Visible             := MostrarPrecos;
    fraPrecosCodBar.lblPrecoTabela.Text := 'R$ ' + FormatFloat('#,##0.00', LProduto.PrecoTabela);
    fraPrecosCodBar.lblPrecoVenda.Text  := 'R$ ' + FormatFloat('#,##0.00', LProduto.PrecoVenda) + ' ' +
                                                 LowerCase(LProduto.UnidadeVenda);
    fraPrecosCodBar.lblCondicao.Text    := LProduto.TextoAdicionalPreco;
    fraPrecosCodBar.lblDesconto.Text    := Round((100 - (LProduto.PrecoVenda * 100) / LProduto.PrecoTabela)).ToString() + '%';

    fraPrecosCodBar.LEmPromocao         := LProduto.EmPromocao;
    fraPrecosCodBar.AjustarLayout;

    btnAssistirVideo.Visible := ProdutoTemVideoCadastrado;

    If btnAssistirVideo.Visible Then
      recFundoDadosTecnicos.Height := 1540
    else
      recFundoDadosTecnicos.Height := 1690;

    If Not LProduto.PathImagemPrincipal.IsEmpty Then
      imgProduto.Bitmap.LoadFromFile(LProduto.PathImagemPrincipal)
    Else
    Begin
      imgFundos.BitmapItemByName('Indisponivel', Item, Size);
      imgProduto.Bitmap := Item.MultiResBitmap.Bitmaps[1.0];
    End;

    MostrarBotoesTelaProduto;

    DisparaContadorInatividade;
  End;
end;

procedure TfmxConsultaPreco.CarregarProdutosSimilares;
Var
  LSimilar: IAutoatendimentoConsultaProduto;
  LCount: Integer;
begin
  LCount := 0;
  If LProduto.ProdutosSimilares.Count > 0 Then
  Begin
    lstProdutosSimilares.Items.Clear;
    lstProdutosSimilares.BeginUpdate;

    For LSimilar In LProduto.ProdutosSimilares Do
    Begin
      Inc(LCount);

      Try
        AddProdutoSimilar(LSimilar, LCount);
      Except
        // Famoso Do Nothing
      End;
    End;

    lstProdutosSimilares.EndUpdate;
    DisparaContadorInatividade;
    tabTelas.TabIndex := 3;
  End;
end;

procedure TfmxConsultaPreco.DisparaContadorInatividade;
begin
  timerIdle.Enabled := False;
  timerIdle.Enabled := True;
end;

procedure TfmxConsultaPreco.edtCodigoBarrasChange(Sender: TObject);
begin
  If Not TEdit(Sender).Text.IsEmpty Then
  Begin
    CarregarProduto(TEdit(Sender).Text);
    tabTelas.TabIndex := 1;
    TEdit(Sender).Text := '';
  End;
end;

procedure TfmxConsultaPreco.edtCodigoBarrasChangeTracking(Sender: TObject);
begin
  If TEdit(Sender).Text.IsEmpty Then
    lblErro.Text := '';
end;

Function TfmxConsultaPreco.FormatarTexto(ATexto: String): String;
begin
  Result := UpperCase(LeftStr(ATexto,1)) + LowerCase(Copy(LowerCaseComAcento(ATexto), 2, 70));
end;

procedure TfmxConsultaPreco.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FArquivosAds.Free;
end;

procedure TfmxConsultaPreco.FormCreate(Sender: TObject);
begin
  imgVoltar.Visible := False;
  imgHome.Visible   := False;
end;

procedure TfmxConsultaPreco.FormShow(Sender: TObject);
Var
  Item   : TCustomBitmapItem;
  Size   : TSize;
begin
  If Not Assigned(FArquivosAds) Then
    FArquivosAds := TStringList.Create;

  timerFoco.Enabled := True;
  timerIdle.Enabled := False;

  tabTelas.TabIndex := 0;

  If Assigned(FConsultaPreco) Then
    If TFile.Exists(FConsultaPreco.PathLogotipoEmpresa) Then
    begin
      recLogoEmpresa.Fill.Bitmap.Bitmap.LoadFromFile(FConsultaPreco.PathLogotipoEmpresa);
      recLogoEmpresa.Width := recLogoEmpresa.Fill.Bitmap.Bitmap.Width;
    end
    else
      recLogoEmpresa.Visible := False;

  imgFundos.BitmapItemByName(FConsultaPreco.SegmentoCliente, Item, Size);
  recFundoImagem.Fill.Bitmap.Bitmap := Item.MultiResBitmap.Bitmaps[1.0];

  recPubli.Tag          := 0;
  recCarregando.Width   := 0;

  If Not MostrarPrecos Then
    layPrecos.Height := 1;

  ListarAds(FArquivosAds);

  If (FArquivosAds.Count > 0) Then
  Begin
    CarregaAd(FArquivosAds[0]);
    PlayAds;
  End;
end;

procedure TfmxConsultaPreco.FreeComprarJunto;
Var
  LContador : Integer;
  LFrame    : TframeComprarJunto;
begin
  For LContador := 1 to LProduto.ProdutosAgregados.Count do
  Begin
    LFrame := TframeComprarJunto(FindComponent('FrameCompraJunto' + LContador.ToString()));

    If Assigned(LFrame) Then
      LFrame.Free;
  End;
end;

procedure TfmxConsultaPreco.FreeDadosTecnicos;
Var
  LContador : Integer;
  LFrame    : TframeDadosTecnicos;
  LAtributo : IAutoatendimentoConsultaAtributos;
  LGrupo    : String;
begin
  If (playerDadosTecnicos.Playing) Then
    playerDadosTecnicosPlaybackFinished(playerDadosTecnicos);

  If LProduto.DadosTecnicos.Count > 0 Then
  Begin
    For LAtributo In LProduto.DadosTecnicos Do
    Begin
      If LGrupo <> LAtributo.Grupo Then
      Begin
        Inc(LContador);
        LFrame := TframeDadosTecnicos(FindComponent('FrameGrupo' + LContador.ToString()));

        If Assigned(LFrame) Then
          LFrame.Free;
      End;

      LGrupo := LAtributo.Grupo;

      Inc(LContador);
      LFrame := TframeDadosTecnicos(FindComponent('FrameAtributo' + LContador.ToString()));

      If Assigned(LFrame) Then
        LFrame.Free;
    End;
  End;
end;

procedure TfmxConsultaPreco.FreeProdutoSimilar;
Var
  LContador : Integer;
  LFrame    : TframeProdutosSimilares;
begin
  For LContador := 1 to LProduto.ProdutosSimilares.Count do
  Begin
    LFrame := TframeProdutosSimilares(FindComponent('FrameSimilar' + LContador.ToString()));

    If Assigned(LFrame) Then
      LFrame.Free;
  End;
end;

procedure TfmxConsultaPreco.imgHomeClick(Sender: TObject);
begin
  Case tabTelas.TabIndex Of
    2: FreeDadosTecnicos;
    3: FreeProdutoSimilar;
    4: FreeComprarJunto;
  End;

  edtCodigoBarras.Text := '';
  timerIdle.Enabled := False;
  tabTelas.TabIndex := 0;
end;

procedure TfmxConsultaPreco.imgVoltarClick(Sender: TObject);
begin
  Case tabTelas.TabIndex Of
    2: FreeDadosTecnicos;
    3: FreeProdutoSimilar;
    4: FreeComprarJunto;
  End;

  tabTelas.TabIndex := 1;
  DisparaContadorInatividade;
  tabTelas.Repaint;
end;

procedure TfmxConsultaPreco.ListarAds(var Lista: TStringList);
Var
  LFile, LPath: String;
begin
  Lista.Clear;
  LPath := System.SysUtils.GetCurrentDir + '\Publicidade\';

  If Not TDirectory.Exists(LPath) Then
    TDirectory.CreateDirectory(LPath);

  If Not TDirectory.IsEmpty(LPath) Then
    For LFile In TDirectory.GetFiles(LPath) Do
      Lista.Add(LFile);
end;

function TfmxConsultaPreco.LowerCaseComAcento(ATexto: String): String;
  Const
    Maiusculo = '¿¬ ‘€√’¡…Õ”⁄«‹';
    Minusculo = '‡‚ÍÙ˚„ı·ÈÌÛ˙Á¸';
  Var
    x : Integer;
Begin
  For x := 1 to Length(ATexto) do
    If Pos(ATexto[x],Maiusculo)<>0 Then
      ATexto[x] := Minusculo[Pos(ATexto[x],Maiusculo)];

  Result := ATexto;
end;

procedure TfmxConsultaPreco.MensagemOk(ATitulo, AMensagem: String);
begin
  Try
    fmxMensagem := TfmxMensagem.Create(Self);
    fmxMensagem.lblDescricao.Text := ATitulo;
    fmxMensagem.lblMensagem.Text  := AMensagem;
    fmxMensagem.ShowModal;
  Finally
    fmxMensagem.Free;
  End;
end;

procedure TfmxConsultaPreco.MostrarBotoesTelaProduto;
Var
  LVisiveis: Integer;
  LWidth   : Single;
begin
  LVisiveis := 0;
  LWidth    := 0;

  If Assigned(LProduto) Then
  Begin
    recDadosTecnicos.Visible     := LProduto.DadosTecnicos.Count > 0;
    recProdutosSimilares.Visible := LProduto.ProdutosSimilares.Count > 0;
    recComprarJunto.Visible      := LProduto.ProdutosAgregados.Count > 0;

    If recDadosTecnicos.Visible Then
      Inc(LVisiveis);

    If recProdutosSimilares.Visible Then
      Inc(LVisiveis);

    If recComprarJunto.Visible Then
      Inc(LVisiveis);

    laybotoes.Visible := True;

    Case LVisiveis Of
      0: laybotoes.Visible := False;
      1: LWidth := 960;
      2: LWidth := 465;
      3: LWidth := 300;
    End;

    recDadosTecnicos.Width     := LWidth;
    recProdutosSimilares.Width := LWidth;
    recComprarJunto.Width      := LWidth;
  End;
end;

procedure TfmxConsultaPreco.OnMensagemAguarde(AMsg: String);
begin
  MensagemOk('Ops!',AMsg);
end;

procedure TfmxConsultaPreco.OnMensagemAoUsuario(AMsg: String);
begin
  MensagemOk('Ops!',AMsg);
end;

procedure TfmxConsultaPreco.OnMensagemDeErro(AMsg: String);
begin
  Case tabTelas.TabIndex Of
   0: Begin
        edtCodigoBarras.Text := '';
        StopAds;
      End;
   1: StopAdsProduto;
  End;

  MensagemOk('Ops!',AMsg);

  If Not edtCodigoBarras.IsFocused Then
    edtCodigoBarras.SetFocus;

  Case tabTelas.TabIndex Of
   0: PlayAds;
   1: PlayAdsProduto;
  End;
end;

procedure TfmxConsultaPreco.PlayAds;
begin
  If (FArquivosAds.Count > 0) Then
  Begin
    aniCarregando.Enabled := True;
    aniCarregando.Pause            := False;
    aniCarregando.StartFromCurrent := True;
    aniCarregando.Start;

    If player.Paused Then
      player.Play
    Else
      timerAds.Enabled        := True;
  End;
end;

procedure TfmxConsultaPreco.PlayAdsProduto;
begin
  If (FArquivosAds.Count > 0) Then
  Begin
    aniCarregando2.Pause            := False;
    aniCarregando2.StartFromCurrent := True;
    aniCarregando2.Start;

    If playerProduto.Paused Then
      playerProduto.Play
    Else
      timerAdsProduto.Enabled := True;
  End;
end;

procedure TfmxConsultaPreco.playerDadosTecnicosPlaybackFinished(
  Sender: TObject);
begin
  If Not btnAssistirVideo.Visible Then
  Begin
    lblCarregando.Visible    := False;
    btnFecharVideo.Visible   := False;
    btnAssistirVideo.Visible := True;
    recVideo3.Visible        := False;

    TAnimator.AnimateFloat(recFundoDadosTecnicos, 'Height', 1540, 1, TAnimationType.&In, TInterpolationType.Cubic);
    TAnimator.AnimateFloatWait(btnAssistirVideo, 'Opacity', 1, 1, TAnimationType.&In, TInterpolationType.Cubic);

    playerDadosTecnicos.CloseMovie;
    lblCarregando.Visible    := True;
    tabTelas.Repaint;
  End;
end;

procedure TfmxConsultaPreco.playerPlaybackFinished(Sender: TObject);
begin
  player.CloseMovie;
  timerAds.Enabled := True;
  tabtelas.Repaint;
end;

procedure TfmxConsultaPreco.playerProdutoPlaybackFinished(Sender: TObject);
begin
  playerProduto.CloseMovie;
  timerAdsProduto.Enabled := True;
  tabtelas.Repaint;
end;

procedure TfmxConsultaPreco.playerProdutoStart(Sender: TObject);
begin
  aniCarregando2.Start;
end;

procedure TfmxConsultaPreco.playerStart(Sender: TObject);
begin
  aniCarregando.Start;
end;

function TfmxConsultaPreco.ProdutoTemVideoCadastrado: Boolean;
begin
  Result := False;

  If Assigned(LProduto) Then
    If Not LProduto.PathVideoApresentacao.IsEmpty Then
      Result := TFile.Exists(LProduto.PathVideoApresentacao);
end;

procedure TfmxConsultaPreco.recComprarJuntoClick(Sender: TObject);
begin
  If Assigned(LProduto) Then
    CarregarComprarJunto;
end;

procedure TfmxConsultaPreco.recDadosTecnicosClick(Sender: TObject);
begin
  If Assigned(LProduto) Then
    CarregarDadosTecnicos;
end;

procedure TfmxConsultaPreco.recProdutosSimilaresClick(Sender: TObject);
begin
  If Assigned(LProduto) Then
    CarregarProdutosSimilares;
end;

procedure TfmxConsultaPreco.recVideo3Click(Sender: TObject);
begin
  If playerDadosTecnicos.Paused Then
  Begin
    playerDadosTecnicos.Play;
    btnFecharVideo.Visible := False;
  End

  Else If playerDadosTecnicos.Playing Then
  Begin
    playerDadosTecnicos.Pause;
    btnFecharVideo.Visible := True;
  End;
end;

procedure TfmxConsultaPreco.recVideo3DblClick(Sender: TObject);
begin
  playerDadosTecnicosPlaybackFinished(playerDadosTecnicos);
end;

procedure TfmxConsultaPreco.StopAds;
begin
  aniCarregando.Pause := True;

  If player.Playing Then
    player.Pause
  Else
    timerAds.Enabled        := False;
end;

procedure TfmxConsultaPreco.StopAdsProduto;
begin
  aniCarregando2.Pause := True;

  If playerProduto.Playing Then
    playerProduto.Pause
  Else
    timerAdsProduto.Enabled := False;
end;

procedure TfmxConsultaPreco.tabTelasChange(Sender: TObject);
begin
  imgHome.Visible   := tabTelas.TabIndex in [1, 2, 3, 4];
  imgVoltar.Visible := tabTelas.TabIndex in [2, 3, 4];

  Case tabTelas.TabIndex Of
    0 :
    Begin
      StopAdsProduto;

      recPubli.Tag          := recPubli2.Tag;

      If Not recMedia2.Bitmap.IsEmpty Then
      Begin
        recMedia.Bitmap := recMedia2.Bitmap;
        recMedia2.Bitmap := Nil;
      End;

      recCarregando.Width   := 0;
      PlayAds;
    End;

    1 :
    Begin
      StopAds;

      recPubli2.Tag      := recPubli.Tag;

      If Not recMedia.Bitmap.IsEmpty Then
      Begin
        recMedia2.Bitmap := recMedia.Bitmap;
        recMedia.Bitmap  := Nil;
      End;

      recCarregando2.Width   := 0;
      aniCarregando2.Enabled := True;

      PlayAdsProduto;
    End;

    2,3,4:
    Begin
      StopAds;
    End;
  End;

  tabTelas.Repaint;
end;

procedure TfmxConsultaPreco.timerAdsProdutoTimer(Sender: TObject);
Var
  LFile: String;
begin
  recPubli2.Tag := recPubli2.Tag + 1;

  If (recPubli2.Tag = FArquivosAds.Count) Then
    recPubli2.Tag := 0;

  recCarregando2.Width := 0;

  If (FArquivosAds.Count > 0) Then
  Begin
    LFile := FArquivosAds[recPubli2.Tag];
    CarregaAd(LFile);
  End;

  aniCarregando2.Enabled := True;
end;

procedure TfmxConsultaPreco.timerAdsTimer(Sender: TObject);
Var
  LFile: String;
begin
  recPubli.Tag := recPubli.Tag + 1;

  If (recPubli.Tag = FArquivosAds.Count) Then
    recPubli.Tag := 0;

  recCarregando.Width := 0;

  If (FArquivosAds.Count > 0) Then
  Begin
    LFile := FArquivosAds[recPubli.Tag];
    CarregaAd(LFile);
    aniCarregando.Enabled := True;
  End;
end;

procedure TfmxConsultaPreco.timerFocoTimer(Sender: TObject);
begin
  Case tabTelas.TabIndex Of
    0:
    Begin
      If Not edtCodigoBarras.IsFocused Then
        edtCodigoBarras.SetFocus;
    End;

    1, 2, 3, 4:
    Begin
      If Not edtCodBar.IsFocused Then
        edtCodBar.SetFocus;
    End;
  End;
end;

procedure TfmxConsultaPreco.timerIdleTimer(Sender: TObject);
begin
  If (tabTelas.TabIndex <> 0) Then
    imgHomeClick(imgHome);
end;

end.
