unit untFatRomaneioLoteSeparacaoRota;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGridCitel, cxGrid, Datasnap.DBClient, UniClientDataSet,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmFatRomaneioLoteSeparacaoRota = class(TfrmPai)
    cxgDocumentos: TcxGridCitel;
    cxgDocumentosTableView: TcxGridDBTableViewCitel;
    cxgSEQUEN: TcxGridDBColumn;
    cxgDocumentosTableViewColumn1: TcxGridDBColumn;
    cxgDocumentosTableViewColumn2: TcxGridDBColumn;
    cxgDocumentosTableViewColumn3: TcxGridDBColumn;
    cxgDocumentosTableViewColumn4: TcxGridDBColumn;
    cxgDocumentosTableViewColumn5: TcxGridDBColumn;
    cxgDocumentosTableViewColumn6: TcxGridDBColumn;
    cxgDocumentosTableViewColumn7: TcxGridDBColumn;
    cxgDocumentosTableViewColumn8: TcxGridDBColumn;
    cxgDocumentosTableViewColumn9: TcxGridDBColumn;
    cxgDocumentosTableViewColumn10: TcxGridDBColumn;
    cxgDocumentosTableViewColumn11: TcxGridDBColumn;
    cxgDocumentosTableViewColumn12: TcxGridDBColumn;
    cxgDocumentosTableViewColumn13: TcxGridDBColumn;
    cxgDocumentosTableViewColumn14: TcxGridDBColumn;
    cxgDocumentosLevel: TcxGridLevel;
    Label1: TLabel;
    cdsRotas: TUniClientDataSet;
    dtsRotas: TDataSource;
    Panel2: TPanel;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFatRomaneioLoteSeparacaoRota: TfrmFatRomaneioLoteSeparacaoRota;

implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmFatRomaneioLoteSeparacaoRota.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  intPosicaoInicial: integer;
begin
  If (Shift = [ssCtrl]) And cxgDocumentos.IsFocused Then
  Begin
    With cdsRotas Do
    Begin
      If Key = VK_UP Then
      Begin
        Key := 0;
        try
          intPosicaoInicial := FieldByName('SEQUEN').AsInteger;

          if (intPosicaoInicial = 1) then
            Exit;

          Edit;
          FieldByName('SEQUEN').AsInteger := RecordCount + 1;
          Post;

          if Locate('SEQUEN', VarArrayOf([intPosicaoInicial - 1]), []) then
          begin
            Edit;
            FieldByName('SEQUEN').AsInteger := intPosicaoInicial;
            Post;
          end;

          if Locate('SEQUEN', VarArrayOf([RecordCount + 1]), []) then
          begin
            Edit;
            FieldByName('SEQUEN').AsInteger := intPosicaoInicial - 1;
            Post;
          end;

        Finally
          EnableControls;
        End;

      End;

      If Key = VK_DOWN Then
      Begin
        Key := 0;

        Try
          intPosicaoInicial := FieldByName('SEQUEN').AsInteger;

          if (intPosicaoInicial = RecordCount) then
            Exit;

          Edit;
          FieldByName('SEQUEN').AsInteger := RecordCount + 1;
          Post;

          if Locate('SEQUEN', VarArrayOf([intPosicaoInicial + 1]), []) then
          begin
            Edit;
            FieldByName('SEQUEN').AsInteger := intPosicaoInicial;
            Post;
          end;

          if Locate('SEQUEN', VarArrayOf([RecordCount + 1]), []) then
          begin
            Edit;
            FieldByName('SEQUEN').AsInteger := intPosicaoInicial + 1;
            Post;
          end;
        Finally
          EnableControls;
        End;

      End;
    End;
  End;

  inherited;

end;

procedure TfrmFatRomaneioLoteSeparacaoRota.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(btnSair);
end;

end.
