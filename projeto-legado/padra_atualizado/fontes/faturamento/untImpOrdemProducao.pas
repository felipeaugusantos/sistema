unit untImpOrdemProducao;

interface

uses SysUtils, Uni, DB, WinSpool, untImpNaoFiscal, Dialogs, StrUtils,
  UniDataSetProvider,
  Windows, Forms, Classes, UniClientDataSet, frxClass, untFuncFatTypes,
  untConsertoEquipamento,
  untFuncoesSimples, untFuncoesGenerica, Math, Graphics, MaskUtils, DateUtils,
  untImpMatricial;

Type
  TImpOrdemProducao = class(TObject)
  private
    FInfTin: TRecInfoImpressaoOPTinta;
  protected
    strRisco: String;

    intQtdFol: Integer;
    intLinPag: Integer;
    intQtdFolOri: Integer;
    intQtdAdc: Integer;
    // quantidade de itens adicionais quando tem mais de uma pagina
    intQtdPag: Integer;
    intIteImp: Integer;
    intTotIteImp: Integer;
    intPagina: Integer;
    intLinImp: Integer;

    blnCabEmp: Boolean;
    blnTemSer: Boolean;
    blnEntMat: Boolean;
    blnImpPre: Boolean;
    blnMeiFol: Boolean;

    qryRelatorio: TDataset;

    FNumDoc: String;
    FEspDoc: String;
    FNomImp: String;
    FDesBas: String;

    impMatricial: TImpMatricial;

    procedure pImprimeOPGenerico;
    procedure pImprimeOPCabGenerico;
    procedure pImprimeOPRodGenerico(blnTotal: Boolean);
  public
    strNroVia: String;

    procedure pImprimeOrdemProducaoTintaMaquina(qryRel: TDataset;
      strNumDoc, strEspDoc: String; recInfTin: TRecInfoImpressaoOPTinta;
      strDesBas: String = '');

    Constructor Create(strNomImp: String; blnConfir: Boolean);
    Destructor Destroy; override;
  end;

implementation

uses untFuncoes, untConstantes, untValorPorExtenso;

{ TImpOrdemProducao }

constructor TImpOrdemProducao.Create(strNomImp: String; blnConfir: Boolean);
begin
  inherited Create;

  FNomImp := strNomImp;

  impMatricial := TImpMatricial.Create(FNomImp);
end;

destructor TImpOrdemProducao.Destroy;
begin
  FreeAndNil(impMatricial);

  inherited Destroy;
end;

procedure TImpOrdemProducao.pImprimeOPCabGenerico;
Var
  strControle: String;
  strCgcCpf: String;
  strConPag: String;
  strForPag: String;
