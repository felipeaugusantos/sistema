unit untTCadMovBancarioPortador;

interface
Uses System.Classes, System.StrUtils, System.SysUtils, untTypesSistema, cxProgressBar,
     Uni, Data.DB, System.Variants;

Type
  TTipoMovimentacaoBancariaCartoes = (tpmbcNenhum, tpmbcBaixaCredito, tpmbcBaixaTaxa,
                                      tpmbcBaixaDebito, tpmbcBaixaTaxaAntecipacao);

Type
  TCadMovBancarioPortador = class
  private
    FSeqLanRegistro,
    FNovoPortador: String;

    FTipoRegistroMovBan: TTipoRegistroMovBan;

    FDatasetMovBan,
    FDatasetBanChq: TUniQuery;

    function TipoDeLancamentoContasAReceber: Boolean;
    function TipoDeLancamentoAdiatamentoDeCliente: Boolean;
    function TipoDeLancamentoContasAPagar: Boolean;
    function TipoDeLancamentoBaixaCartoes: Boolean;
    function TipoDeLancamentoDepositoCheques: Boolean;

    function RetornaTipoDeBaixaCartao(ASequencialMovBan: String): TTipoMovimentacaoBancariaCartoes;
    function RetornaCampoFiltroCartao(ATipoBaixa: TTipoMovimentacaoBancariaCartoes;
                                      ATipoCampo: String): String;

    function AtualizaRegistrosBaixaReceber: Boolean;
    function AtualizaRegistrosAdiantamentoCliente: Boolean;
    function AtualizaRegistrosBaixaPagar: Boolean;
    function AtualizaRegistrosBaixaCartoes: Boolean;
    function AtualizaRegistrosDepositoCheques: Boolean;

    procedure AtualizarChequesRepassadosCTP(ASequencialRepasse,
                                            AEmpresaRepasse: String);

    procedure AtualizarChequesEmitidosCTP(ADadosCadPag: TDataset);

    procedure AtualizarMovBansTaxasEAntecipacoes(ATipoBaixa: TTipoMovimentacaoBancariaCartoes;
                                                 ADadosMovCar: TDataset);

    procedure AtualizarMovbansJurosEDescontosCTR(AAutoIncremCTR: String);

    procedure AtualizarCadPagsTaxasEAntecipacoes(ADadosMovCar: TDataset);

    procedure GravaLogCBA(AAutoIncrem: String = '');
  public
    constructor Create(ASeqLanRegistro: String); overload;
    destructor Destroy; override;

    function AlterarPortadorLancamentos(pgbStatus: TcxProgressBar): Boolean;

    function RetornaTipoDeBaixaDaMOVBAN: TTipoRegistroMovBan;

    property TipoRegistroMovBan: TTipoRegistroMovBan read FTipoRegistroMovBan write FTipoRegistroMovBan;
    property NovoPortador: String read FNovoPortador write FNovoPortador;
  end;

implementation
Uses untFuncoesSimples, untLogCba, untLogCtr, untLogCtp, untLogChq, untLogMca;
{ TCadMovBancarioPortador }

function TCadMovBancarioPortador.AlterarPortadorLancamentos(
  pgbStatus: TcxProgressBar): Boolean;
begin
  pgbStatus.Visible := False;

  Case FTipoRegistroMovBan Of
    trmBaixaReceber: Result := AtualizaRegistrosBaixaReceber;
    trmAdiantamentoDeCliente: Result := AtualizaRegistrosAdiantamentoCliente;
    trmBaixaPagar: Result := AtualizaRegistrosBaixaPagar;
    trmBaixaCartoes: Result := AtualizaRegistrosBaixaCartoes;
    trmDepositoCheques: Result := AtualizaRegistrosDepositoCheques;
    Else Result := False;
  End;
end;

procedure TCadMovBancarioPortador.AtualizarCadPagsTaxasEAntecipacoes(
  ADadosMovCar: TDataset);
  Var
    LDados: TUniQuery;
