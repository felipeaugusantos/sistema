unit untEmissaoCheques;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, Data.DB, UniClientDataSet,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Uni, untConsultas, CurrencyEditFocus, Vcl.Mask,
  MaskEditFocus, EditFocus, System.Generics.Collections, untTypesSistema, Math;

type
  TfrmEmissaoCheques = class(TfrmPai)
    pnlDados: TPanel;
    lblCodBco: TLabel;
    edtCodBco: TEditFocus;
    edtNomBco: TEditFocus;
    lblNumAge: TLabel;
    edtNumAge: TEditFocus;
    lblConCor: TLabel;
    edtConCor: TEditFocus;
    lblNumChq: TLabel;
    edtNumChq: TEditFocus;
    lblBomPara: TLabel;
    mskBomPara: TMaskEditFocus;
    lblDtaEmi: TLabel;
    mskDtaEmi: TMaskEditFocus;
    lblFavorecido: TLabel;
    edtFavorecido: TEditFocus;
    Label1: TLabel;
    pnlTotal: TPanel;
    lbl7: TLabel;
    edtTotDig: TEditFocus;
    lbl8: TLabel;
    edtTotGer: TEditFocus;
    btnGravar: TBitBtnLocked;
    edtTotRes: TEditFocus;
    Label2: TLabel;
    edtValChqEmi: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure edtCodBcoKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    qryConBco: TUniQuery;

    procedure pCarregaBanco;
    procedure pGavarCheque;
    procedure pVoltaValorPraAlterar(strChave: String);

    function fExisteCheque(strCodBco, strNumAge, strNumChq, strConCor: String): Boolean;
  public
    { Public declarations }
    fltTotGer: Double;
    blnConfirma: Boolean;

    dicChqEmi: TDictionary<String,TChequeEmitido>;
    procedure pCarregaUltimoChequeEmitido(strCodPor: String; strCodEmp: String);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  end;

var
  frmEmissaoCheques: TfrmEmissaoCheques;

implementation

{$R *.dfm}

uses untFuncoesSimples, untPesqAux, untConfChequesEmitidos;

{ TfrmEmissaoCheques }

procedure TfrmEmissaoCheques.btnGravarClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then
    pGavarCheque;

end;

procedure TfrmEmissaoCheques.btnSairClick(Sender: TObject);
begin

  If Not blnConfirma Then
  Begin
    If fMensagem('ATENÇÃO!', 'Valor digitado diferente do valor total de cheques, deseja cancelar a gravação?', ['&Sim', '&Não'], 2) = 2 Then
    Begin
      pSetFocus(edtCodBco);
      Exit;
    End;
  End;

  inherited;

end;

procedure TfrmEmissaoCheques.edtCodBcoKeyPress(Sender: TObject; var Key: Char);
  Var
    arrBancos: TConsultasArray;
begin
  inherited;

  If fPesqBanco(Self, edtCodBco, edtNomBco, Nil, Key, arrBancos) Then
  Begin
    if fValidaCampos(edtCodBco, True) then
      SelectNext(ActiveControl, True, True);

  End;

end;

function TfrmEmissaoCheques.fExisteCheque(strCodBco, strNumAge, strNumChq, strConCor: String): Boolean;
  Var
    qryGen: TUniQuery;
Begin

  qryGen := fCriaQuery;
  With qryGen, SQL Do
  Begin
    Add('SELECT * FROM CHQEMI');
    Add('WHERE ');
    Add('  EMI_CODBCO = :CODBCO AND ');
    Add('  EMI_NUMAGE = :NUMAGE AND ');
    Add('  EMI_NUMCHQ = :NUMCHQ AND ');
    Add('  EMI_CONCOR = :CONCOR     ');

    ParamByName('CODBCO').AsString := strCodBco;
    ParamByName('NUMAGE').AsString := strNumAge;
    ParamByName('NUMCHQ').AsString := strNumChq;
    ParamByName('CONCOR').AsString := strConCor;

    Open;

    Result := Not IsEmpty;

    Close;
  End;
  FreeAndNil(qryGen);