begin
  strControle := '';
  strCgcCpf := '';

  blnImpPre := False;
  Inc(intPagina);

  strControle := IntToStr(intPagina) + '/' + IntToStr(intQtdPag);

  If intPagina > 1 Then
  Begin
    pImprimeOPRodGenerico(False);
    intLinImp := 0;
  End;

  strConPag := '';
  strForPag := '';
  strRisco := fReplicatorStr('-', 80);

  impMatricial.Reseta;
  impMatricial.Imp(impMatricial.Cond_10CPI(False), False);
  impMatricial.Imp(impMatricial.CPI_12(False), False);
  impMatricial.Imp(impMatricial.Um_Oitavo(True), False);

  If blnMeiFol Then
    impMatricial.Imp(impMatricial.TamPag(43), False)
  Else
    impMatricial.Imp(impMatricial.TamPag(87), False);

  impMatricial.Imp(impMatricial.Expandido(True), False);
  impMatricial.Imp('ORDEM DE PRODUCAO ', False);
  impMatricial.Imp('No ' + FNumDoc + '-' + FEspDoc, (False));
  impMatricial.Imp(fPadL(strControle, 10));
  impMatricial.Imp(impMatricial.Expandido(False), False);

  impMatricial.Imp('Cliente....: ' + fPadR(qryRelatorio.FieldByName('CLIENTE')
    .AsString, 60));
  impMatricial.pImpMsgQuebra(qryRelatorio.FieldByName('FORMULA').AsString, 80,
    'Formula....: ');
  impMatricial.Imp('Quantidade.: ' +
    fPadR(FloatToStrF(fStrToFloat(qryRelatorio.FieldByName('QTDFORMUL')
    .AsString), ffFixed, 12, 4), 60));

  If Not FInfTin.blnImobil Then
  Begin
    impMatricial.Imp('Montadora..: ' + fPadR(FInfTin.strMontad, 60));
    impMatricial.Imp('Marca......: ' + fPadR(FInfTin.strMarTin, 60));
    impMatricial.Imp('Litros.....: ' + fPadR(FloatToStrF(FInfTin.fltVolPro,
      ffFixed, 12, 4), 60));
    impMatricial.Imp('Embalagem..: ' + fPadR(FInfTin.strDesEmb, 60));
    impMatricial.Imp('Dil/Con....: ' + fPadR(qryRelatorio.FieldByName('DILCON')
      .AsString, 60));
    impMatricial.Imp('Ano........: ' + fPadR(qryRelatorio.FieldByName('ANOCOR')
      .AsString, 60));
    impMatricial.Imp('Variacao...: ' + fPadR(FInfTin.strVariac, 60));
  End;

  impMatricial.Imp(impMatricial.Cond_10CPI(False) +
    impMatricial.CPI_12(True), False);

  If FInfTin.blnImobil Then
  begin
    impMatricial.Imp
      ('-----------------------------------------------------------------------------------------------');
    impMatricial.Imp('BASE...:' + FDesBas + '');
    impMatricial.Imp
      ('-----------------------------------------------------------------------------------------------');
  end;

  If FInfTin.blnColEmb Then
  Begin
    impMatricial.Imp
      ('-----------------------------------------------------------------------------------------------');
    impMatricial.Imp('COLORANTE       QUANTIDADE   EMBALAGEM');
    impMatricial.Imp
      ('-----------------------------------------------------------------------------------------------');
  End
  Else
  Begin
    impMatricial.Imp
      ('-----------------------------------------------------------------------------------------------');
    impMatricial.Imp('COLORANTE       QUANTIDADE');
    impMatricial.Imp
      ('-----------------------------------------------------------------------------------------------');
  End;
end;

procedure TImpOrdemProducao.pImprimeOPGenerico;
begin

  blnCabEmp := False;

  If blnMeiFol Then
  begin
    If fCfgSis('IMPAMR', varBoolean) Then
    Begin
      intQtdFol := 14;
      intQtdFolOri := 14;
    End
    Else
    Begin
      intQtdFol := 18;
      intQtdFolOri := 18;
    End;
    intQtdAdc := 8;
  end
  else
  begin
    If fCfgSis('IMPAMR', varBoolean) Then
    Begin
      intQtdFol := 56;
      intQtdFolOri := 56;
    End
    Else
    Begin
      intQtdFol := 60;
      intQtdFolOri := 60;
    End;
    intQtdAdc := 8;
  end;

  blnTemSer := False;
  blnEntMat := False;
  intQtdPag := 1;

  If (qryRelatorio.RecordCount > intQtdFol) Then
  Begin
    intQtdPag := Ceil(qryRelatorio.RecordCount / intQtdFol);
  End;

  qryRelatorio.First;
  intIteImp := 0;
  intTotIteImp := 0;

  With qryRelatorio Do
  Begin
    While (Not Eof) Do
    Begin

      If (intIteImp = 0) Or (intIteImp >= intQtdFol) Then
      Begin

        If (intIteImp = 0) Or (intQtdFol + intQtdAdc > intQtdFolOri +
          intQtdAdc) Then
        Begin
          pImprimeOPCabGenerico;
          If (intIteImp > 0) Then
            Dec(intQtdFol, intQtdAdc);

          intIteImp := 0;
        End
        Else
        Begin
          If (intTotIteImp >= qryRelatorio.RecordCount) Then
          Begin
            pImprimeOPCabGenerico;
            intIteImp := 0;
            Break;
          End
          Else
            Inc(intQtdFol, intQtdAdc);
        End;
      End;

      If FInfTin.blnColEmb Then
      Begin
        impMatricial.Imp(fPadR(FieldByName('COLORANTE').AsString, 15) + ' ' +
          fPadL(FieldByName('QUANTIDADE').AsString, 11) + ' ' +
          fPadL(FieldByName('EMBALAGEM').AsString, 11));
      End
      Else
      Begin
        impMatricial.Imp(fPadR(FieldByName('COLORANTE').AsString, 15) + ' ' +
          fPadL(FieldByName('QUANTIDADE').AsString, 11));
      End;

      Inc(intIteImp);
      Inc(intTotIteImp);

      Next;
    End;
  End;

  If (intIteImp > intQtdFolOri) Then
  Begin
    pImprimeOPCabGenerico;
  End;

  pImprimeOPRodGenerico(True);
