unit untGatilhosInformacaoImagemAnexo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Math,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dxGDIPlusClasses, Vcl.ExtCtrls,
  Vcl.StdCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxImage, cxLabel;

type
  TGatilhoInformacaoImagem = record
    strArquivo: string;
    intLargura: integer;
    intAltura: integer;
  end;

  TfrmGatilhosInformacaoImagemAnexo = class(TForm)
    imgStatusNormal: TImage;
    lblTitulo: TLabel;
    Label2: TLabel;
    lblRelatorioTipo: TLabel;
    Label4: TLabel;
    lblNomeEmpresa: TLabel;
    lblDataRelatorio: TLabel;
    imgStatusAlerta: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
    class function GetImagem(ATitulo, AStatus, ATipo, AEmpresa, APeriodo, AImagem: string): TGatilhoInformacaoImagem;
    class function GetImagemResize(ATitulo, AStatus, ATipo, AEmpresa, APeriodo, AImagem: string): TGatilhoInformacaoImagem;
  end;

implementation

uses
  untFuncoesSimples, IOUtils, untFuncoesImagem;

{$R *.dfm}

class function TfrmGatilhosInformacaoImagemAnexo.GetImagem(ATitulo, AStatus, ATipo, AEmpresa, APeriodo, AImagem: string): TGatilhoInformacaoImagem;
var
  strArquivo: string;
  imgAnexo: TBitmap;
  frmImagemAnexo: TfrmGatilhosInformacaoImagemAnexo;
begin
  Result.strArquivo := EmptyStr;
  pCriarFormularios(TfrmGatilhosInformacaoImagemAnexo, frmImagemAnexo);
  try
    frmImagemAnexo.imgStatusNormal.Visible := Not AStatus.ToUpper.Equals('ALERTA');
    frmImagemAnexo.imgStatusAlerta.Visible := AStatus.ToUpper.Equals('ALERTA');
    frmImagemAnexo.lblTitulo.Caption := ATitulo;
    frmImagemAnexo.lblRelatorioTipo.Caption := ATipo;
    frmImagemAnexo.lblNomeEmpresa.Caption := AEmpresa;
    frmImagemAnexo.lblDataRelatorio.Caption := APeriodo;
    imgAnexo := frmImagemAnexo.GetFormImage;
    try
      strArquivo := AImagem;
//      ResizeBmp(imgAnexo, 594, 176);
      imgAnexo.SaveToFile(strArquivo);
      if FileExists(strArquivo) then
      begin
        Result.strArquivo := strArquivo;
        Result.intLargura := imgAnexo.Width;
        Result.intAltura  := imgAnexo.Height;
      end;
    finally
      imgAnexo.Free;
    end;
  finally
    pFreeAndNil(frmImagemAnexo);
  end;
end;

class function TfrmGatilhosInformacaoImagemAnexo.GetImagemResize(ATitulo, AStatus, ATipo, AEmpresa, APeriodo, AImagem: string): TGatilhoInformacaoImagem;
var
  strArquivo: string;
  imgAnexo: TBitmap;
  frmImagemAnexo: TfrmGatilhosInformacaoImagemAnexo;
begin
  Result.strArquivo := EmptyStr;
  pCriarFormularios(TfrmGatilhosInformacaoImagemAnexo, frmImagemAnexo);
  try
    frmImagemAnexo.imgStatusNormal.Visible := Not AStatus.ToUpper.Equals('ALERTA');
    frmImagemAnexo.imgStatusAlerta.Visible := AStatus.ToUpper.Equals('ALERTA');
    frmImagemAnexo.lblTitulo.Caption := ATitulo;
    frmImagemAnexo.lblRelatorioTipo.Caption := ATipo;
    frmImagemAnexo.lblNomeEmpresa.Caption := AEmpresa;
    frmImagemAnexo.lblDataRelatorio.Caption := APeriodo;
    imgAnexo := frmImagemAnexo.GetFormImage;
    try
      strArquivo := AImagem;
      ResizeBmp(imgAnexo, 594, 176);
      imgAnexo.SaveToFile(strArquivo);
      if FileExists(strArquivo) then
      begin
        Result.strArquivo := strArquivo;
        Result.intLargura := imgAnexo.Width;
        Result.intAltura  := imgAnexo.Height;
      end;
    finally
      imgAnexo.Free;
    end;
  finally
    pFreeAndNil(frmImagemAnexo);
  end;
end;

end.
