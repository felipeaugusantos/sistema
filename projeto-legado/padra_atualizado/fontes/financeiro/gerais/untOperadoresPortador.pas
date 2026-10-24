unit untOperadoresPortador;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.AppEvnts, Vcl.Menus,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.CheckLst,
  frxClass, frxExportCSVTestabilidade,untSelecaoGrupoOperadores;

type
  TfrmOperadoresPortador = class(TfrmPai)
    btnGravar: TBitBtnLocked;
    clbOpePor: TCheckListBox;
    btnMarcarDesmarcarTodosOperadores: TBitBtnLocked;
    btnCarregaOperadoresPortadorGrupo: TBitBtnLocked;
    procedure FormActivate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnMarcarDesmarcarTodosOperadoresClick(Sender: TObject);
    procedure btnCarregaOperadoresPortadorGrupoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    procedure pCarregaOperadoresPortador;
    procedure pGravaOperadoresPortador;
    procedure pMarcarDesmarcarTodos(const AclbOpePor: TCheckListBox);
  public
    { Public declarations }
    strCodPor: String;
  end;

var
  frmOperadoresPortador: TfrmOperadoresPortador;

implementation

Uses Uni, untFuncoesSimples,untCadPortadores;

{$R *.dfm}

{ TfrmOperadoresPortador }

procedure TfrmOperadoresPortador.btnCarregaOperadoresPortadorGrupoClick(
  Sender: TObject);
begin
  inherited;
  Try
    pCriarFormularios(TfrmSelecaoGrupoOperadores, frmSelecaoGrupoOperadores);
    frmSelecaoGrupoOperadores.strCodigoPortador := strCodPor;
    frmSelecaoGrupoOperadores.showModal;
    pCarregaOperadoresPortador;
    pSetFocus(btnGravar);
  Finally
	FreeAndNil(frmSelecaoGrupoOperadores);
  End;
end;

procedure TfrmOperadoresPortador.btnGravarClick(Sender: TObject);
begin
  inherited;
  pGravaOperadoresPortador;
end;

procedure TfrmOperadoresPortador.btnMarcarDesmarcarTodosOperadoresClick(Sender: TObject);
begin
  inherited;
  pMarcarDesmarcarTodos(clbOpePor);
end;

procedure TfrmOperadoresPortador.FormActivate(Sender: TObject);
begin
  inherited;

  pCarregaOperadoresPortador;
  pSetFocus(btnGravar);

end;

procedure TfrmOperadoresPortador.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  {**************************************************}
  {* ATUALIZA OS PORTADORES QUE A EMPRESA TEM ACESSO*}
  {***********************************************LE*}
  If fCfgSis('DACPOR', varBoolean) Then
    strPortadoresOperador := fRetPortadoresOperador(strLoginUsuarioLogado);
end;

procedure TfrmOperadoresPortador.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F1) Then
    btnMarcarDesmarcarTodosOperadores.Click
  else if (Key = VK_F2) then
    btnCarregaOperadoresPortadorGrupo.Click;
end;

procedure TfrmOperadoresPortador.pCarregaOperadoresPortador;
  Var
    qryPorOpe: TUniQuery;
    strSQL   : String;
    intPos   : Integer;
begin

  clbOpePor.Clear;

  qryPorOpe := fCriaQuery(Self);

  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE                                 ';
  strSQL := strSQL + '   O.OPE_CODOPE,                                     ';
  strSQL := strSQL + '   O.OPE_NOMOPE,                                     ';
  strSQL := strSQL + '   P.OPE_ACESSO                                      ';
  strSQL := strSQL + ' FROM                                                ';
  strSQL := strSQL + '   CADOPE O                                          ';
  strSQL := strSQL + '   LEFT JOIN POROPE P ON P.OPE_CODOPE = O.OPE_CODOPE ';
  strSQL := strSQL + ' WHERE                                               ';
  strSQL := strSQL + '   P.OPE_CODPOR = :CODPOR AND                        ';
  strSQL := strSQL + '   O.OPE_STATUS = "A"                                ';
  strSQL := strSQL + ' ORDER BY OPE_NOMOPE                                 ';

  With qryPorOpe Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODPOR').AsString := strCodPor;
    Open;
    First;
    intPos := 0;

    While Not Eof Do
    Begin
      clbOpePor.AddItem(FieldByName('OPE_CODOPE').AsString + ' - ' + FieldByName('OPE_NOMOPE').AsString, Nil);
      clbOpePor.Checked[intPos] := (FieldByName('OPE_ACESSO').AsString = 'S');
      Inc(intPos);
      Next;
    End;
  End;

  FreeAndNil(qryPorOpe);

