unit untEntVendor;

interface

Uses
  SysUtils,
  Classes,
  Uni,
  MaskUtils,
  Controls,
  Math;


Type

  TRecVendor = Record
    blnSemInf: Boolean;
    strCodFor,
    strCodCta,
    strCndPag: String;
    fltValVen: Double;
  End;

  TEntVendor = Class(TComponent)
  Private
    blnUtdCpp: Boolean;
    Function fTemClassificaoCompra: Boolean;
    Function fGetRecVendor: TRecVendor;

  Public

    strCodFor: String;
    strCodCta: String;
    strCndPag: String;
    fltValVen: Double;
    blnGravar: Boolean;
    blnPreNot: Boolean;
    strAutInc: String;

    Constructor Create(Owner: TComponent); override;

    Function fRateiaVendor: Boolean;
    Function fInformaVendor(strForEnt: String): Boolean;
    Function fGravaContasAPagar(strForEnt, strNumDoc, strEspDoc,
                 strCodEmp, strSerie, strCodEve: String;
                 intCtpCon: Integer; dtaDtaEnt: TDate): Boolean;
    Procedure pCarregarPreCtp;

  End;

implementation

Uses
     untCadPag,untFuncoes, untFuncoesSimples, untConstantes, untEntDadosVendor, Data.DB,
  untTypesSistema, untDuplicatas;


Constructor TEntVendor.Create(Owner: TComponent);
Begin
  inherited Create(Owner);

  blnGravar := False;
  strCodFor := '';
  strCodCta := fCfgSis('CTAVDR');
  strCndPag := '';
  fltValVen := 0;

  blnUtdCpp := fCfgSis('UTDCPP', varBoolean);
End;

Function TEntVendor.fTemClassificaoCompra: Boolean;
  Var
    qryEntMer: TUniQuery;
Begin
  If (blnUtdCpp And blnPreNot) Then
    Exit(True);

  qryEntMer := fCriaQuery;

  With qryEntMer Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM TMP_ENTMER LIMIT 1');
    Open;

    Result := (Not IsEmpty) And (Pos(FieldByName('ENT_CLAFIS').AsString, VS_strClaCom) > 0);

    Close;
  End;

  FreeAndNil(qryEntMer);
End;

procedure TEntVendor.pCarregarPreCtp;
var
  recVen: TRecVendor;
begin
  If fltValVen > 0 Then
    Exit;

  recVen := fGetRecVendor;

  If Not recVen.blnSemInf Then
  Begin
    strCodFor := recVen.strCodFor;
    strCodCta := recVen.strCodCta;
    strCndPag := recVen.strCndPag;
    fltValVen := recVen.fltValVen;
  End;
end;

Function TEntVendor.fInformaVendor(strForEnt: String): Boolean;
  Var
    frmEntDadosVendor: TfrmEntDadosVendor;
    recVen: TRecVendor;
