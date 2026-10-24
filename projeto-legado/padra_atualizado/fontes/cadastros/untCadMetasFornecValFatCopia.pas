unit untCadMetasFornecValFatCopia;

interface

uses
  Windows, Classes, Controls, Forms, untPaiEdit, AppEvnts, Menus, StdCtrls,
  Buttons, Mask, MaskEditFocus, CheckLst, ComCtrls, Uni, BitBtnLockedIncrem,
  ExtCtrls;

type
  TfrmCadMetasFornecValFatCopia = class(TfrmPaiEdit)
    Label2: TLabel;
    mskDtaDes: TMaskEditFocus;
    chkCodVen: TCheckListBox;
    Label1: TLabel;
    prgProgresso: TProgressBar;
    btnGravar: TBitBtnLocked;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    intNumMes,
    intNumAno: Integer;
    stlLisVen: TStringList;

    procedure pCarregaVendedores;

    Function fValidaMesAno: Boolean;
    Function fCopiaMetas: Boolean;
    Function fValidaVendedores: Boolean;
  public
    { Public declarations }
    strVenOri: String;
    strDtaOri: String;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmCadMetasFornecValFatCopia: TfrmCadMetasFornecValFatCopia;

implementation

uses SysUtils, StrUtils, untPai, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadMetasFornecValFatCopia.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If (ModalResult = mrOk) Then
  Begin

    If fVerificaCampos And
       fPergunta('Cofirma a cópia das Metas para o período de ' + mskDtaDes.EditText + '?') Then
    Begin

      If fCopiaMetas Then
        pMensagemOk('Metas gravadas com sucesso!')
      Else
        action := caNone;

    End

    Else action := caNone;

  End;

end;


function TfrmCadMetasFornecValFatCopia.fValidaMesAno: Boolean;
  Var
    strMesAno: String;
Begin

  Result := True;

  If fEmptyStr(fTiraCaracEspeciais(mskDtaDes.Text)) Then
  Begin
    fMensagem('', 'Informar o mês / ano destino!', ['&O k']);
    Result := False;
  End
  Else
  Begin

    Try
      strToDate('01/' + mskDtaDes.Text);
      strMesAno := fTiraCaracEspeciais(mskDtaDes.Text);
      intNumMes := StrToIntDef(LeftStr(strMesAno, 2), 0);
      intNumAno := StrToIntDef(RightStr(strMesAno, 4), 0);

    Except
      fMensagem('', 'Mês / Ano inválido !', ['&O k']);
      Result := False;
    End;

  End;

End;

Function TfrmCadMetasFornecValFatCopia.fValidaVendedores: Boolean;
  Var
    intContador: Integer;
Begin
  stlLisVen.Clear;

  For intContador := 0 To chkCodVen.Count - 1 Do
    If chkCodVen.Checked[intContador] And
      ( (LeftStr(chkCodVen.Items[intContador], 3) <> strVenOri) Or
        (intNumAno <> StrToIntDef(RightStr(strDtaOri, 4), 0)) Or
        (intNumMes <> StrToIntDef(LeftStr(strDtaOri, 2), 0))
       ) Then
      stlLisVen.Add(LeftStr(chkCodVen.Items[intContador], 3));

  Result := stlLisVen.Count > 0;

  If Not Result Then
    pMensagemOk('Informe pelo menos um vendedor!');
End;

function TfrmCadMetasFornecValFatCopia.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    blnMudarFoco := True;

    If (Sender = mskDtaDes) Then
      Result := fValidaMesAno

    Else If Sender = chkCodVen Then
      Result := fValidaVendedores

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

