unit untSelDocEntrada;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, Uni, Data.DB;

type
  TfrmSelDocEntrada = class(TfrmPaiConfirma)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    edtEmpDoc: TEditFocus;
    edtSerDoc: TEditFocus;
    edtNomEmp: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtNumDocKeyPress(Sender: TObject; var Key: Char);
    procedure edtEmpDocKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  private
    function fDocumentoExiste(): Boolean;
    procedure pCarregaEmpresa();
  public
    strNumDoc: String;
    strEspDoc: String;
    strEmpDoc: String;
    strSerDoc: String;
    blnConfirma: Boolean;
  end;

implementation

{$R *.dfm}

uses untConsultas, untTypesSistema, untFuncoesSimples;

procedure TfrmSelDocEntrada.btnConfirmaClick(Sender: TObject);
begin
  If fDocumentoExiste() Then
  Begin
    strNumDoc := edtNumDoc.Text;
    strEspDoc := edtEspDoc.Text;
    strEmpDoc := edtEmpDoc.Text;
    strSerDoc := edtSerDoc.Text;

    blnConfirma := True;
    inherited;
  End
  Else
    pSetFocus(edtNumDoc);
end;

procedure TfrmSelDocEntrada.edtEmpDocKeyPress(Sender: TObject; var Key: Char);
var
  arrEmpresa: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtEmpDoc, edtNomEmp, Nil, Key, arrEmpresa) Then
  Begin
    If fValidaCampos(edtEmpDoc,False) Then
      self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmSelDocEntrada.edtNumDocKeyPress(Sender: TObject; var Key: Char);
var
  arrSel: TConsultasArray;
  qryConsulta: TUniQuery;
begin
  inherited;
  qryConsulta := fCriaQuery();
  Try
    If fPesqNFEntrada(Self, edtNumDoc, qryConsulta, Key, arrSel) Then
    Begin
      edtEspDoc.Text := qryConsulta.FieldByName('GER_ESPDOC').AsString;
      edtEmpDoc.Text := qryConsulta.FieldByName('GER_CODEMP').AsString;
      edtSerDoc.Text := qryConsulta.FieldByName('GER_SERIE_').AsString;
      pCarregaEmpresa();

      If fValidaCampos(edtNumDoc, True) Then
        self.SelectNext(ActiveControl, True, True);
    End;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

function TfrmSelDocEntrada.fDocumentoExiste: Boolean;
var
  strSQL: String;
  qryPes: TUniQuery;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT                                ';
  strSQL := strSQL + '  AUTOINCREM                          ';
  strSQL := strSQL + 'FROM                                  ';
  strSQL := strSQL + '  MOVGER                              ';
  strSQL := strSQL + 'WHERE GER_NUMDOC = :NUMDOC            ';
  strSQL := strSQL + '  AND GER_ESPDOC = :ESPDOC            ';
  strSQL := strSQL + '  AND GER_CODEMP = :CODEMP            ';
  strSQL := strSQL + '  AND IFNULL(GER_SERIE_, "") = :SERIE ';
  strSQL := strSQL + '  AND LEFT(GER_CLAFIS, 1) < 5         ';

  qryPes := fCriaQuery();
  Try
    With qryPes Do
    Begin
      SQL.Text := strSQL;
      ParamByName('NUMDOC').AsString := edtNumDoc.Text;
      ParamByName('ESPDOC').AsString := edtEspDoc.Text;
      ParamByName('CODEMP').AsString := edtEmpDoc.Text;
      ParamByName('SERIE').AsString  := edtSerDoc.Text;
      Open;

      If IsEmpty Then
      Begin
        fMensagem('ATENÇÃO', 'Documento não encontrado!', ['&OK']);
        Result := False;
      End
      Else
        Result := True;
    End;
  Finally
    FreeAndNil(qryPes);
  End;
end;

procedure TfrmSelDocEntrada.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
end;

procedure TfrmSelDocEntrada.FormShow(Sender: TObject);
begin
  inherited;
  edtEmpDoc.Text := VS_strCodEmp;
  pCarregaEmpresa();
end;

function TfrmSelDocEntrada.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin

    If (Sender = edtNumDoc) Then
    Begin
      If fEmptyStr(edtNumDoc.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O número do documento deve ser preenchido!', ['%OK']);
        Result := False;
      End;
    End
    Else If (Sender = edtEspDoc) Then
    Begin
      If fEmptyStr(edtEspDoc.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'A espécie do documento deve ser preenchida!', ['%OK']);
        Result := False;
      End;
    End
    Else If (Sender = edtEmpDoc) Then
    Begin
      edtNomEmp.Text := '';
      If fEmptyStr(edtEmpDoc.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'A empresa do documento deve ser preenchida!', ['%OK']);
        Result := False;
      End
      Else
      Begin
        pCarregaEmpresa();
        If fEmptyStr(edtNomEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'Empresa não cadastrada!', ['%OK']);
          Result := False;
        End;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmSelDocEntrada.pCarregaEmpresa;
var
  strSQL: String;
  qryPes: TUniQuery;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT                    ';
  strSQL := strSQL + '  EMP_NOMEMP              ';
  strSQL := strSQL + 'FROM                      ';
  strSQL := strSQL + '  CADEMP                  ';
  strSQL := strSQL + 'WHERE EMP_CODEMP = :CODEMP';

  qryPes := fCriaQuery();
  Try
    With qryPes Do
    Begin
      SQL.Text := strSQL;
      ParamByName('CODEMP').AsString := edtEmpDoc.Text;
      Open;

      edtNomEmp.Text := FieldByName('EMP_NOMEMP').AsString;
    End;
  Finally
    FreeAndNil(qryPes);
  End;
end;

end.
