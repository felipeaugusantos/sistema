unit untHerancaFaixaDescontoVenCnd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, AppEvnts, Menus, Buttons, ExtCtrls,
  Uni, BitBtnLockedIncrem;

type
  TfrmHerancaFaixaDescontoVenCnd = class(TfrmPai)
    Panel1: TPanel;
    Label9: TLabel;
    edtNomVenOri: TEditFocus;
    edtCodVenOri: TEditFocus;
    btnConfirma: TBitBtnLocked;
    Label1: TLabel;
    edtNomVenDes: TEditFocus;
    edtCodVenDes: TEditFocus;
    procedure edtCodVenOriKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVenDesKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);

  private
    { Private declarations }

    function fTransfereFaixas: Boolean;
    function fTemFaixaCadastrada(strCodVen : String): Boolean;

    procedure pCarregaCadOpe(edtCodVen, edtNomVen : TEditFocus);
    procedure pLimpa;

  protected

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;  

  public
    { Public declarations }

  end;

var
  frmHerancaFaixaDescontoVenCnd: TfrmHerancaFaixaDescontoVenCnd;

implementation

uses untFuncoesSimples, untConsultas, Data.DB, untTypesSistema;

{$R *.dfm}


procedure TfrmHerancaFaixaDescontoVenCnd.btnConfirmaClick(Sender: TObject);
  Var
    strMsg : String;
begin
  inherited;

  If fVerificaCampos Then
  Begin

    strMsg := IIF(fTemFaixaCadastrada(edtCodVenDes.Text),
                   'Todas as faixas do vendedor ' + edtNomVenDes.Text + #13 +
                   'serão substituídas pelas faixas do vendedor ' + edtNomVenOri.Text + '!'+ #13 + #13,
                   '');

    If fPergunta(strMsg + 'Confirma Operação?') Then
    Begin
      If fTransfereFaixas Then
      Begin
        pMensagemOk('Transferência de Faixas efetuada com sucesso!');
        pLimpa;
        pSetFocus(edtCodVenOri);
      end;
    End;

  End;
end;

procedure TfrmHerancaFaixaDescontoVenCnd.edtCodVenDesKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrVenDes : TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqOperador(Self, edtCodVenDes, edtNomVenDes, nil, Key, arrVenDes) Then
    Begin
      If fValidaCampos(edtCodVenDes, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmHerancaFaixaDescontoVenCnd.edtCodVenOriKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrVenOri : TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqOperador(Self, edtCodVenOri, edtNomVenOri, nil, Key, arrVenOri) Then
    Begin
      If fValidaCampos(edtCodVenOri, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmHerancaFaixaDescontoVenCnd.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodVenOri);
end;

function TfrmHerancaFaixaDescontoVenCnd.fTemFaixaCadastrada(strCodVen : String): Boolean;
  Var
    qryAux : TUniQuery;
begin
  qryAux := fCriaQuery(Nil);

  With qryAux Do
  Begin
    SQL.Clear;
    SQL.Add('SELECT * FROM FXAVEN');
    SQL.Add('WHERE FXA_CODOPE = :CODOPE');
    ParamByName('CODOPE').AsString := strCodVen;
    Open;

    If IsEmpty Then
      Result := False
    Else
      Result := True;
  End;

  FreeAndNil(qryAux);
end;

function TfrmHerancaFaixaDescontoVenCnd.fTransfereFaixas: Boolean;
  Var
    qryFxaVenOri,
    qryFavDesOri,
    qryAux : TUniQuery;

    strAutIncFxaVen : String;
begin
  inherited;

  qryFxaVenOri := fCriaQuery(Nil);
  qryFavDesOri := fCriaQuery(Nil);
  qryAux       := fCriaQuery(Nil);

  Try
    fStartTransaction;

    With qryAux Do
    Begin
      SQL.Clear;
      SQL.Add('DELETE FROM FAVDES                                 ');
      SQL.Add('WHERE FAV_SEQFXA IN (SELECT AUTOINCREM FROM FXAVEN ');
      SQL.Add('                     WHERE  FXA_CODOPE = :CODDES)  ');
      ParamByName('CODDES').AsString := edtCodVenDes.Text;
      ExecSQL;

      SQL.Clear;
      SQL.Add('DELETE FROM FXAVEN          ');
      SQL.Add('WHERE  FXA_CODOPE = :CODDES ');
      ParamByName('CODDES').AsString := edtCodVenDes.Text;
      ExecSQL;
    End;

    With qryFxaVenOri Do
    Begin
      SQL.Clear;
      SQL.Add('SELECT * FROM FXAVEN      ');
      SQL.Add('WHERE FXA_CODOPE = :CODORI');
      SQL.Add('ORDER BY AUTOINCREM       ');
      ParamByName('CODORI').AsString := edtCodVenOri.Text;
      Open;

      If Not IsEmpty Then
      Begin

        First;
        While Not Eof Do
        Begin

          With qryAux Do
          Begin
            strAutIncFxaVen := fRetAutoIncrem('FXAVEN', VS_strCodEmp);

            SQL.Clear;
            SQL.Add('INSERT INTO     ');
            SQL.Add('  FXAVEN (      ');
            SQL.Add('    AUTOINCREM, ');
            SQL.Add('    FXA_CODOPE, ');
            SQL.Add('    FXA_CODCND) ');
            SQL.Add('  VALUES (      ');
            SQL.Add('    :AUTINC,    ');            
            SQL.Add('    :CODDES,    ');
            SQL.Add('    :CODCND)    ');
            ParamByName('AUTINC').AsString := strAutIncFxaVen;
            ParamByName('CODDES').AsString := edtCodVenDes.Text;
            ParamByName('CODCND').AsString := qryFxaVenOri.FieldByName('FXA_CODCND').AsString;
            ExecSQL;
          End;

          With qryFavDesOri Do
          Begin
            SQL.Clear;
            SQL.Add('SELECT * FROM FAVDES');
            SQL.Add('WHERE FAV_SEQFXA = :SEQFXA');
            SQL.Add('ORDER BY AUTOINCREM');
            ParamByName('SEQFXA').AsString := qryFxaVenOri.FieldByName('AUTOINCREM').AsString;
            Open;

            If Not IsEmpty Then
            Begin

              First;
              while Not Eof Do
              Begin

                With qryAux Do
                Begin
                  SQL.Clear;
                  SQL.Add('INSERT INTO     ');
                  SQL.Add('  FAVDES (      ');
                  SQL.Add('    AUTOINCREM, ');
                  SQL.Add('    FAV_SEQFXA, ');
                  SQL.Add('    FAV_DESINI, ');
                  SQL.Add('    FAV_DESFIN, ');
                  SQL.Add('    FAV_PERCOM) ');
                  SQL.Add('  VALUES (      ');
                  SQL.Add('    :AUTINC,    ');
                  SQL.Add('    :SEQFXA,    ');
                  SQL.Add('    :DESINI,    ');
                  SQL.Add('    :DESFIN,    ');
                  SQL.Add('    :PERCOM)    ');
                  ParamByName('AUTINC').AsString := fRetAutoIncrem('FAVDES', VS_strCodEmp);
                  ParamByName('SEQFXA').AsString := strAutIncFxaVen;
                  ParamByName('DESINI').AsFloat  := qryFavDesOri.FieldByName('FAV_DESINI').AsFloat;
                  ParamByName('DESFIN').AsFloat  := qryFavDesOri.FieldByName('FAV_DESFIN').AsFloat;
                  ParamByName('PERCOM').AsFloat  := qryFavDesOri.FieldByName('FAV_PERCOM').AsFloat;
                  ExecSQL;
                End;

                Next;
              End;

            End;

          End;

          Next;
        End;

      End;

    End;

    fCommit;
    Result := True;

  Except

    On E:Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmCadFaixasVenCndDesc.btnGravarClick]');
      fRollBack;
      Result := False;      
    End;

  End;

  FreeAndNil(qryFxaVenOri);
  FreeAndNil(qryFavDesOri);
  FreeAndNil(qryAux);