Function TfrmCadMetasFornecValFatCopia.fCopiaMetas: Boolean;
  Var
    qryValGer: TUniQuery;
    qryInsGer: TUniQuery;
    qryDelete: TUniQuery;
    strSeqGer: String;

    Procedure pApagaMetas;
      Var
        intIndice: Integer;
    Begin
      With qryDelete, SQL Do
      Begin
        Clear;
        Add('DELETE FROM VALGER');
        Add('WHERE');
        Add('  VAL_CODVEN = :CODVEN AND ');
        Add('  VAL_NUMANO = :NUMANO AND ');
        Add('  VAL_NUMMES = :NUMMES     ');

        For intIndice := 0 To stlLisVen.Count - 1 Do
        Begin
          Close;
          ParamByName('CODVEN').AsString  := stlLisVen[intIndice];
          ParamByName('NUMANO').AsInteger := intNumAno;
          ParamByName('NUMMES').AsInteger := intNumMes;
          ExecSQL;
        End;  
      End;
    End;

    Procedure pAbreValGer;
    Begin
      With qryValGer, SQL Do
      Begin
        Clear;
        Add('SELECT * FROM VALGER');
        Add('WHERE');
        Add('  VAL_CODVEN = :CODVEN AND ');
        Add('  VAL_NUMANO = :NUMANO AND ');
        Add('  VAL_NUMMES = :NUMMES     ');

        ParamByName('CODVEN').AsString  := strVenOri;
        ParamByName('NUMANO').AsInteger := StrToIntDef(RightStr(strDtaOri, 4), 0);
        ParamByName('NUMMES').AsInteger := StrToIntDef(LeftStr(strDtaOri, 2), 0);

        Open;
      End;
    End;

    Procedure pIncluiValGer;
      Var
        intIndice: Integer;
    Begin
      With qryInsGer, SQL Do
      Begin
        Clear;

        Add('INSERT INTO VALGER (');
        Add('AUTOINCREM,');
        Add('  VAL_CODEMP,');
        Add('  VAL_CODVEN,');
        Add('  VAL_CODFOR,');
        Add('  VAL_NUMANO,');
        Add('  VAL_NUMMES,');
        Add('  VAL_TOTVAL');
        Add(' ) VALUES (');
        Add('  :AUTINC,');
        Add('  :CODEMP,');
        Add('  :CODVEN,');
        Add('  :CODFOR,');
        Add('  :NUMANO,');
        Add('  :NUMMES,');
        Add('  :TOTVAL');
        Add(' )');

        For intIndice := 0 To stlLisVen.Count - 1 Do
        Begin
          Close;
          strSeqGer := fRetAutoIncrem('VALGER', VS_strCodEmp);
          ParamByName('AUTINC').AsString  := strSeqGer;
          ParamByName('CODEMP').AsString  := VS_strCodEmp;
          ParamByName('CODFOR').AsString  := qryValGer.FieldByName('VAL_CODFOR').AsString;
          ParamByName('TOTVAL').AsFloat   := qryValGer.FieldByName('VAL_TOTVAL').AsFloat;
          ParamByName('CODVEN').AsString  := stlLisVen[intIndice];
          ParamByName('NUMANO').AsInteger := intNumAno;
          ParamByName('NUMMES').AsInteger := intNumMes;
          ExecSQL;

        End;

      End;

    End;

Begin
  Try
    qryValGer := fCriaQuery;
    qryInsGer := fCriaQuery;
    qryDelete := fCriaQuery;

    fStartTransaction;

    pApagaMetas;
    pAbreValGer;

    With qryValGer Do
    Begin
      prgProgresso.Max := RecordCount;

      While Not Eof Do
      Begin
        pIncluiValGer;
        Next;

        prgProgresso.StepBy(1);
        Application.ProcessMessages;
      End;
    End;

    fCommit;

    qryValGer.Close;
    qryInsGer.Close;
    qryDelete.Close;

    FreeAndNil(qryValGer);
    FreeAndNil(qryInsGer);
    FreeAndNil(qryDelete);

    Result := True;
  Except

    On E : Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, '[fCopiaMetas]');
    End;

  End;
End;

procedure TfrmCadMetasFornecValFatCopia.FormCreate(Sender: TObject);
begin
  inherited;

  stlLisVen := TStringList.Create;
end;

procedure TfrmCadMetasFornecValFatCopia.FormDestroy(Sender: TObject);
begin
  inherited;

  FreeAndNil(stlLisVen);
end;

procedure TfrmCadMetasFornecValFatCopia.pCarregaVendedores;
  Var
    qryCadVen: TUniQuery;
Begin
  chkCodVen.Clear;
  qryCadVen := fCriaQuery;
  With qryCadVen, SQL Do
  Begin
    Clear;
    Add('SELECT CONCAT(OPE_CODOPE, " - ", OPE_NOMOPE) AS NOMOPE FROM CADOPE');
    Open;

    While Not Eof Do
    Begin
      chkCodVen.Items.Add(FieldByName('NOMOPE').AsString);
      Next;
    End;

    Close;
  End;
  FreeAndNil(qryCadVen);
End;

procedure TfrmCadMetasFornecValFatCopia.FormShow(Sender: TObject);
begin
  inherited;

  mskDtaDes.Text := strDtaOri;

  pCarregaVendedores;

end;

procedure TfrmCadMetasFornecValFatCopia.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key of
    VK_F10: btnGravar.Click;
  End;
  
end;

end.