end;

procedure TImpOrdemProducao.pImprimeOPRodGenerico(blnTotal: Boolean);
Var
  strVended: String;
  strDigita: String;
  strDtaEnt: String;
  strHorEnt: String;
  intContador: Integer;
begin

  If (blnTotal) And (intIteImp > intQtdFolOri) Then
  Begin
    For intContador := 1 To intQtdFolOri Do
    Begin
      impMatricial.Imp('');
    End;
  End
  Else
  Begin
    For intContador := intIteImp To intQtdFol Do
    Begin
      impMatricial.Imp('');
    End;
  End;

  If (blnTotal) Then
  Begin

    strVended := fTiraCaracNota(qryRelatorio.FieldByName('VENDEDOR').AsString);
    strDigita := fTiraCaracNota(qryRelatorio.FieldByName('DIGITADOR').AsString);
    strDtaEnt := qryRelatorio.FieldByName('DATA').AsString;
    strHorEnt := qryRelatorio.FieldByName('HORA').AsString;



    If fCfgSis('IMPAMR', varBoolean) Then
    Begin
      impMatricial.Imp
        ('-----------------------------------------------------------------------------------------------');
      impMatricial.Imp(fPadR('PRODUÇÃO', 53) + fPadR('EXPEDIÇÃO', 42));
      impMatricial.Imp(fPadR('Operador: ______________________', 53) +
        fPadR('Responsável: ______________________', 41));
      impMatricial.Imp(fPadR('Hora....: ____:____', 53) +
        fPadR('Hora.......: ____:____', 41));
    End;

    if fCfgSis('IMPVFR', varBoolean) then
    begin
      impMatricial.Imp
        ('-----------------------------------------------------------------------------------------------');
      impMatricial.Imp(fPadR('Valor Unitário do Produto: ' +
        FloatToStrF(qryRelatorio.FieldByName('UNITAR').AsFloat, ffFixed,
        12, 4), 96));
    end;

    impMatricial.Imp
      ('-----------------------------------------------------------------------------------------------');
    impMatricial.Imp(fPadR('Vendedor.: ' + strVended, 62) +
      fPadR('Data / Hora: ' + strDtaEnt + ' / ' + strHorEnt, 34));

    If (fCfgSis('USADIG', varBoolean)) Then
      impMatricial.Imp(fPadR('Digitador: ' + strDigita, 96))
    Else
      impMatricial.Imp('');

  End
  Else
  Begin
    impMatricial.Imp('IMPRESSAO CONTINUA NA PROXIMA PAGINA');
  End;

  impMatricial.Eject;
end;

procedure TImpOrdemProducao.pImprimeOrdemProducaoTintaMaquina(qryRel: TDataset;
  strNumDoc, strEspDoc: String; recInfTin: TRecInfoImpressaoOPTinta;
  strDesBas: String = '');
begin
  qryRelatorio := qryRel;
  FNumDoc := strNumDoc;
  FEspDoc := strEspDoc;
  FInfTin := recInfTin;
  FDesBas := strDesBas;

  impMatricial.pSetaInfoImpressoraMatricial('Impressão de Ordem de Produção',
    True, False);

  impMatricial.pInicializarImpressoraMatricial;

  blnMeiFol := fCfgSis('LAY_OP') = '1';

  pImprimeOPGenerico;

  impMatricial.pFinalizarImpressoraMatricial;
end;

end.
