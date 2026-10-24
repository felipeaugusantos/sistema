unit untCadMetasGalonCopia;

interface

uses
  Windows, Classes, Controls, Forms, untPaiEdit, AppEvnts, Menus, StdCtrls,
  Buttons, Mask, MaskEditFocus, CheckLst, ComCtrls, Uni, BitBtnLockedIncrem,
  ExtCtrls;

type
  TfrmCadMetasGalonCopia = class(TfrmPaiEdit)
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
  blnLibera: Boolean;

implementation

uses SysUtils, StrUtils, untPai, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadMetasGalonCopia.FormClose(Sender: TObject;
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


function TfrmCadMetasGalonCopia.fValidaMesAno: Boolean;
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

Function TfrmCadMetasGalonCopia.fValidaVendedores: Boolean;
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

function TfrmCadMetasGalonCopia.fValidaCampos(Sender: TWinControl;
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

Function TfrmCadMetasGalonCopia.fCopiaMetas: Boolean;
  Var
    qryForGer: TUniQuery;
    qryForDet: TUniQuery;
    qryInsGer: TUniQuery;
    qryInsDet: TUniQuery;
    qryDelete: TUniQuery;
    strSeqGer: String;

    Procedure pApagaMetas;
      Var
        intIndice: Integer;
    Begin
      With qryDelete, SQL Do
      Begin
        Clear;
        Add('DELETE FROM FORGER');
        Add('WHERE');
        Add('  GER_CODVEN = :CODVEN AND ');
        Add('  GER_NUMANO = :NUMANO AND ');
        Add('  GER_NUMMES = :NUMMES     ');

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

    Procedure pAbreForGer;
    Begin
      With qryForGer, SQL Do
      Begin
        Clear;
        Add('SELECT * FROM FORGER');
        Add('WHERE');
        Add('  GER_CODVEN = :CODVEN AND ');
        Add('  GER_NUMANO = :NUMANO AND ');
        Add('  GER_NUMMES = :NUMMES     ');

        ParamByName('CODVEN').AsString  := strVenOri;
        ParamByName('NUMANO').AsInteger := StrToIntDef(RightStr(strDtaOri, 4), 0);
        ParamByName('NUMMES').AsInteger := StrToIntDef(LeftStr(strDtaOri, 2), 0);

        Open;
      End;
    End;

    Procedure pAbreForDet;
    Begin
      With qryForDet, SQL Do
      Begin
        Close;
        Clear;
        Add('SELECT * FROM FORDET');
        Add('WHERE');
        Add('  DET_SEQGER = :SEQGER ');

        ParamByName('SEQGER').AsString := qryForGer.FieldByName('AUTOINCREM').AsString;

        Open;
      End;
    End;

    Procedure pIncluiForDet;
    Begin
      With qryInsDet, SQL Do
      Begin
        Clear;

        Add('INSERT INTO FORDET (');
        Add('AUTOINCREM,');
        Add('DET_CODEMP,');
        Add('DET_SEQGER,');
        Add('DET_PERGRU,');
        Add('DET_CODGRU');
        Add(' ) VALUES (');
        Add(':AUTINC,');
        Add(':CODEMP,');
        Add(':SEQGER,');
        Add(':PERGRU,');
        Add(':CODGRU');
        Add(' )');

        Close;

        ParamByName('AUTINC').AsString := fRetAutoIncrem('FORDET', VS_strCodEmp);
        ParamByName('SEQGER').AsString := strSeqGer;
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('CODGRU').AsString := qryForDet.FieldByName('DET_CODGRU').AsString;
        ParamByName('PERGRU').AsFloat  := qryForDet.FieldByName('DET_PERGRU').AsFloat;

        ExecSQL;
      End;
    End;

    Procedure pIncluiForGer;
      Var
        intIndice: Integer;
    Begin
      With qryInsGer, SQL Do
      Begin
        Clear;

        Add('INSERT INTO FORGER (');
        Add('AUTOINCREM,');
        Add('GER_CODEMP,');
        Add('GER_CODVEN,');
        Add('GER_CODFOR,');
        Add('GER_NUMANO,');
        Add('GER_NUMMES,');
        Add('GER_TOTGAL');
        Add(' ) VALUES (');
        Add(':AUTINC,');
        Add(':CODEMP,');
        Add(':CODVEN,');
        Add(':CODFOR,');
        Add(':NUMANO,');
        Add(':NUMMES,');
        Add(':TOTGAL');
        Add(' )');

        For intIndice := 0 To stlLisVen.Count - 1 Do
        Begin
          Close;
          strSeqGer := fRetAutoIncrem('FORGER', VS_strCodEmp);
          ParamByName('AUTINC').AsString  := strSeqGer;
          ParamByName('CODEMP').AsString  := VS_strCodEmp;
          ParamByName('CODFOR').AsString  := qryForGer.FieldByName('GER_CODFOR').AsString;
          ParamByName('TOTGAL').AsFloat   := qryForGer.FieldByName('GER_TOTGAL').AsFloat;
          ParamByName('CODVEN').AsString  := stlLisVen[intIndice];
          ParamByName('NUMANO').AsInteger := intNumAno;
          ParamByName('NUMMES').AsInteger := intNumMes;
          ExecSQL;

          pAbreForDet;

          While Not qryForDet.Eof Do
          Begin
            pIncluiForDet;
            qryForDet.Next;
          End;

        End;

      End;

    End;

Begin
  Try
    qryForGer := fCriaQuery;
    qryForDet := fCriaQuery;
    qryInsGer := fCriaQuery;
    qryInsDet := fCriaQuery;
    qryDelete := fCriaQuery;

    fStartTransaction;

    pApagaMetas;
    pAbreForGer;

    With qryForGer Do
    Begin
      prgProgresso.Max := RecordCount;

      While Not Eof Do
      Begin
        pIncluiForGer;
        Next;

        prgProgresso.StepBy(1);
        Application.ProcessMessages;
      End;
    End;

    fCommit;

    qryForGer.Close;
    qryForDet.Close;
    qryInsGer.Close;
    qryInsDet.Close;
    qryDelete.Close;

    FreeAndNil(qryForGer);
    FreeAndNil(qryForDet);
    FreeAndNil(qryInsGer);
    FreeAndNil(qryInsDet);
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

procedure TfrmCadMetasGalonCopia.FormCreate(Sender: TObject);
begin
  inherited;

  stlLisVen := TStringList.Create;
end;

procedure TfrmCadMetasGalonCopia.FormDestroy(Sender: TObject);
begin
  inherited;

  FreeAndNil(stlLisVen);
end;

procedure TfrmCadMetasGalonCopia.pCarregaVendedores;
  Var
    qryCadVen: TUniQuery;
Begin
  chkCodVen.Clear;
  qryCadVen := fCriaQuery;
  With qryCadVen, SQL Do
  Begin
    Clear;
    Add('SELECT CONCAT(OPE_CODOPE, " - ", OPE_NOMOPE) AS NOMOPE FROM CADOPE');
    If Not blnLibera Then
      Add('  WHERE OPE_CODEMP = ' + QuotedStr(VS_strCodEmp));
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

procedure TfrmCadMetasGalonCopia.FormShow(Sender: TObject);
begin
  inherited;

  mskDtaDes.Text := strDtaOri;

  pCarregaVendedores;

end;

procedure TfrmCadMetasGalonCopia.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key of
    VK_F10: btnGravar.Click;
  End;
  
end;

end.