Begin
  Result := False;

  If Not fTemClassificaoCompra Then
  Begin
    pMensagemOk('A Classificação fiscal dos itens não está cadastrada como Classificação de Compra!');
    Exit;
  End;

  If fEmptyStr(fRetDescCentroCusto(fCfgSis('CTAVDR'))) Then
  Begin
    pMensagemOk('Configure o Plano de Contas para Vendor em Configurações - Entrada de Mercadorias');
    Exit;
  End;

  Try
    If blnUtdCpp Then
      recVen := fGetRecVendor;

    If fEmptyStr(strCodFor) Then
      strCodFor := strForEnt;

    pCriarFormularios(TfrmEntDadosVendor, frmEntDadosVendor);

    If Assigned(frmEntDadosVendor) Then
    With frmEntDadosVendor Do
    Begin
      edtCodFor.Text := strCodFor;
      edtNomFor.Text := fRetNomFornecedor(edtCodFor.Text);

      fraPlanoDeContas.mskCodCta.Text := strCodCta;
      fraPlanoDeContas.edtDesCta.Text := fRetDescCentroCusto(fraPlanoDeContas.mskCodCta.Text);

      mskCndPag.Text := strCndPag;

      edtValVen.Text := FormatFloat('#0.00', fltValVen);

      If ((blnUtdCpp And Not blnPreNot) And (Not recVen.blnSemInf)) Then
      Begin
        edtCodFor.Text := recVen.strCodFor;
        edtNomFor.Text := fRetNomFornecedor(edtCodFor.Text);

        fraPlanoDeContas.mskCodCta.Text := recVen.strCodCta;
        fraPlanoDeContas.edtDesCta.Text := fRetDescCentroCusto(fraPlanoDeContas.mskCodCta.Text);

        mskCndPag.Text := recVen.strCndPag;

        edtValVen.Text := FormatFloat('#0.00', recVen.fltValVen);
      End;

      If ShowModal = mrOk Then
      Begin
        strCodFor := edtCodFor.Text;
        strCodCta := fraPlanoDeContas.mskCodCta.Text;
        strCndPag := mskCndPag.Text;
        fltValVen := fStrToFloat(edtValVen.Text);

        Result := True;
      End;

    End;

  Except

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TEntVendor.fInformaVendor]');
      Result := False;
    End;

  End;

  If Assigned(frmEntDadosVendor) Then
    FreeAndNil(frmEntDadosVendor);
End;

Function TEntVendor.fGravaContasAPagar(strForEnt, strNumDoc, strEspDoc,
  strCodEmp, strSerie, strCodEve: String; intCtpCon: Integer; dtaDtaEnt: TDate): Boolean;
  Var
    ArrDuplicataVendor: TArrDigDuplicArray;
    intContador: Integer;
Begin
  Result := True;

  If (fltValVen <= 0) Or (Not blnGravar) Then
    Exit;

  SetLength(ArrDuplicataVendor, 0);
  fDigDuplicVar(strCndPag, 0, fltValVen, False, False, False, dtaDtaEnt, False, ArrDuplicataVendor, 0, 'N', False);

  For intContador := Low(ArrDuplicataVendor) To High(ArrDuplicataVendor) Do
  Begin
    If (ArrDuplicataVendor[intContador].dtaDtaVen <> '') And
       (intContador < 24)                                And
       Result Then
      Result := fGravaCadPag('untEntVendor - fGravaContasAPagar',                           // Nome Form LOGCTP
                             'INCLUSAO ENTVENDOR',                                          // Descrição LOGCTP
                             strCodFor,                                                     // Fornecedor
                             fRetSequencialCadPag,                                          // Numero da Duplicata
                             ArrDuplicataVendor[intContador].strSequen,                     // Parcela
                             VS_strCodEmp,                                                  // Empresa
                             strCodCta,                                                     // Centro de Custo
                             '',                                                            // Serie do Documento
                             0,                                                             // Sequencial de Baixa
                             dtaDtaEnt,                                                     // Data do lançamento
                             StrToDate(ArrDuplicataVendor[intContador].dtaDtaVen),          // Data de Vencimento
                             ArrDuplicataVendor[intContador].curValor,                      // Valor da Duplicata
                             ArrDuplicataVendor[intContador].curValor,                      // Valor Original
                             'N',                                                           // Previsão?
                             'N',                                                           // Veio Boleto
                             'N',                                                           // Deposito
                             'REF.VENDOR ' + strEspDoc + ' ' + strNumDoc + '-' + strCodEmp + ' SERIE: ' + strSerie, // Histórico 1
                             '',                                                            // Histórico 2
                             '',                                                            // Histórico da Baixa
                             '',                                                            // Portador da Baixa
                             '',                                                            // Centro de Custo da Baixa
                             '',                                                            // Documento da Baixa
                             '',                                                            // Operador da Baixa
                             0,                                                             // Data do Pagamento
                             0,                                                             // Valor Pago
                             0,                                                             // Valor de Juros
                             0,                                                             // Valor Desconto
                             VS_strCodEmp,                                                  // Empresa
                             strCodEve,                                                     // Código do Evento
                             'N',                                                           // Usa Cheque
                             '',                                                            // Codigo do Portador
                             '',                                                            // Nro do Documento da Baixa
                             0.0,
                             0.0,
                             intCtpCon,
                             False, //blnResCai
                             0,     //intRcxCon
                             '1',   //strTipDoc
                             0,     //fltVendor
                             '',    //strVeioNF
                             strNumDoc + strEspDoc + strCodEmp +
                             fstrEspaco(strSerie, 3) + strForEnt, // Nota de Entrada
                             CTP_VENDOR,
                             '',
                             '',
                             '',
                             '',
                             '',
                             '',
                             'N',
                             '',
                             '',
                             '',
                             '',
                             '',
                             0,
                             0,
                             0,
                             0,
                             '',
                             0,
                             0,
                             '',
                             '',
                             '',
                             '',
                             '',
                             '0',
                             '',
                             '',
                             '',
                             '',
                             'N');

    If Not Result Then
      Break;
  End;