end;

procedure TfrmEmissaoCheques.FormActivate(Sender: TObject);
begin
  inherited;
  edtTotGer.Text    := FormatFloat('#,##0.00', fltTotGer);
  edtTotRes.Text    := FormatFloat('#,##0.00', fltTotGer);
  edtValChqEmi.Text := FormatFloat('#,##0.00', fltTotGer);

  edtTotDig.Text := '0,00';

  mskBomPara.Clear;
  mskDtaEmi.Text := FormatDateTime('dd/mm/yyyy', VS_Date);

  pSetFocus(edtCodBco);
end;

procedure TfrmEmissaoCheques.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If Not blnConfirma Then
    dicChqEmi.Clear;
  
end;

procedure TfrmEmissaoCheques.FormCreate(Sender: TObject);
begin
  inherited;

  blnConfirma := False;
  qryConBco := fCriarQuery('SELECT * FROM CADBCO WHERE FALSE', Self);

end;

function TfrmEmissaoCheques.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodBco) Then
    Begin
      If fEmptyStr(edtCodBco.Text) Then
      Begin
        fMensagem('', 'O Código do Banco deve ser Informado!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaBanco;

        If (qryConBco.FieldByName('BCO_CODBCO').IsNull) Then
        Begin
          fMensagem('', 'Esse Banco não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtNumAge)Then
    Begin
      If fEmptyStr(edtNumAge.Text) Then
      Begin
        fMensagem('', 'O Código da Agência deve ser Informado!', ['&O k']);
        Result := False;
      End
    End

    Else If (Sender = edtConCor) Then
    Begin
      If fEmptyStr(edtConCor.Text) Then
      Begin
        fMensagem('', 'A Conta Corrente deve ser Informada!', ['&O k']);
        Result := False;
      End
      Else
        edtConCor.Text := fStrZero(edtConCor.Text,12);

    End

    Else If (Sender = edtNumChq) Then
    Begin
      If fEmptyStr(edtNumChq.Text) Then
      Begin
        fMensagem('', 'O Número do Cheque deve ser Informado!', ['&O k']);
        Result := False;
      End
      Else
        edtNumChq.Text := fStrZero(edtNumChq.Text,10);

      If Result Then
      Begin
        If Assigned(dicChqEmi) And
          (dicChqEmi.ContainsKey(edtCodBco.Text+edtNumAge.Text+edtConCor.Text+edtNumChq.Text)) Then
        Begin
          If fMensagem('', 'Cheque já informado: ' + #13+#10 +
                           'Banco - ' + edtCodBco.Text + ' Agência - ' + edtNumAge.Text + #13+#10 +
                           'Conta - ' + edtConCor.Text + ' Cheque - ' + edtNumChq.Text  + #13+#10 +
                           'Valor - R$ ' + FormatFloat('#,##0.00', dicChqEmi[edtCodBco.Text+edtNumAge.Text+edtConCor.Text+edtNumChq.Text].fltValChq) + #13+#10 +
                           'Deseja alterá-lo?', ['&Sim', '&Não'], 2) = 2 Then
            Result := False
          Else
          Begin
            pVoltaValorPraAlterar(edtCodBco.Text+edtNumAge.Text+edtConCor.Text+edtNumChq.Text);
            Result := False;
          End;
        End
        Else
        If fExisteCheque(edtCodBco.Text, edtNumAge.Text, edtNumChq.text, edtConCor.Text) Then
        Begin
          fMensagem('', 'Já existe um cheque com Banco, Agência, Número de Cheque e Conta Corrente iguais as informações digitadas!', ['&O k']);
          Result := False;
        End;

      End;

    End

    Else If (Sender = mskDtaEmi) Then
    Begin
      If (StrToDateDef(mskDtaEmi.Text, 0) = 0) Then
      Begin
        fMensagem('', 'A data de emissão deve ser informada!', ['&O k']);
        Result := False;
      End
      else
      If (StrToDateDef(mskDtaEmi.Text, 0) <= 0) Then
      Begin
        fMensagem('', 'Data informada é inválida. Necessário correção!', ['&O k']);
        Result := False;
      End;

    End

    Else If Sender = mskBomPara Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskBomPara.Text)) Then
      Begin
        If StrToDateDef(mskBomPara.Text, 0) <= 0 Then
        Begin
          fMensagem('', 'Data informada é inválida. Necessário correção!', ['&O k']);
          Result := False;
        End
        Else If StrToDate(mskBomPara.Text) <= StrToDate(mskDtaEmi.Text) Then
        Begin
          fMensagem('', 'A data para depósito "Bom Para" deve ser maior que a data de "Emissão". ' +
                        'Caso a data para depósito do cheque seja a mesma da data da emissão, não informar data no campo "Bom Para"!', ['&O k']);
          Result := False;
        End;

      End;
    End

    Else If Sender = edtValChqEmi Then
    Begin
      If fFormataFloat(fStrToFloat(edtValChqEmi.Text), 2) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O valor do cheque deve ser maior que zero!', ['&O k']);
        Result := False;
      End
      Else If fFormataFloat(fStrToFloat(edtValChqEmi.Text), 2) > fFormataFloat(fStrToFloat(edtTotRes.Text), 2) Then
      Begin
        fMensagem('ATENÇÃO!', 'O valor do cheque deve ser menor ou igual a R$ ' + edtTotRes.Text + '!', ['&O k']);
        Result := False;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmEmissaoCheques.pCarregaBanco;
