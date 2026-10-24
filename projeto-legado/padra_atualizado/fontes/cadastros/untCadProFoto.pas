unit untCadProFoto;

interface

uses
  Windows, Classes, Controls, Forms, untPai, AppEvnts, Menus, StdCtrls, Buttons,
  ExtCtrls, BitBtnLockedIncrem, Vcl.Samples.Spin, frxClass, untFuncoesImagem,
  frxExportCSVTestabilidade, SysUtils, cxImage,Vcl.Graphics, PNGImage, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxTrackBar, Vcl.ComCtrls, Winapi.Messages, Data.DB;

type
  TfrmCadProFoto = class(TfrmPai)
    pnlImage: TPanel;
    ScrollBox1: TScrollBox;
    ImgPro: TImage;
    lblErrImg: TLabel;
    btnTamanhoOriginal: TBitBtnLocked;
    btnDiminuir: TBitBtnLocked;
    btnAumentar: TBitBtnLocked;
    btnAnterior: TBitBtnLocked;
    btnProximo: TBitBtnLocked;
    lblatual: TLabeledEdit;
    lbltotal: TLabeledEdit;
    lbl_: TLabeledEdit;
    btnEnviaWpp: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnTamanhoOriginalClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnDiminuirClick(Sender: TObject);
    procedure btnAumentarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnProximoClick(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure btnEnviaWppClick(Sender: TObject);
  private
    FstrCodItem,
    FstrCodCli: String;
    procedure pZoom(intPorcentagem: integer);
    { Private declarations }
  public
    picOriginal : TPicture;
    cdsImagensLocal : TcdsImagens;
    { Public declarations }

    Class procedure pMostraImagemProduto(ImgPro: TImage; lblErrImg: TLabel; blnImgPro: Boolean; strCodIte: String);
    Class procedure pAmpliaFoto(strBase64 : String; cdsImagens : TcdsImagens; strCodite, strCodcli: String; blnExibeBotaoEnviaWhatsapp: Boolean);

  end;


implementation

{$R *.dfm}

Uses
  untFuncoesSimples, untImagemBase64, untTypesSistema, untFuncoes;

procedure TfrmCadProFoto.pZoom(intPorcentagem : integer);
var
  btmImagem   : TBitmap;
  fltMultiplicador : real;
  intWidth,
  intHeight: Integer;
begin
  inherited;
  btmImagem := TBitmap.Create;
  try
   { If imgPro.Proportional Then
    Begin
      btmImagem.Width := imgPro.Width;
      btmImagem.Height := imgPro.Height;
    End
    Else
    Begin }
      intWidth := ImgPro.Picture.Width;
      intHeight := ImgPro.Picture.Height;
      fltMultiplicador := 1 + intPorcentagem / 100;
      btmImagem.Width := Round(intWidth * fltMultiplicador);
      btmImagem.Height := Round(intHeight * fltMultiplicador);
   // End;

    //if (btmImagem.Width <= imgPro.Width) and (btmImagem.Height <= imgPro.Height) then
    //begin
      btmImagem.Canvas.StretchDraw(Rect(0, 0, btmImagem.Width, btmImagem.Height), picOriginal.Graphic);
      ImgPro.Picture.Graphic := btmImagem;
    //end;
  finally
    btmImagem.Free;
    imgPro.Proportional := False;
  end;

end;

procedure TfrmCadProFoto.btnAnteriorClick(Sender: TObject);
begin
  inherited;
  cdsImagensLocal.Prior;

  If cdsImagensLocal.Bof Then
    cdsImagensLocal.Last;

  pImagemFromBase64(cdsImagensLocal.fieldByName('IMGB64').asString, picOriginal);
  imgPro.Picture := picOriginal;
  lblatual.Text := IntToStr(cdsImagensLocal.RecNo);

  btnTamanhoOriginal.Click;

end;

procedure TfrmCadProFoto.btnAumentarClick(Sender: TObject);
begin
  btnAumentar.Enabled := False;
  pZoom(10);
  btnAumentar.Enabled := True;
end;


procedure TfrmCadProFoto.btnDiminuirClick(Sender: TObject);
begin
  btnDiminuir.Enabled := False;
  pZoom(-10);
  btnDiminuir.Enabled := True;
end;

procedure TfrmCadProFoto.btnEnviaWppClick(Sender: TObject);
var
  recImagem: TArray<TRecArquivosGatilhos>;
begin
  inherited;

  If (Not btnEnviaWpp.Visible) Then
    Exit;

  if cdsImagensLocal.IsEmpty then
    Exit;

  if fEmptyStr(cdsImagensLocal.FieldByName('IMGB64').AsString) then
    Exit;

  SetLength(recImagem, 1);
  recImagem[0] := TRecArquivosGatilhos.Create('IMAGEM PRODUTO_'+FstrCodItem+'-'+Copy(fRetNomProduto(FstrCodItem),1,10), cdsImagensLocal.FieldByName('IMGB64').AsString, EmptyStr, tpaImagem);

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
                                FstrCodItem) then
    fMensagem('', 'Whatsapp enviado com sucesso!', ['&Ok'])
  else
    fMensagem('', 'Whatsapp não enviado!', ['&Ok']);