End;

Function TEntVendor.fRateiaVendor: Boolean;
  Var
    qryEntMer: TUniQuery;
    fltTotIte,
    fltVendor,
    fltVendorIte,
    fltVendorAcu: Double;
    intNumReg: Integer;
Begin
  Try
    qryEntMer := fCriaQuery;

    With qryEntMer Do
    Begin
      If blnGravar Then
        fltVendor    := fltValVen
      Else
        fltVendor    := 0;

      Close;
      SQL.Clear;
      SQL.Add('SELECT SUM(ENT_TOTITE) AS TOTITE FROM TMP_ENTMER');
      Open;
      fltTotIte := FieldByName('TOTITE').AsFloat;

      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM TMP_ENTMER');
      Open;

      fltVendorAcu := 0;
      intNumReg    := 0;

      While Not Eof Do
      Begin
        Inc(intNumReg);

        If intNumReg = RecordCount Then
        Begin
          fltVendorIte := fltVendor - fltVendorAcu;
        End Else
        Begin
          fltVendorIte := RoundTo((FieldByName('ENT_TOTITE').AsFloat / fltTotIte) * fltVendor, -2);
          fltVendorAcu := fltVendorAcu + fltVendorIte;
        End;

        Edit;
        FieldByName('ENT_VENDOR').AsFloat := fltVendorIte;
        Post;

        Next;
      End;

      Close;
    End;

    FreeAndNil(qryEntMer);

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TEntVendor.fRateiaVendor]');
    End;
  End;
End;

function TEntVendor.fGetRecVendor: TRecVendor;
var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  Try
    Try
      qryAux.SQL.Clear;
      qryAux.SQL.Add(' SELECT PRE_CODFOR, PRE_VENCTA, PRE_VENPAG, PRE_VALVEN FROM PRECTP WHERE PRE_SEQGER = :AUTOINCREM ');
      qryAux.ParamByName('AUTOINCREM').AsString := strAutInc;
      qryAux.Open;

      Result.blnSemInf := qryAux.FieldByName('PRE_VALVEN').AsFloat = 0;

      If Result.blnSemInf Then
        Exit;

      Result.strCodFor := qryAux.FieldByName('PRE_CODFOR').AsString;
      Result.strCndPag := qryAux.FieldByName('PRE_VENPAG').AsString;
      Result.strCodCta := qryAux.FieldByName('PRE_VENCTA').AsString;
      Result.fltValVen := qryAux.FieldByName('PRE_VALVEN').AsFloat;

    Except On
      E:Exception Do
      Begin
        pMensagensErro(E.Message, '[TEntVendor.pCarregaDadosPreCtp]');
      End;
    End;
  Finally
    FreeAndNil(qryAux);
  End;

end;

end.