begin
  If ADadosMovCar.IsEmpty Then
    Exit;

  LDados := fCriaQuery;

  Try
    LDados.SQL.Text := 'SELECT * ' +
                       'FROM CADPAG ' +
                       'WHERE CTP_DOCBAI IN ("' + ADadosMovCar.FieldByName('MCA_DOCBTX').AsString + '"';

    If Not ADadosMovCar.FieldByName('MCA_DOCANT').AsString.IsEmpty Then
      LDados.SQL.Add(',"' + ADadosMovCar.FieldByName('MCA_DOCANT').AsString + '"');

    LDados.SQL.Add(')');

    LDados.Open;

    While Not LDados.Eof Do
    Begin
      LDados.Edit;
      LDados.FieldByName('CTP_CODPOR').AsString := FNovoPortador;
      LDados.FieldByName('CTP_PORBAI').AsString := FNovoPortador;
      LDados.Post;

      untLogCtp.GravaLogCtp(LDados.FieldByName('AUTOINCREM').AsString,
                            'ALTERAÇÃO DE PORTADOR DA BAIXA',
                            'frmCadMovBancario');

      LDados.Next;
    End;
  Finally
    FreeAndNil(LDados);
  End;
end;

procedure TCadMovBancarioPortador.AtualizarChequesEmitidosCTP(
  ADadosCadPag: TDataset);
  Var
    LDados: TUniQuery;
begin
  If FDatasetBanChq.IsEmpty Then
    Exit;

  Try
    LDados := fCriaQuery;
    LDados.SQL.Text := 'SELECT * ' +
                       'FROM CHQEMI ' +
                       'WHERE EMI_NUMDUP = "' + ADadosCadPag.FieldByName('CTP_NUMDUP').AsString + '" ' +
                       '  AND EMI_PARCEL = "' + ADadosCadPag.FieldByName('CTP_PARCEL').AsString + '" ' +
                       '  AND EMI_CODEMP = "' + ADadosCadPag.FieldByName('CTP_CODEMP').AsString + '" ' +
                       '  AND EMI_CODFOR = "' + ADadosCadPag.FieldByName('CTP_CODFOR').AsString + '" ' +
                       '  AND EMI_SERIE_ = "' + ADadosCadPag.FieldByName('CTP_SERIE_').AsString + '" ' +
                       '  AND EMI_SEQBAI = ' + ADadosCadPag.FieldByName('CTP_SEQBAI').AsString + ' ' +
                       '  AND EMI_CODPOR = "' + FDatasetMovBan.FieldByName('CTB_CODPOR').AsString + '" ';
    LDados.Open;

    While Not LDados.Eof Do
    Begin
      If FDatasetBanChq.Locate('CHQ_CODBCO;CHQ_NUMAGE;CHQ_CONCOR;CHQ_CODEMP;CHQ_NUMCHQ',
                               VarArrayOf([LDados.FieldByName('EMI_CODBCO').AsString,
                                           LDados.FieldByName('EMI_NUMAGE').AsString,
                                           LDados.FieldByName('EMI_CONCOR').AsString,
                                           LDados.FieldByName('EMI_CODEMP').AsString,
                                           LDados.FieldByName('EMI_NUMCHQ').AsString]),
                               []) Then
      Begin
        LDados.Edit;
        LDados.FieldByName('EMI_CODPOR').AsString := FNovoPortador;
        LDados.Post;
      End;

      LDados.Next;
    End;

    FreeAndNil(LDados);
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao alterar o Portador de um lançamentos dos cheques emitidos' + #13 +
                             'Erro gerado: ' + E.Message);
  End;
end;

procedure TCadMovBancarioPortador.AtualizarChequesRepassadosCTP(
  ASequencialRepasse, AEmpresaRepasse: String);
  Var
    LDados: TUniQuery;
begin
  If ASequencialRepasse.IsEmpty Then
    Exit;

  If AEmpresaRepasse.IsEmpty Then
    Exit;

  Try
    LDados := fCriaQuery;
    LDados.SQL.Text := 'SELECT AUTOINCREM, CHQ_CODPOR, CHQ_PORDEB ' +
                       'FROM CADCHQ ' +
                       'WHERE CHQ_SEQRCH = "' + ASequencialRepasse + '" ' +
                       '  AND CHQ_EMPRCH = "' + AEmpresaRepasse + '" ' +
                       '  AND CHQ_CODPOR = "' + FDatasetMovBan.FieldByName('CTB_CODPOR').AsString + '" ';
    LDados.Open;

    While Not LDados.Eof Do
    Begin
      LDados.Edit;
      LDados.FieldByName('CHQ_CODPOR').AsString := FNovoPortador;
      LDados.FieldByName('CHQ_PORDEB').AsString := FNovoPortador;
      LDados.Post;

      untLogChq.GravaLogChq(LDados.FieldByName('AUTOINCREM').AsString,
                            'ALTERAÇÃO DE PORTADOR CHEQUE REPASSADO',
                            'frmCadMovBancario');

      LDados.Next;
    End;

    FreeAndNil(LDados);
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao alterar o Portador de um lançamentos dos reques repassados' + #13 +
                             'Erro gerado: ' + E.Message);
  End;