end;

function TfrmHerancaFaixaDescontoVenCnd.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    {*************************}
    {* VENDEDOR ORIGEM       *)
    {*************************}
    If (Sender = edtCodVenOri) Then
    Begin
      If fEmptyStr(edtCodVenOri.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O Vendedor Origem deve ser informado!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pCarregaCadOpe(edtCodVenOri, edtNomVenOri);

        If fEmptyStr(edtNomVenOri.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Vendedor Origem não foi encontrado!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If (Not fTemFaixaCadastrada(edtCodVenOri.Text)) Then
          Begin
            fMensagem('ATENÇÃO!', 'O Vendedor ' + edtNomVenOri.Text + ' não tem faixas cadastradas!', ['&Ok']);
            Result := False;      
          End;
        End;
      End;
    End

    {*************************}
    {* VENDEDOR DESTINO      *)
    {*************************}
    Else If (Sender = edtCodVenDes) Then
    Begin
      If fEmptyStr(edtCodVenDes.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O Vendedor Destino deve ser informado!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pCarregaCadOpe(edtCodVenDes, edtNomVenDes);

        If fEmptyStr(edtNomVenDes.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Vendedor Destino não foi encontrado!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If (edtCodVenDes.Text = edtCodVenOri.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'O Vendedor Origem e Destino não podem ser iguais!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmHerancaFaixaDescontoVenCnd.pCarregaCadOpe(edtCodVen, edtNomVen : TEditFocus);
  Var
    qryAux : TUniQuery;
begin
  qryAux := fCriaQuery(Nil);

  With qryAux Do
  Begin
    SQL.Clear;
    SQL.Add('SELECT * FROM CADOPE');
    SQL.Add('WHERE OPE_CODOPE = :CODOPE');
    ParamByName('CODOPE').AsString := edtCodVen.Text;
    Open;

    edtNomVen.Text := FieldByName('OPE_NOMOPE').AsString;
  End;

  FreeAndNil(qryAux);
end;

procedure TfrmHerancaFaixaDescontoVenCnd.pLimpa;
begin
  edtCodVenOri.Clear;
  edtNomVenOri.Clear;
  edtCodVenDes.Clear;
  edtNomVenDes.Clear;
end;

end.

