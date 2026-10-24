unit untGatilhosInformacaoImagemAnexoDashboard;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Math,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dxGDIPlusClasses, Vcl.ExtCtrls,
  Vcl.StdCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxImage, cxLabel;

type
  TGatilhoInformacaoImagemDashboard = record
    strArquivo: string;
    intLargura: integer;
    intAltura: integer;
  end;

  TfrmGatilhosInformacaoImagemAnexoDashboard = class(TForm)
    imgStatusNormal: TImage;
    lblTitulo: TLabel;
    lblDataRelatorio: TLabel;
    imgStatusAlerta: TImage;
    Label1: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
    class function GetImagem(ATitulo, AStatus, ATipo, AEmpresa, APeriodo, AImagem: string): TGatilhoInformacaoImagemDashboard;
    class function GetImagemResize(ATitulo, AStatus, ATipo, AEmpresa, APeriodo, AImagem: string): TGatilhoInformacaoImagemDashboard;
    class function GetImagemResizeJPEG(ATitulo, AStatus, ATipo, AEmpresa, APeriodo, AImagem: string): TGatilhoInformacaoImagemDashboard;
  end;

implementation

uses
  untFuncoesSimples, IOUtils, untFuncoesImagem, Vcl.Imaging.jpeg;

{$R *.dfm}

class function TfrmGatilhosInformacaoImagemAnexoDashboard.GetImagem(ATitulo, AStatus, ATipo, AEmpresa, APeriodo, AImagem: string): TGatilhoInformacaoImagemDashboard;
var
  strArquivo: string;
  imgAnexo: TBitmap;
  frmImagemAnexo: TfrmGatilhosInformacaoImagemAnexoDashboard;
begin
  Result.strArquivo := EmptyStr;
  pCriarFormularios(TfrmGatilhosInformacaoImagemAnexoDashboard, frmImagemAnexo);
  try
    frmImagemAnexo.imgStatusNormal.Visible := Not AStatus.ToUpper.Equals('ALERTA');
    frmImagemAnexo.imgStatusAlerta.Visible := AStatus.ToUpper.Equals('ALERTA');
    frmImagemAnexo.lblTitulo.Caption := ATitulo;
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

class function TfrmGatilhosInformacaoImagemAnexoDashboard.GetImagemResize(ATitulo, AStatus, ATipo, AEmpresa, APeriodo, AImagem: string): TGatilhoInformacaoImagemDashboard;
var
  strArquivo: string;
  imgAnexo: TBitmap;
  frmImagemAnexo: TfrmGatilhosInformacaoImagemAnexoDashboard;
begin
  Result.strArquivo := EmptyStr;
  pCriarFormularios(TfrmGatilhosInformacaoImagemAnexoDashboard, frmImagemAnexo);
  try
    frmImagemAnexo.imgStatusNormal.Visible := Not AStatus.ToUpper.Equals('ALERTA');
    frmImagemAnexo.imgStatusAlerta.Visible := AStatus.ToUpper.Equals('ALERTA');
    frmImagemAnexo.lblTitulo.Caption := ATitulo;
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

class function TfrmGatilhosInformacaoImagemAnexoDashboard.GetImagemResizeJPEG(ATitulo, AStatus, ATipo, AEmpresa, APeriodo, AImagem: string): TGatilhoInformacaoImagemDashboard;
var
  strArquivo: string;
  imgAnexo: TBitmap;
  imgJpg: TJPEGImage;
  frmImagemAnexo: TfrmGatilhosInformacaoImagemAnexoDashboard;
begin
  Result.strArquivo := EmptyStr;
  pCriarFormularios(TfrmGatilhosInformacaoImagemAnexoDashboard, frmImagemAnexo);
  try
    frmImagemAnexo.imgStatusNormal.Visible := Not AStatus.ToUpper.Equals('ALERTA');
    frmImagemAnexo.imgStatusAlerta.Visible := AStatus.ToUpper.Equals('ALERTA');
    frmImagemAnexo.lblTitulo.Caption := ATitulo;
    frmImagemAnexo.lblDataRelatorio.Caption := APeriodo;
    imgAnexo := frmImagemAnexo.GetFormImage;
    try
      strArquivo := AImagem;
      ResizeBmp(imgAnexo, 594, 176);

      imgJpg := TJPEGImage.Create;
      try
        imgJpg.CompressionQuality := 90;
        imgJpg.Assign(imgAnexo);
        imgJpg.SaveToFile(strArquivo);
      finally
        imgJpg.Free;
      end;

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