end;

function TCadMovBancarioPortador.AtualizaRegistrosAdiantamentoCliente: Boolean;
  Var
    LDados: TUniQuery;
begin
  Result := False;

  fStartTransaction;

  Try
    LDados := fCriaQuery;
    LDados.SQL.Text := 'SELECT AUTOINCREM, ADT_CODPOR ' +
                       'FROM ADTCLI ' +
                       'WHERE ADT_NUMDOC = "' + FDatasetMovBan.FieldByName('CTB_NUMDOC').AsString + '" ' +
                       '  AND ADT_ESPDOC = "PD" ' +
                       '  AND ADT_EMPLAN = "' + FDatasetMovBan.FieldByName('CTB_CODEMP').AsString + '" ' +
                       '  AND ADT_CODCLI = "' + FDatasetMovBan.FieldByName('CTB_CODCLI').AsString + '" ' +
                       '  AND ADT_CODPOR = "' + FDatasetMovBan.FieldByName('CTB_CODPOR').AsString + '" ' +
                       '  AND ADT_TIPLAN = "C" ' +
                       '  AND ADT_ESTORN = "N" ';
    LDados.Open;

    While Not LDados.Eof Do
    Begin
      LDados.Edit;
      LDados.FieldByName('ADT_CODPOR').AsString := FNovoPortador;
      LDados.Post;

      LDados.Next;
    End;

    FDatasetMovBan.Edit;
    FDatasetMovBan.FieldByName('CTB_CODPOR').AsString := FNovoPortador;
    FDatasetMovBan.Post;

    GravaLogCba;

    Result := fCommit;

    FreeAndNil(LDados);
  Except
    On E: Exception Do
    Begin
      fRollBack;

      pMensagensErro('Ocorreu um erro ao alterar o Portador de um lançamentos do Contas a Receber' + #13 +
                     'Erro gerado: ' + E.Message, '[TCadMovBancarioPortador.AtualizaRegistrosBaixaReceber]');
    End;
  End;
end;

function TCadMovBancarioPortador.AtualizaRegistrosBaixaCartoes: Boolean;
  Var
    LDados: TUniQuery;

    LTipoBaixa: TTipoMovimentacaoBancariaCartoes;

    LCampoFiltro,
    LCampoPortador: String;
begin
  Result := False;

  LTipoBaixa := RetornaTipoDeBaixaCartao(FDatasetMovBan.FieldByName('CTB_SEQLAN').AsString);

  LCampoFiltro := RetornaCampoFiltroCartao(LTipoBaixa, 'SEQLAN');
  LCampoPortador := RetornaCampoFiltroCartao(LTipoBaixa, 'CODPOR');

  fStartTransaction;

  Try
    LDados := fCriaQuery;
    LDados.SQL.Text := 'SELECT AUTOINCREM, MCA_DOCBTX, MCA_DOCANT, ' +
                       '   ' + LCampoPortador + ' ' +
                       'FROM MOVCAR ' +
                       'WHERE ' + LCampoFiltro + ' = "' + FDatasetMovBan.FieldByName('CTB_SEQLAN').AsString + '" ';

    LDados.Open;

    While Not LDados.Eof Do
    Begin
      LDados.Edit;
      LDados.FieldByName(LCampoPortador).AsString := FNovoPortador;
      LDados.Post;

      untLogMca.GravaLogMca(LDados.FieldByName('AUTOINCREM').AsString,
                            'ALTERAÇÃO DE PORTADOR DA BAIXA',
                            'frmCadMovBancario');

      LDados.Next;
    End;

    If LTipoBaixa in [tpmbcBaixaTaxa, tpmbcBaixaTaxaAntecipacao] Then
    Begin
      AtualizarMovBansTaxasEAntecipacoes(LTipoBaixa,
                                         LDados);

      AtualizarCadPagsTaxasEAntecipacoes(LDados);
    End;

    FDatasetMovBan.Edit;
    FDatasetMovBan.FieldByName('CTB_CODPOR').AsString := FNovoPortador;
    FDatasetMovBan.Post;

    GravaLogCba;

    Result := fCommit;

    FreeAndNil(LDados);
  Except
    On E: Exception Do
    Begin
      fRollBack;

      pMensagensErro('Ocorreu um erro ao alterar o Portador de um lançamentos do Baixa de Cartões' + #13 +
                     'Erro gerado: ' + E.Message, '[TCadMovBancarioPortador.AtualizaRegistrosBaixaCartoes]');
    End;
  End;
