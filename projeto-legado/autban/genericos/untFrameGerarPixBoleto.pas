unit untFrameGerarPixBoleto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ExtCtrls,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, QColorLabel, Vcl.StdCtrls, EditFocus, Uni, UniClientDataset,
  Data.DB;

type
  TfraGerarPixBoleto = class(TFrame)
    pnlChavePix: TPanel;
    lblGerarPix: TLabel;
    edtGerarPix: TEditFocus;
    lblGerarPixSN: TColorLabel;
    cmbChavePix: TcxLookupComboBox;
    lblChavePix: TLabel;
    dtsChavesPix: TDataSource;
    procedure edtGerarPixChange(Sender: TObject);
  private
    { Private declarations }
  public
    procedure CarregarChavesPix(ACodigoBanco: String);
    { Public declarations }
  end;

implementation
Uses untFuncAutban, untFuncoesSimples;
{$R *.dfm}

{ TfraGerarPixBoleto }

procedure TfraGerarPixBoleto.CarregarChavesPix(ACodigoBanco: String);
begin
  dtsChavesPix.Dataset := untFuncAutban.RetornaDatasetChavesPixPorBanco(ACodigoBanco,
                                                                        VS_strCodEmp);
end;

procedure TfraGerarPixBoleto.edtGerarPixChange(Sender: TObject);
begin
  cmbChavePix.Enabled := edtGerarPix.Text = 'S';
end;

end.