begin
  pPesquisaCadBco(qryConBco, qryConBco, edtCodBco.Text);
  With qryConBco Do
  Begin
    edtNomBco.Text := FieldByName('BCO_NOMBCO').AsString;
    edtCodBco.Text := FieldByName('BCO_CODBCO').AsString;
  End;
end;

procedure TfrmEmissaoCheques.pCarregaUltimoChequeEmitido(strCodPor,
  strCodEmp: String);
  Var
    qryChqEmi : TUniQuery;

  function fGetSQLUltChqEmi: String;
  begin
    Result := '';
    Result := Result +  ' SELECT  * FROM PORCHQ      ';
    Result := Result +  ' WHERE CHQ_CODPOR = :CODPOR ';
    Result := Result + '   AND CHQ_CODEMP = :CODEMP  ';
  end;

  function fGetApenasNumeros(strTexto: String) : String;
    Var
      i : Integer;
  Begin
    for i := Length(strTexto) downto 1 do
      if not CharInSet(strTexto[i], ['0'..'9']) then
      Delete(strTexto,i,1);
    Result := strTexto;
  End;

  procedure pSetaCampos;
  begin
    edtCodBco.Text := qryChqEmi.FieldByName('CHQ_CODBCO').AsString;
    edtNumAge.Text := qryChqEmi.FieldByName('CHQ_NUMAGE').AsString;
    edtNumChq.Text := fStrZero(IntToStr(StrToInt64(FloatToStr(fStrToFloat(fGetApenasNumeros(qryChqEmi.FieldByName('CHQ_NUMCHQ').AsString)) + 1))), 10);
    edtConCor.Text := qryChqEmi.FieldByName('CHQ_NUMCCO').AsString;
    pCarregaBanco;
  end;

begin
  qryChqEmi := fCriaQuery;

  With qryChqEmi Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(fGetSQLUltChqEmi);
    ParamByName('CODPOR').AsString := strCodPor;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;
    If (Not IsEmpty) Then
      pSetaCampos;
  End;

  FreeAndNil(qryChqEmi);
end;

procedure TfrmEmissaoCheques.pGavarCheque;
  Var
    fltValDig: Double;
    fltValChq: Double;
    fltValRes: Double;
    fltValTot: Double;
    objChqEmi: TChequeEmitido;