end;

function TCadMovBancarioPortador.AtualizaRegistrosBaixaPagar: Boolean;
  Var
    LDados: TUniQuery;
begin
  Result := False;

  fStartTransaction;

  Try
    LDados := fCriaQuery;
    LDados.SQL.Text := 'SELECT AUTOINCREM, CTP_NUMDUP, CTP_PARCEL, CTP_CODEMP, ' +
                       '  CTP_SERIE_, CTP_CODFOR, CTP_SEQBAI, CTP_EMPBAI, ' +
                       '  CTP_SEQCON, CTP_PORBAI, CTP_SEQRCH  ' +
                       'FROM CADPAG ' +
                       'WHERE CTP_SEQCON = "' + FDatasetMovBan.FieldByName('CTB_PAGCON').AsString + '" ' +
                       '  AND CTP_EMPBAI = "' + FDatasetMovBan.FieldByName('CTB_CODEMP').AsString + '" ';
    LDados.Open;

    While Not LDados.Eof Do
    Begin
      If LDados.FieldByName('CTP_PORBAI').AsString = FDatasetMovBan.FieldByName('CTB_CODPOR').AsString Then
      Begin
        LDados.Edit;
        LDados.FieldByName('CTP_PORBAI').AsString := FNovoPortador;
        LDados.Post;
      End;

      AtualizarChequesEmitidosCTP(LDados);

      untLogCtp.GravaLogCtp(LDados.FieldByName('AUTOINCREM').AsString,
                            'ALTERAÇÃO DE PORTADOR DA BAIXA',
                            'frmCadMovBancario');

      LDados.Next;
    End;

    AtualizarChequesRepassadosCTP(LDados.FieldByName('CTP_SEQRCH').AsString,
                                  LDados.FieldByName('CTP_EMPBAI').AsString);

    FDatasetMovBan.Edit;
    FDatasetMovBan.FieldByName('CTB_CODPOR').AsString := FNovoPortador;
    FDatasetMovBan.Post;

    GravaLogCba;

    Result := fCommit;

    FreeAndNil(LDados);
  Except
    On E: Exception Do
    Begin
      fRollBack;

      pMensagensErro('Ocorreu um erro ao alterar o Portador de um lançamentos do Contas a Pagar' + #13 +
                     'Erro gerado: ' + E.Message, '[TCadMovBancarioPortador.AtualizaRegistrosBaixaPagar]');
    End;
  End;
end;

function TCadMovBancarioPortador.AtualizaRegistrosBaixaReceber: Boolean;
  Var
    LDados: TUniQuery;
begin
  Result := False;

  fStartTransaction;

  Try
    LDados := fCriaQuery;
    LDados.SQL.Text := 'SELECT AUTOINCREM, CTR_SEQCON, CTR_PORBAI ' +
                       'FROM CADREC ' +
                       'WHERE CTR_DOCBAI = "' + FDatasetMovBan.FieldByName('CTB_SEQLAN').AsString + '" ' +
                       '  AND CTR_EMPBAI = "' + FDatasetMovBan.FieldByName('CTB_CODEMP').AsString + '" ' +
                       '  AND CTR_PORBAI = "' + FDatasetMovBan.FieldByName('CTB_CODPOR').AsString + '" ' ;
    LDados.Open;

    While Not LDados.Eof Do
    Begin
      LDados.Edit;
      LDados.FieldByName('CTR_PORBAI').AsString := FNovoPortador;
      LDados.Post;

      untLogCtr.GravaLogCtr(LDados.FieldByName('AUTOINCREM').AsString,
                            'ALTERAÇÃO DE PORTADOR DA BAIXA',
                            'frmCadMovBancario');

      LDados.Next;
    End;

    AtualizarMovbansJurosEDescontosCTR(LDados.FieldByName('AUTOINCREM').AsString);

    FDatasetMovBan.Edit;
    FDatasetMovBan.FieldByName('CTB_CODPOR').AsString := FNovoPortador;
    FDatasetMovBan.Post;

    GravaLogCba;

    Result := fCommit;

    FreeAndNil(LDados);
  Except
    On E: Exception Do
    Begin
      fRollBack;

      pMensagensErro('Ocorreu um erro ao alterar o Portador de um lançamentos do Contas a Receber' + #13 +
                     'Erro gerado: ' + E.Message, '[TCadMovBancarioPortador.AtualizaRegistrosBaixaReceber]');
    End;
  End;
