unit untRelCartaoImportacao;

interface

uses
  System.SysUtils, System.Classes, frxClass, Uni, untFuncoesSimples, Forms, DB,
  frxExportPDF, frxRich;

type
  TfrmRelCartaoImportacao = class(TDataModule)
    frxRichObject1: TfrxRichObject;
    frxInstrucoesML: TfrxReport;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    frxExportaPDF: TfrxPDFExport;

    procedure AbreInstrucoesMercadoLivre;
  end;

var
  frmRelCartaoImportacao: TfrmRelCartaoImportacao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TfrmRelCartaoImportacao.AbreInstrucoesMercadoLivre;
begin
  pPreviewReport('frmRelCartaoImportacao', 'Instruções para Conciliação Mercado Livre', frmRelCartaoImportacao.frxInstrucoesML);
end;

procedure TfrmRelCartaoImportacao.DataModuleCreate(Sender: TObject);
begin
  frxExportaPDF := TfrxPDFExport.Create(Self);
end;

end.
