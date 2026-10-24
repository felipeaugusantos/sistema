unit untFatFormulacaoDocumentos;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Grids, DBGridCitel, DBGrids, Menus, ComCtrls, DB, Uni,
  Buttons, ExtCtrls, StrUtils, AppEvnts;

type
  TfrmFatFormulacaoDocumentos = class(TfrmPaiSimples)
    dbgDocumentos: TDBGridCitel;
    pnlBotoesFor: TPanel;
    btnCancelarForm: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure btnCancelarFormClick(Sender: TObject);
    procedure dbgDocumentosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    qryForDoc: TUniQuery;
    dtsForDoc: TDataSource;

    function fCriaTemporaria: String;
    procedure pAtualizaTemporaria;
  public
    { Public declarations }
  end;

var
  frmFatFormulacaoDocumentos: TfrmFatFormulacaoDocumentos;

implementation

uses untFuncoes, untFatFormulacaoItens, untFuncoesSimples;

{$R *.dfm}

{ TfrmFatFormulacaoDocumentos }

procedure TfrmFatFormulacaoDocumentos.pAtualizaTemporaria; 
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ' + fCriaTemporaria + ' ';

  With qryForDoc Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;
  End;
end;

function TfrmFatFormulacaoDocumentos.fCriaTemporaria : String;
  Var
    strSQL: String;
    strSQL2: String;
begin
  strSQL := '';
  strSQL := strSQL + '(SELECT ';
  strSQL := strSQL + '  TINGER.*, ';
  strSQL := strSQL + '  CONCAT(TINGER.GER_CODCLI, " - ", IF(TINGER.GER_NOMCON IS NULL, CADCLI.CLI_NOMCLI, TINGER.GER_NOMCON)) AS GER_NOMCLI ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  TINGER, ';
  strSQL := strSQL + '  CADCLI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CADCLI.CLI_CODCLI = TINGER.GER_CODCLI AND ';
  strSQL := strSQL + '  GER_JAPROD = "N" AND ';
  strSQL := strSQL + '  GER_CODEMP = :CODEMP ';

  strSQL2 := AnsiReplaceStr(strSQL, 'TINGER', 'TINGERX');
  Result := strSQL + ' UNION ALL ' + strSQL2+') AUX ';
end;

procedure TfrmFatFormulacaoDocumentos.FormShow(Sender: TObject);
begin
  inherited;
  pAtualizaTemporaria;
end;

procedure TfrmFatFormulacaoDocumentos.FormCreate(Sender: TObject);
begin
  inherited;
  qryForDoc := fCriaQuery(Self);
  dtsForDoc := fCriaDataSource(qryForDoc);
  dbgDocumentos.DataSource := dtsForDoc;
end;

procedure TfrmFatFormulacaoDocumentos.btnCancelarFormClick(
  Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatFormulacaoDocumentos.dbgDocumentosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Return) Then
  Begin

    Try
      Application.CreateForm(TfrmFatFormulacaoItens, frmFatFormulacaoItens);
      frmFatFormulacaoItens.strNumDoc := qryForDoc.FieldByName('GER_NUMDOC').AsString;
      frmFatFormulacaoItens.strEspDoc := qryForDoc.FieldByName('GER_ESPDOC').AsString;
      frmFatFormulacaoItens.ShowModal;
    Finally
      FreeAndNil(frmFatFormulacaoItens);
    End;

    pAtualizaTemporaria;

  End
  Else If (Key = VK_Escape) Then
  Begin
    btnCancelarForm.Click;
  End
end;

end.