end;

function TCadMovBancarioPortador.AtualizaRegistrosDepositoCheques: Boolean;
  Var
    LDados: TUniQuery;
begin
  Result := False;

  fStartTransaction;

  Try
    LDados := fCriaQuery;
    LDados.SQL.Text := 'SELECT C.AUTOINCREM, C.CHQ_CODPOR, C.CHQ_PORDEB ' +
                       'FROM BANCHQ BN ' +
                       'JOIN CADCHQ C  ON C.CHQ_CODBCO=BN.CHQ_CODBCO ' +
                       '              AND C.CHQ_NUMAGE=BN.CHQ_NUMAGE ' +
                       '              AND C.CHQ_CONCOR=BN.CHQ_CONCOR ' +
                       '              AND C.CHQ_NUMCHQ=BN.CHQ_NUMCHQ ' +
                       '              AND C.CHQ_CODEMP=BN.CHQ_CODEMP ' +
                       'WHERE BN.CTB_SEQLAN = "' + FDatasetMovBan.FieldByName('CTB_SEQLAN').AsString + '" ' +
                       '  AND C.CHQ_SEQDEP = "' + FDatasetMovBan.FieldByName('CTB_SEQDEP').AsString + '" ';
    LDados.Open;

    While Not LDados.Eof Do
    Begin
      LDados.Edit;

      If FDatasetMovBan.FieldByName('CTB_CREDEB').AsString = 'C' Then
        LDados.FieldByName('CHQ_CODPOR').AsString := FNovoPortador
      Else
        LDados.FieldByName('CHQ_PORDEB').AsString := FNovoPortador;

      LDados.Post;

      untLogChq.GravaLogChq(LDados.FieldByName('AUTOINCREM').AsString,
                            'ALTERAÇÃO DE PORTADOR DO DEPÓSITO/DÉBITO',
                            'frmCadMovBancario');

      LDados.Next;
    End;

    FDatasetMovBan.Edit;
    FDatasetMovBan.FieldByName('CTB_CODPOR').AsString := FNovoPortador;
    FDatasetMovBan.Post;

    GravaLogCba;

    Result := fCommit;

    FreeAndNil(LDados);
  Except
    On E: Exception Do
    Begin
      fRollBack;

      pMensagensErro('Ocorreu um erro ao alterar o Portador de um lançamentos do Contas a Pagar' + #13 +
                     'Erro gerado: ' + E.Message, '[TCadMovBancarioPortador.AtualizaRegistrosBaixaPagar]');
    End;
  End;
end;

procedure TCadMovBancarioPortador.AtualizarMovbansJurosEDescontosCTR(
  AAutoIncremCTR: String);
  Var
    LDados: TUniQuery;
begin
  If Not fCfgSis('JURSEP', varBoolean) Then
    Exit;

  If AAutoIncremCTR.IsEmpty Then
    Exit;

  Try
    LDados := fCriaQuery;
    LDados.SQL.Text := 'SELECT BN.* ' +
                       'FROM MOVBAN BN ' +
                       'WHERE BN.CTB_SEQLAN IN (' +
                       '        SELECT MOV_SEQCTB ' +
                       '        FROM MOVCTR ' +
                       '        WHERE MOV_AUTCTR="' + AAutoIncremCTR + '" ' +
                       '          AND MOV_SEQCTB<>"' + FDatasetMovBan.FieldByName('CTB_SEQLAN').AsString + '")';
    LDados.Open;

    While Not LDados.Eof Do
    Begin
      LDados.Edit;
      LDados.FieldByName('CTB_CODPOR').AsString := FNovoPortador;
      LDados.Post;

      GravaLogCba(LDados.FieldByName('AUTOINCREM').AsString);

      LDados.Next;
    End;

    FreeAndNil(LDados);
  Except
    On E: Exception Do
    Begin
      fRollBack;

      pMensagensErro('Ocorreu um erro ao alterar o Portador de um lançamentos do Movban de Juros/Descontos' + #13 +
                     'Erro gerado: ' + E.Message, '[TCadMovBancarioPortador.AtualizarMovbansJurosEDescontosCTR]');
    End;
  End;