end;

procedure TfrmOperadoresPortador.pGravaOperadoresPortador;
  Var
    qryPorOpe: TUniQuery;
    qryGen   : TUniQuery;
    strSQL   : String;
    intCont  : Integer;

  function fVerificaMudanca(strPor, strOpe, strAtu: String): Boolean;
  Begin
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('SELECT ');
    qryGen.SQL.Add('  OPE_ACESSO ');
    qryGen.SQL.Add('FROM ');
    qryGen.SQL.Add('  POROPE ');
    qryGen.SQL.Add('WHERE OPE_CODPOR = :CODPOR AND OPE_CODOPE = :CODOPE');

    qryGen.ParamByName('CODPOR').AsString := strPor;
    qryGen.ParamByName('CODOPE').AsString := strOpe;
    qryGen.Open;

    Result := (qryGen.FieldByName('OPE_ACESSO').AsString <> strAtu);

    qryGen.Close;
  End;

begin

  Try
    qryPorOpe := fCriaQuery;
    qryGen    := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' UPDATE POROPE ';
    strSQL := strSQL + '   SET         ';
    strSQL := strSQL + '     OPE_ACESSO = :ACESSO ';
    strSQL := strSQL + ' WHERE                    ';
    strSQL := strSQL + '   OPE_CODPOR = :CODPOR AND ';
    strSQL := strSQL + '   OPE_CODOPE = :CODOPE     ';

    fStartTransaction;
    With qryPorOpe Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      For intCont := 0 To clbOpePor.Count - 1 Do
      Begin
        If (fVerificaMudanca(strCodPor,
                            Copy(clbOpePor.Items.Strings[intCont], 01, 03),
                            IIF(clbOpePor.Checked[intCont], 'S', 'N')))
        Then
        Begin
          ParamByName('ACESSO').AsString := IIF(clbOpePor.Checked[intCont], 'S', 'N');
          ParamByName('CODPOR').AsString := strCodPor;
          ParamByName('CODOPE').AsString := Copy(clbOpePor.Items.Strings[intCont], 01, 03);

          ExecSQL;
        End;

      End;
    End;

    fCommit;

    fMensagem('','Operadores gravados com sucesso!', ['&Ok']);

  Except

    fRollBack;
    Raise Exception.Create('Erro ao atualizar operadores do portador ' + strCodPor + '!');

  End;

  FreeAndNil(qryPorOpe);
  FreeAndNil(qryGen);
  Close;

end;

procedure TfrmOperadoresPortador.pMarcarDesmarcarTodos(const AclbOpePor: TCheckListBox);
var
  LintCnt : Integer;
  LintQtdItensChecados : Integer;
begin
  inherited;
  LintQtdItensChecados := 0;
  For LintCnt := 0 To AclbOpePor.Count - 1 Do
  Begin
    If clbOpePor.Checked[LintCnt] = True Then
    Begin
      inc(LintQtdItensChecados);
      break;
    End;
  End;

  If LintQtdItensChecados > 0 Then
  Begin
    For LintCnt := 0 To AclbOpePor.Count - 1 Do
    Begin
      clbOpePor.Checked[LintCnt] := False;
    End;
  End
  Else
  Begin
    For LintCnt := 0 To AclbOpePor.Count - 1 Do
    Begin
      clbOpePor.Checked[LintCnt] := True;
    End;
  End;
end;

end.
