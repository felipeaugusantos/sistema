unit untB2WItemBaixaMkt;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
     Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls,
     cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus,
     Vcl.StdCtrls, System.ImageList, Vcl.ImgList,

     cxButtons, cxLabel, Vcl.ExtCtrls, cxImage,
     cxImageList,

     untB2WTipos, untTB2WFuncoes, untLibCartoesImageLists;

type
  TfraB2WItemBaixaMkt = class(TFrame)
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

{ TfraB2WItemBaixaMkt }

procedure TfraB2WItemBaixaMkt.ArredondarBordas;
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

procedure TfraB2WItemBaixaMkt.CarregaLogoLancamento(ATipoLancamento: TTiposLancamentosMkt;
  ACodigoBanco: String = '');
  Var
    LIndiceImagem: Integer;
begin
  If Not Assigned(frmLibCartoesImageLists) Then
    TB2WFuncoes.pCriarFormularios(TfrmLibCartoesImageLists, frmLibCartoesImageLists);

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

function TfraB2WItemBaixaMkt.RetornaIndiceImagemBanco(
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