end;

procedure TCadMovBancarioPortador.AtualizarMovBansTaxasEAntecipacoes(
  ATipoBaixa: TTipoMovimentacaoBancariaCartoes; ADadosMovCar: TDataset);
begin
  If ATipoBaixa = tpmbcBaixaTaxa Then
  Begin
    If ADadosMovCar.FieldByName('MCA_DOCANT').AsString.IsEmpty Then
      Exit;

    fExecutaSQL('UPDATE MOVBAN SET CTB_CODPOR="' + FNovoPortador + '"' +
                'WHERE CTB_SEQLAN="' + ADadosMovCar.FieldByName('MCA_DOCANT').AsString + '"', True);

    GravaLogCBA(fCampoTabela('AUTOINCREM', 'MOVBAN', ['CTB_SEQLAN'],[ADadosMovCar.FieldByName('MCA_DOCANT').AsString]));
  End
  Else If ATipoBaixa = tpmbcBaixaTaxaAntecipacao then
  Begin
    fExecutaSQL('UPDATE MOVBAN SET CTB_CODPOR="' + FNovoPortador + '"' +
                'WHERE CTB_SEQLAN="' + ADadosMovCar.FieldByName('MCA_DOCBTX').AsString + '"', True);

    GravaLogCBA(fCampoTabela('AUTOINCREM', 'MOVBAN', ['CTB_SEQLAN'],[ADadosMovCar.FieldByName('MCA_DOCBTX').AsString]));
  End;
end;

constructor TCadMovBancarioPortador.Create(ASeqLanRegistro: String);
begin
  FSeqLanRegistro := ASeqLanRegistro;

  FDatasetMovBan := fCriaQuery;
  FDatasetMovBan.SQL.Text := 'SELECT * FROM MOVBAN WHERE CTB_SEQLAN = "' + FSeqLanRegistro + '"';
  FDatasetMovBan.Open;

  FDatasetBanChq := fCriaQuery;
  FDatasetBanChq.SQL.Text := 'SELECT * FROM BANCHQ WHERE CTB_SEQLAN = "' + FSeqLanRegistro + '"';
  FDatasetBanChq.Open;
end;

destructor TCadMovBancarioPortador.Destroy;
begin
  inherited;

  FreeAndNil(FDatasetMovBan);
  FreeAndNil(FDatasetBanChq);
end;

procedure TCadMovBancarioPortador.GravaLogCBA(AAutoIncrem: String = '');
begin
  Try
    If AAutoIncrem = EmptyStr Then
      AAutoIncrem := FDatasetMovBan.FieldByName('AUTOINCREM').AsString;

    untLogCba.GravaLogCba(AAutoIncrem,
                          'ALTERAÇÃO DE PORTADOR',
                          'frmCadMovBancario');
  Except
    On E: Exception Do
      Raise;
  End;
end;

function TCadMovBancarioPortador.RetornaCampoFiltroCartao(
  ATipoBaixa: TTipoMovimentacaoBancariaCartoes; ATipoCampo: String): String;
begin
  Result := EmptyStr;

  If ATipoCampo = 'SEQLAN' Then
  Begin
    Case ATipoBaixa Of
      tpmbcBaixaCredito: Result := 'MCA_DOCBAN';
      tpmbcBaixaTaxa: Result := 'MCA_DOCBTX';
      tpmbcBaixaDebito: Result := 'MCA_DOCDEB';
      tpmbcBaixaTaxaAntecipacao: Result := 'MCA_DOCANT';
    End;
  End
  Else If ATipoCampo = 'CODPOR' Then
  Begin
    Case ATipoBaixa Of
      tpmbcBaixaCredito: Result := 'MCA_PORBAI';
      tpmbcBaixaTaxa: Result := 'MCA_PORBTX';
      tpmbcBaixaDebito: Result := 'MCA_PORDEB';
      tpmbcBaixaTaxaAntecipacao: Result := 'MCA_PORBTX';
    End;
  End;

  If Result = EmptyStr Then
    Raise Exception.Create('Não foi possível determinar o tipo de lançamento da Movimentação bancária da Baixa de Cartões');
