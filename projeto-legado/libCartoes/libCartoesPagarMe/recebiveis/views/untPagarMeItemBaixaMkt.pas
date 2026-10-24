unit untPagarMeItemBaixaMkt;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
     Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls,
     cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus,
     Vcl.StdCtrls, System.ImageList, Vcl.ImgList,

     cxButtons, cxLabel, Vcl.ExtCtrls, cxImage,
     cxImageList,

     untPagarMeTipos, untTPagarMeFuncoes, untLibCartoesImageLists;

type
  TfraPagarMeItemBaixaMkt = class(TFrame)
    pnlMain: TPanel;
    lblTipoLancamento: TcxLabel;
    lblValorLancamentos: TcxLabel;
    lblPeriodo: TcxLabel;
    lblLancamentosPendentes: TcxLabel;
    btnGerarRelatorio: TcxButton;
    lblQuantidadeLancamentos: TcxLabel;
    imgLogoLancamento: TImage;
    imlImagensCards: TcxImageList;
    lblSifrao: TcxLabel;
  private
    function RetornaIndiceImagemBanco(ACodigoBanco: String): Integer;
    { Private declarations }
  public
    procedure ArredondarBordas;
    procedure CarregaLogoLancamento(ATipoLancamento: TTiposLancamentosMkt;
                                    ACodigoBanco: String = '');
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TfraPagarMeItemBaixaMkt }

procedure TfraPagarMeItemBaixaMkt.ArredondarBordas;
  var
    Rgn: HRGN;
begin
  pnlMain.HandleNeeded;

  Rgn := CreateRoundRectRgn(
    0,
    0,
    pnlMain.Width + 1,
    pnlMain.Height + 1,
    15,
    15
  );

  if pnlMain.HandleAllocated then
    SetWindowRgn(pnlMain.Handle, 0, False);

  SetWindowRgn(pnlMain.Handle, Rgn, True);
end;

procedure TfraPagarMeItemBaixaMkt.CarregaLogoLancamento(ATipoLancamento: TTiposLancamentosMkt;
  ACodigoBanco: String = '');
  Var
    LIndiceImagem: Integer;
begin
  If Not Assigned(frmLibCartoesImageLists) Then
    TPagarMeFuncoes.pCriarFormularios(TfrmLibCartoesImageLists, frmLibCartoesImageLists);

  Case ATipoLancamento Of
    tlmVendas: LIndiceImagem := 0;
    tlmAjustes: LIndiceImagem := 1;
    tlmLiquido: LIndiceImagem := 2;
    tlmTransferencias: LIndiceImagem := 2;
    Else LIndiceImagem := -1;
  End;

  If LIndiceImagem = -1 Then
    Exit;

  If ATipoLancamento = tlmTransferencias Then
  Begin
    If Not ACodigoBanco.IsEmpty Then
    Begin
      LIndiceImagem := RetornaIndiceImagemBanco(ACodigoBanco);
      frmLibCartoesImageLists.imlImagensBancos.GetImage(LIndiceImagem, imgLogoLancamento.Picture.Bitmap);

      Exit;
    End;
  End;

  imlImagensCards.GetImage(LIndiceImagem, imgLogoLancamento.Picture.Bitmap);
end;

function TfraPagarMeItemBaixaMkt.RetornaIndiceImagemBanco(
  ACodigoBanco: String): Integer;
  Var
    LCodigoBanco: Integer;
begin
  Result := 0;

  If Not TryStrToInt(ACodigoBanco, LCodigoBanco) Then
    Exit;

  Result := TfrmLibCartoesImageLists.RetornaIndiceBanco(LCodigoBanco);
end;

initialization
  frmLibCartoesImageLists := Nil;

Finalization
  frmLibCartoesImageLists := Nil;

end.