begin
  Try

    fltValDig := fFormataFloat(fStrToFloat(edtTotDig.Text), 2);
    fltValRes := fFormataFloat(fStrToFloat(edtTotRes.Text), 2);

    fltValChq := fFormataFloat(fStrToFloat(edtValChqEmi.Text), 2);
    fltValTot := fFormataFloat(fStrToFloat(edtTotGer.Text), 2);

    If fltValChq > 0 Then
    Begin
      fltValDig := fFormataFloat(fltValDig, 2) + fFormataFloat(fltValChq, 2);

      If fFormataFloat(fltValDig, 2) > fFormataFloat(fltValTot, 2) Then
      Begin
        fMensagem('ATENÇÃO!', 'Valor informado maior que o total geral de cheques R$ ' + edtTotGer.Text + ' . Corrija!', ['&Ok']);
        pSetFocus(edtValChqEmi);
        Exit;
      End;

      fltValRes := fltValRes - fltValChq;

      edtTotDig.Text := FormatFloat('#,##0.00', fltValDig);
      edtTotRes.Text := FormatFloat('#,##0.00', fltValRes);

      objChqEmi.strCodBco := edtCodBco.Text;
      objChqEmi.strNumAge := edtNumAge.Text;
      objChqEmi.strConCor := edtConCor.Text;
      objChqEmi.strNumChq := edtNumChq.Text;
      objChqEmi.strDtaEmi := mskDtaEmi.Text;
      objChqEmi.strFavore := edtFavorecido.Text;
      objChqEmi.fltValChq := fFormataFloat(fStrToFloat(edtValChqEmi.Text), 2);
      objChqEmi.blnChqVis := (fEmptyStr(mskBomPara.Text, True));

      If Not fEmptyStr(mskBomPara.Text, True) Then
        objChqEmi.strDtaBom := mskBomPara.Text;

      dicChqEmi.AddOrSetValue(edtCodBco.Text+edtNumAge.Text+edtConCor.Text+edtNumChq.Text, objChqEmi);

      If (edtTotDig.Text = edtTotGer.Text)  And
         (edtTotRes.Text = '0,00')          Then
      Begin

        // AO EMITIR CHEQUES NO VALOR TOTAL INDICADO, SAI DA TELA AUTOMATICAMENTE
        blnConfirma := True;
        btnSair.Click;
        Exit;

      End
      Else
      Begin
        edtValChqEmi.Text := FormatFloat('#,##0.00', fltValRes);
        edtNumChq.Text := fStrZero(IntToStr(StrToInt64(FloatToStr(fStrToFloat(dicChqEmi[edtCodBco.Text+edtNumAge.Text+edtConCor.Text+edtNumChq.Text].strNumChq) + 1))), 10);
        pSetFocus(edtCodBco);
      End;
    End
    Else
    Begin
      fMensagem('ATENÇÃO!', 'Valor do cheque não pode ser zero!', ['&Ok']);
      pSetFocus(edtValChqEmi);
      Exit;
    End;

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;

  End;
end;

procedure TfrmEmissaoCheques.pVoltaValorPraAlterar(strChave: String);
  Var
    fltValChq: Double;
    fltValDig: Double;
    fltValRes: Double;
begin

  fltValDig := fStrToFloat(edtTotDig.Text);
  fltValRes := fStrToFloat(edtTotRes.Text);
  fltValChq := dicChqEmi[strChave].fltValChq;

  edtValChqEmi.Text := FloatToStrF(fltValChq, ffFixed, 12, 2);

  fltValDig := fltValDig - fltValChq;
  fltValRes := fltValRes + fltValChq;

  edtTotDig.Text := FormatFloat('#,##0.00', fltValDig);
  edtTotRes.Text := FormatFloat('#,##0.00', fltValRes);

  dicChqEmi.Remove(strChave);
end;

end.