end;

function TCadMovBancarioPortador.RetornaTipoDeBaixaCartao(
  ASequencialMovBan: String): TTipoMovimentacaoBancariaCartoes;
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT ' +
                          '  CASE ' +
                          '    WHEN MCA_DOCBAN=:SEQLAN THEN "CREDITO" ' +
                          '    WHEN MCA_DOCBTX=:SEQLAN THEN "TAXA" ' +
                          '    WHEN MCA_DOCDEB=:SEQLAN THEN "DEBITO" ' +
                          '    WHEN MCA_DOCANT=:SEQLAN THEN "ANTECIPACAO" ' +
                          '    ELSE "NENHUM"  ' +
                          '  END AS TIPO ' +
                          'FROM MOVCAR ' +
                          'WHERE MCA_DOCBAN=:SEQLAN ' +
                          '   OR MCA_DOCBTX=:SEQLAN ' +
                          '   OR MCA_DOCDEB=:SEQLAN ' +
                          '   OR MCA_DOCANT=:SEQLAN ' +
                          ' LIMIT 1';

    LConsulta.ParamByName('SEQLAN').AsString := ASequencialMovBan;
    LConsulta.Open;

    Result := tpmbcNenhum;
    If LConsulta.FieldByName('TIPO').AsString = 'CREDITO' Then
      Result := tpmbcBaixaCredito
    Else If LConsulta.FieldByName('TIPO').AsString = 'TAXA' Then
      Result := tpmbcBaixaTaxa
    Else If LConsulta.FieldByName('TIPO').AsString = 'DEBITO' Then
      Result := tpmbcBaixaDebito
    Else If LConsulta.FieldByName('TIPO').AsString = 'ANTECIPACAO' Then
      Result := tpmbcBaixaTaxaAntecipacao;
  Finally
    FreeAndNIl(LConsulta);
  End;
end;

function TCadMovBancarioPortador.RetornaTipoDeBaixaDaMOVBAN: TTipoRegistroMovBan;
begin
  Result := trmNenhum;

  If TipoDeLancamentoContasAReceber Then
    Result := trmBaixaReceber
  Else If TipoDeLancamentoAdiatamentoDeCliente Then
    Result := trmAdiantamentoDeCliente
  Else If TipoDeLancamentoBaixaCartoes Then
    Result := trmBaixaCartoes
  Else If TipoDeLancamentoContasAPagar Then
    Result := trmBaixaPagar
  Else If TipoDeLancamentoDepositoCheques Then
   Result := trmDepositoCheques;
end;

function TCadMovBancarioPortador.TipoDeLancamentoAdiatamentoDeCliente: Boolean;
  Var
    LConsulta: TUniQuery;
begin
  Result := FDatasetMovBan.FieldByName('CTB_ORIGEM').AsString = 'CTR';
  If Not Result Then
    Exit;

  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT AUTOINCREM ' +
                          'FROM ADTCLI ' +
                          'WHERE ADT_NUMDOC="' + FDatasetMovBan.FieldByName('CTB_NUMDOC').AsString + '" ' +
                          '  AND ADT_ESPDOC="PD" ' +
                          '  AND ADT_EMPLAN="' + FDatasetMovBan.FieldByName('CTB_CODEMP').AsString + '" ' +
                          '  AND ADT_CODCLI="' + FDatasetMovBan.FieldByName('CTB_CODCLI').AsString + '" ' +
                          '  AND ADT_CODPOR="' + FDatasetMovBan.FieldByName('CTB_CODPOR').AsString + '" ' +
                          '  AND ADT_TIPLAN="C" ' +
                          '  AND ADT_ESTORN="N" ' +
                          'ORDER BY ADT_DTALAN, ADT_HORLAN ' +
                          'LIMIT 1';
    LConsulta.Open;

    Result := Not LConsulta.IsEmpty;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

