unit Contabilidade.View.MemoInfo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Contabilidade.View.TfrmPaiConfirmaContabilidade, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMemo, frxExportPDF, untFuncoesSimples;

type
  TfrmMemoInfo = class(TfrmPaiConfirmaContabilidade)
    edtInfo: TcxMemo;
    btnExportar: TBitBtnLocked;
    frxReport: TfrxReport;
    frxExpPDF: TfrxPDFExport;
    procedure btnExportarClick(Sender: TObject);
  private
    { Private declarations }
    FNomeRelExport: String;
  public
    { Public declarations }
    property NomeRelExport: String read FNomeRelExport write FNomeRelExport;

  end;

implementation

{$R *.dfm}

procedure TfrmMemoInfo.btnExportarClick(Sender: TObject);
var
  memTexto : TfrxMemoView ;
  LNomeRel : String;
begin
  memTexto := TfrxMemoView(frxReport.FindObject('memTexto')) ;
  if Assigned(memTexto) then
  begin
    memTexto.Memo.Assign(edtInfo.Lines) ;

    try
      if frxReport.PrepareReport then
      begin
        If fEmptyStr(FNomeRelExport) Then
          LNomeRel := 'Rel_Exportacao.pdf'
        else
          LNomeRel := FNomeRelExport;
        frxExpPDF.FileName    := LNomeRel ;
        frxExpPDF.DefaultPath := ExtractFilePath(Application.ExeName);
        frxExpPDF.ShowDialog  := true ;
        if frxReport.Export(frxExpPDF) then
          fMensagem('ATENÇÃO','Arquivo exportado com sucesso!',['&OK']);
      end ;
    except on E: Exception do
      pMensagensErro(E.Message,'[btnExportarClick]');
    end;
  end
  else
    pMensagensErro('Não foi possível exportar o arquivo. Favor verificar!','[btnExportarClick]');
end ;

end.
