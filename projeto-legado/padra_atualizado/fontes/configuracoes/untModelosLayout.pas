unit untModelosLayout;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frxClass, frxExportPDF;

type
  TfrmModelosLayout = class(TForm)
    frxPDFExport1: TfrxPDFExport;
    frxCFG_MODCOE: TfrxReport;
    frxCFG_MOEXSI: TfrxReport;
    frxCFG_MODEXP: TfrxReport;
    frxCFG_MDORIN: TfrxReport;
    frxCFG_MODCOL: TfrxReport;
  private
    { Private declarations }
  public
    { Public declarations }
   procedure pExibeLayout(strCodCfg: String);
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

{ TfrmModelosLayout }

procedure TfrmModelosLayout.pExibeLayout(strCodCfg : String);
begin
  If strCodCfg = 'CFG_MODCOE' Then
  Begin
    frxCFG_MODCOE.PrepareReport;
    pPreviewReport(Self.Name, 'Modelo de Layout (CFG_MODCOE)', frxCFG_MODCOE);
  End
  Else If strCodCfg = 'CFG_MOEXSI' Then
  Begin
    frxCFG_MOEXSI.PrepareReport;
    pPreviewReport(Self.Name, 'Modelo de Layout (CFG_MOEXSI)', frxCFG_MOEXSI);
  End
  Else If strCodCfg = 'CFG_MODEXP' Then
  Begin
    frxCFG_MODEXP.PrepareReport;
    pPreviewReport(Self.Name, 'Modelo de Layout (CFG_MODEXP)', frxCFG_MODEXP);
  End
  Else If strCodCfg = 'CFG_MDORIN' Then
  Begin
    frxCFG_MDORIN.PrepareReport;
    pPreviewReport(Self.Name, 'Modelo de Layout (CFG_MDORIN)', frxCFG_MDORIN);
  End
  Else If strCodCfg = 'CFG_MODCOL' Then
  Begin
    frxCFG_MDORIN.PrepareReport;
    pPreviewReport(Self.Name, 'Modelo de Layout (CFG_MODCOL)', frxCFG_MODCOL);
  End;
end;

end.