function TCadMovBancarioPortador.TipoDeLancamentoBaixaCartoes: Boolean;
  Var
    LConsulta: TUniQuery;
Begin
  Result := FDatasetMovBan.FieldByName('CTB_ORIGEM').AsString = 'MCA';
  If Not Result Then
    Exit;

  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT AUTOINCREM ' +
                          'FROM MOVCAR ' +
                          'WHERE (MCA_DOCBAN="' + FDatasetMovBan.FieldByName('CTB_SEQLAN').AsString + '" OR ' +
                          '       MCA_DOCBTX="' + FDatasetMovBan.FieldByName('CTB_SEQLAN').AsString + '" OR ' +
                          '       MCA_DOCDEB="' + FDatasetMovBan.FieldByName('CTB_SEQLAN').AsString + '" OR ' +
                          '       MCA_DOCBTX="' + FDatasetMovBan.FieldByName('CTB_SEQLAN').AsString + '" OR ' +
                          '       MCA_DOCANT="' + FDatasetMovBan.FieldByName('CTB_SEQLAN').AsString + '") ' +
                          'LIMIT 1';
    LConsulta.Open;

    Result := Not LConsulta.IsEmpty;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

function TCadMovBancarioPortador.TipoDeLancamentoContasAPagar: Boolean;
  Var
    LConsulta: TUniQuery;
Begin
  Result := FDatasetMovBan.FieldByName('CTB_ORIGEM').AsString = 'CTP';
  If Not Result Then
    Exit;

  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT AUTOINCREM ' +
                          'FROM CADPAG ' +
                          'WHERE CTP_SEQCON="' + FDatasetMovBan.FieldByName('CTB_PAGCON').AsString + '" ' +
                          '  AND CTP_EMPBAI="' + FDatasetMovBan.FieldByName('CTB_CODEMP').AsString + '" ' +
                          '  AND CTP_SERIE_<>"CRT" ' +
                          'LIMIT 1';
    LConsulta.Open;

    Result := Not LConsulta.IsEmpty;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

function TCadMovBancarioPortador.TipoDeLancamentoContasAReceber: Boolean;
  Var
    LConsulta: TUniQuery;
begin
  Result := FDatasetMovBan.FieldByName('CTB_ORIGEM').AsString = 'CTR';
  If Not Result Then
    Exit;

  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT AUTOINCREM ' +
                          'FROM CADREC ' +
                          'WHERE CTR_DOCBAI="' + FDatasetMovBan.FieldByName('CTB_SEQLAN').AsString + '" ' +
                          '  AND CTR_EMPBAI="' + FDatasetMovBan.FieldByName('CTB_CODEMP').AsString + '" ' +
                          'LIMIT 1';
    LConsulta.Open;

    Result := Not LConsulta.IsEmpty;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

function TCadMovBancarioPortador.TipoDeLancamentoDepositoCheques: Boolean;
  Var
    LConsulta: TUniQuery;
begin
  Result := FDatasetMovBan.FieldByName('CTB_ORIGEM').AsString = 'CHQ';
  If Not Result Then
    Exit;

  Result := Not FDatasetMovBan.FieldByName('CTB_SEQDEP').AsString.IsEmpty;
  If Not Result Then
    Exit;

  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT C.AUTOINCREM ' +
                          'FROM BANCHQ BN ' +
                          'JOIN CADCHQ C ON C.CHQ_CODBCO=BN.CHQ_CODBCO ' +
                          '             AND C.CHQ_NUMAGE=BN.CHQ_NUMAGE ' +
                          '             AND C.CHQ_CONCOR=BN.CHQ_CONCOR ' +
                          '             AND C.CHQ_NUMCHQ=BN.CHQ_NUMCHQ ' +
                          '             AND C.CHQ_CODEMP=BN.CHQ_CODEMP ' +
                          'WHERE BN.CTB_SEQLAN=:SEQLAN ' +
                          '  AND C.CHQ_SEQDEP=:SEQDEP ' +
                          'LIMIT 1';

    LConsulta.ParamByName('SEQLAN').AsString := FDatasetMovBan.FieldByName('CTB_SEQLAN').AsString;
    LConsulta.ParamByName('SEQDEP').AsString := FDatasetMovBan.FieldByName('CTB_SEQDEP').AsString;

    LConsulta.Open;

    Result := Not LConsulta.IsEmpty;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

end.
