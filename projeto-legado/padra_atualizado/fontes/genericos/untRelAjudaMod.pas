unit untRelAjudaMod;

interface

uses
  System.SysUtils, System.Classes, frxClass, Uni, untFuncoesSimples, Forms, DB,
  frxExportPDF;

type
  TfrmRelAjudaMod = class(TForm)
    frxPagina: TfrxReport;
    frxAjudaGmail: TfrxReport;
    frxPDFExport1: TfrxPDFExport;
    frxAjudaRegistroCSGetNet: TfrxReport;
    frxAjudaOutlook: TfrxReport;
  private
    { Private declarations }
  public
    procedure pAbreAjuda(strNomFor, strNomRel: String);
    function  fVerificaHelpExiste(strNomFor, strNomRel: String):Boolean;

    { Public declarations }
  end;

var
  frmRelAjudaMod: TfrmRelAjudaMod;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TfrmRelAjudaMod }

function TfrmRelAjudaMod.fVerificaHelpExiste(strNomFor,
  strNomRel: String): Boolean;
Var
  strSQL   : String;
  qrySelRel: TUniQuery;

Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT HLP_RELFR3 FROM CADHLP ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + ' HLP_NOMFOR=:NOMFOR AND HLP_NOMHLP=:NOMHLP ';

  qrySelRel := fCriaQuery;
  With qrySelRel Do
  Begin
    SQL.Text := strSQL;
    ParamByName('NOMFOR').AsString := strNomFor;
    ParamByName('NOMHLP').AsString := strNomRel;
    Open;

    If RecordCount = 0 Then
      Result := False
    Else
    Begin
      Result := True;
    End;
  End;
  FreeAndNil(qrySelRel);
End;

procedure TfrmRelAjudaMod.pAbreAjuda(strNomFor, strNomRel: String);
  Var
    strSQL   : String;
    qrySelRel: TUniQuery;
    stmRelato: TStream;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT HLP_RELFR3 FROM CADHLP ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + ' HLP_NOMFOR=:NOMFOR AND HLP_NOMHLP=:NOMHLP ';

  qrySelRel := fCriaQuery;
  With qrySelRel Do
  Begin
    SQL.Text := strSQL;
    ParamByName('NOMFOR').AsString := strNomFor;
    ParamByName('NOMHLP').AsString := strNomRel;
    Open;

    If RecordCount = 0 Then
      pMensagemOK('Registro de ajuda não encontrado!')
    Else
    Begin
      stmRelato := CreateBlobStream(FieldByName('HLP_RELFR3'), bmRead);
      stmRelato.Position := 0;
      frxPagina.LoadFromStream(stmRelato);
      pPreviewReport(strNomFor, 'Registro de ajuda (' + strNomRel + ')', frxPagina);
      FreeAndNil(stmRelato);
    End;
  End;
  FreeAndNil(qrySelRel);
End;

end.