end;

procedure TfrmCadProFoto.btnProximoClick(Sender: TObject);
begin
  inherited;
  cdsImagensLocal.Next;

  If cdsImagensLocal.Eof Then
    cdsImagensLocal.First;

  pImagemFromBase64(cdsImagensLocal.fieldByName('IMGB64').asString, picOriginal);
  imgPro.Picture := picOriginal;
  lblatual.Text := IntToStr(cdsImagensLocal.RecNo);

  btnTamanhoOriginal.Click;
end;

procedure TfrmCadProFoto.btnTamanhoOriginalClick(Sender: TObject);
begin
  inherited;
  if btnTamanhoOriginal.Enabled then
  begin
    imgPro.Picture := picOriginal;
    imgPro.Proportional := True;
  end;
end;

class procedure TfrmCadProFoto.pAmpliaFoto(strBase64 : String; cdsImagens : TcdsImagens; strCodite, strCodcli: String; blnExibeBotaoEnviaWhatsapp: Boolean);
var
  frmCadProFoto: TfrmCadProFoto;
begin

  pCriarFormularios(TfrmCadProFoto, frmCadProFoto);
  frmCadProFoto.cdsImagensLocal  := cdsImagens;
  frmCadProFoto.FstrCodItem := strCodite;
  frmCadProFoto.FstrCodcli := strCodcli;
  frmCadProFoto.lblatual.Text := IntToStr(cdsImagens.RecNo);
  frmCadProFoto.lbltotal.Text := IntToStr(cdsImagens.RecordCount);
  frmCadProFoto.btnEnviaWpp.Visible := blnExibeBotaoEnviaWhatsapp;
  pImagemFromBase64(strBase64, frmCadProfoto.picOriginal);
  frmCadProFoto.ShowModal;

  pFreeAndNil(frmCadProFoto);
end;


procedure TfrmCadProFoto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(picOriginal) then
    FreeAndNil(picOriginal);


end;

procedure TfrmCadProFoto.FormCreate(Sender: TObject);
begin
  inherited;
  lblErrImg.Visible := False;
  picOriginal := TPicture.Create;
  FstrCodItem := '';
  FstrCodcli := '';
end;

procedure TfrmCadProFoto.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key of
    VK_F1 : btnTamanhoOriginal.Click;
    VK_F2 : btnDiminuir.Click;
    VK_F3 : btnAumentar.Click;
    VK_F6 : btnEnviaWpp.Click;
  end;
end;

procedure TfrmCadProFoto.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
  inherited;
  If (Msg.Charcode = VK_LEFT) Then
    btnAnterior.Click
  Else
  If (Msg.Charcode = VK_RIGHT) Then
    btnProximo.Click;
end;

procedure TfrmCadProFoto.FormShow(Sender: TObject);
begin
  inherited;
  btnTamanhoOriginalClick(btnTamanhoOriginal);
end;

Class procedure TfrmCadProFoto.pMostraImagemProduto(ImgPro: TImage; lblErrImg: TLabel; blnImgPro: Boolean; strCodIte: String);
Begin

  If blnImgPro Then
  Begin
    if Not fEmptyStr(strCodIte) Then
    Begin
      Case fCarregaImagemProduto(strCodIte, imgPro.Picture) of
        riOk   :
        Begin
          imgPro.Visible := True;
          lblErrImg.Visible := False;
        End;
        riErro :
        Begin
          imgPro.Visible := False;
          lblErrImg.Visible := True;
        End;
        riNulo :
        Begin
          imgPro.Visible := False;
          lblErrImg.Visible := False;
        End;
      End;
    End

    Else Begin
       imgPro.Visible := False;
       lblErrImg.Visible := False;
     End;
  end;

End;

end.
