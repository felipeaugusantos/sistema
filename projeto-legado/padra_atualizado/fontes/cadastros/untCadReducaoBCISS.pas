unit untCadReducaoBCISS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel, cxGrid, Datasnap.DBClient, UniClientDataSet, Uni;

type
  TfrmCadReducaoBCISS = class(TfrmPai)
    cxGridReducao: TcxGridCitel;
    cxGridReducaoDBView: TcxGridDBTableViewCitel;
    cxGridReducaoCLI_CODEMP: TcxGridDBColumn;
    cxGridReducaoCID_DESEMP: TcxGridDBColumn;
    cxGridReducaoREDISS: TcxGridDBColumn;
    cxGridReducaoPrimeiroNivel: TcxGridLevel;
    cdsReducaoBCISS: TUniClientDataSet;
    cdsReducaoBCISSCID_CODEMP: TStringField;
    cdsReducaoBCISSCID_DESEMP: TStringField;
    cdsReducaoBCISSCID_REDISS: TFloatField;
    dtsReducaoBCISS: TDataSource;
    cdsReducaoBCISSCID_CODCID: TStringField;
    procedure btnSairClick(Sender: TObject);
    procedure cdsReducaoBCISSCID_REDISSValidate(Sender: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadReducaoBCISS.btnSairClick(Sender: TObject);
  Var
    qryGen: TUniQuery;
begin

  Try

    cdsReducaoBCISS.DisableControls;
    cdsReducaoBCISS.First;

    While Not cdsReducaoBCISS.Eof do
    Begin

      Try

        qryGen := fCriaQuery;

        qryGen.SQL.Add('UPDATE CADRBC               ');
        qryGen.SQL.Add('   SET CID_REDISS = :REDISS ');
        qryGen.SQL.Add(' WHERE CID_CODCID = :CODCID ');
        qryGen.SQL.Add('   AND CID_CODEMP = :CODEMP ');

        qryGen.ParamByName('REDISS').asFloat := cdsReducaoBCISSCID_REDISS.asFloat;
        qryGen.ParamByName('CODCID').asString := cdsReducaoBCISSCID_CODCID.asString;
        qryGen.ParamByName('CODEMP').asString := cdsReducaoBCISSCID_CODEMP.asString;

        qryGen.ExecSQL;

      Finally
        FreeAndNil(qryGen);
      End;

      cdsReducaoBCISS.Next;

    End;

  Finally
    cdsReducaoBCISS.EnableControls;
    cdsReducaoBCISS.Close;
  End;

  inherited;

end;

procedure TfrmCadReducaoBCISS.cdsReducaoBCISSCID_REDISSValidate(Sender: TField);
begin
  inherited;
  If Sender.Value < 0 Then
  Begin
    pMensagemOk('O valor digitado é inválido. Permitido valor maior ou igual a zero.');
    Abort;
  End;
end;

end.
