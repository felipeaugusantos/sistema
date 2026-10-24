unit untConsultas;

interface

uses cxGridCustomTableView,
     untFuncoesConsulta,
     cxGridDBTableView,
     untClassPanelCx,
     untTypesSistema,
     MaskEditFocus,
     cxCustomData,
     Vcl.StdCtrls,
     Vcl.Graphics,
     untFuncoes,
     Vcl.Forms,
     EditFocus,
     MaskUtils,
     SysUtils,
     Variants,
     cxStyles,
     StrUtils,
     Data.DB,
     Uni;

type
  TDefConsultaPortadores = class(TDefConsulta)
  private
    cxsPorOpe: TcxStyle;
  public
    function fGetCellStyle(AView: TcxGridDBTableView; ARecord: TcxCustomGridRecord;
    AItem: TcxCustomGridTableItem; ADataSet: TDataSet): TcxStyle; override;

    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

  TDefMascaraCentroCusto = Class(TDefConsulta)
  private
    cxsGrupos: TcxStyle;

    procedure pDisplayCodigo(Sender: TcxCustomGridTableItem;
                             ARecord: TcxCustomGridRecord;
                             var AText: string);
  public
    function fGetCellStyle(AView: TcxGridDBTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; ADataSet: TDataSet): TcxStyle; override;

    constructor Create; reintroduce;
    destructor Destroy; override;
  End;

  function fPesqEmpresa(opcTipCon: TTipoConsultaEmpresa;
                        Self     : TForm;                           {* Formulário                                  *}
                        edtCodigo: TCustomEdit;                     {* Edit do Código                              *}
                        edtNomEmp: TEditFocus;                      {* Edit do Nome da Empresa                     *}
                        qryTabela: TUniQuery;                       {* Query                                       *}
                        Var chrKey: Char;                           {* Key                                         *}
                        Var arrSel: TConsultasArray;                {* Array de Seleção                            *}
                        blnConSim: Boolean = True;                  {* Consulta Simples ou Múltipla (multi select) *}
                        blnResEmp: Boolean = False;                 {* Restringir empresas que usuário tem acesso  *}
                        strEmpresas: String = '';                   {* Empresas                                    *}
                        blnAceCtr: Boolean = False;                 {* Verifica se filtrará as empresas que o usuário tem acesso na Baixa de Contas a Receber *}
                        strAceCtr: String = ''): Boolean;           {* Empresas que o usuário possui acesso na Baixa de Contas a Receber        *}

  function fPesqPortador(opcTipPor: TTipoConsultaSimples;
                         Self     : TForm;                       {* Formulário                                  *}
                         edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                         edtDesPor: TEditFocus;                  {* Edit da Descrição do item                   *}
                         qryTabela: TUniQuery;                   {* Query                                       *}
                         Var chrKey: Char;                       {* Key                                         *}
                         Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                         blnConSim: Boolean = True;              {* Consulta Simples ou Múltipla (multi select) *}
                         strTitulo: String = 'Consulta de Portadores';
                         strBolFat: String = '';                 {* Boleto no Faturamento                       *}
                         blnSalPor: Boolean = False): Boolean;   {* Entra no Relatório Saldo Portador           *}

  function fPesqCentroCusto(Self     : TForm;                       {* Formulário                                         *}
                            edtCodigo: TCustomEdit;                 {* Edit do Código                                     *}
                            edtDescri: TEditFocus;                  {* Edit da Descrição                                  *}
                            qryTabela: TUniQuery;                   {* Query                                              *}
                            Var chrKey: Char;                       {* Key                                                *}
                            Var arrSel: TConsultasArray;            {* Array de Seleção                                   *}
                            blnConSim: Boolean = True;              {* Consulta Simples ou Múltipla (multi select)        *}
                            blnUsaCtf: Boolean = False;             {* Só mostra os Plano de Contas vinculados do CADFOR *}
                            strCodFor: String  = ''): Boolean;      {* Código da empresa se blnUsaCtf = True              *}

  function fPesqCFOP(Self     : TForm;                              {* Formulário                                  *}
                     edtCodigo: TCustomEdit;                        {* Edit do Código                              *}
                     edtDescri: TEditFocus;                         {* Edit da Descrição                           *}
                     qryTabela: TUniQuery;                          {* Query                                       *}
                     Var chrKey: Char;                              {* Key                                         *}
                     Var arrSel: TConsultasArray;                   {* Array de Seleção                            *}
                     blnConSim: Boolean = True;                     {* Consulta Simples ou Múltipla (multi select) *}
                     strFiltro: String = ''): Boolean;              {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqProduto(Self     : TForm;                              {* Formulário                                  *}
                        edtCodigo: TCustomEdit;                        {* Edit do Código                              *}
                        edtDescri: TEditFocus;                         {* Edit da Descrição                           *}
                        qryTabela: TUniQuery;                          {* Query                                       *}
                        Var chrKey: Char;                              {* Key                                         *}
                        Var arrSel: TConsultasArray;                   {* Array de Seleção                            *}
                        blnConSim: Boolean = True;                     {* Consulta Simples ou Múltipla (multi select) *}
                        strFiltro: String = ''): Boolean;              {* Consulta Simples ou Múltipla (multi select) *}

implementation

function fPesqEmpresa(opcTipCon: TTipoConsultaEmpresa;
                      Self     : TForm;                           {* Formulário                                  *}
                      edtCodigo: TCustomEdit;                     {* Edit do Código                              *}
                      edtNomEmp: TEditFocus;                      {* Edit do Nome da Empresa                     *}
                      qryTabela: TUniQuery;                       {* Query                                       *}
                      Var chrKey: Char;                           {* Key                                         *}
                      Var arrSel: TConsultasArray;                {* Array de Seleção                            *}
                      blnConSim: Boolean = True;                  {* Consulta Simples ou Múltipla (multi select) *}
                      blnResEmp: Boolean = False;                 {* Restringir empresas que usuário tem acesso  *}
                      strEmpresas: String = '';                   {* Empresas                                    *}
                      blnAceCtr: Boolean = False;                 {* Verifica se filtrará as empresas que o usuário tem acesso na Baixa de Contas a Receber *}
                      strAceCtr: String = ''): Boolean;           {* Empresas que o usuário possui acesso na Baixa de Contas a Receber        *}
  Var
    qryConsulta: TUniQuery;
    strSQL: String;                             {* SQL da Query                                *}
    strWhere: String;
    arrTitCol: TColunasArray;                   {* Títulos das Colunas                         *}
    objConsulta: TDefConsulta;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      objConsulta := TDefConsulta.Create;
      objConsulta.pIncluiCamposCNPJ(['EMP_C_G_C_']);

      strWhere := '';

      case opcTipCon Of
        conEmpSimples: Begin
                         strSQL := '';
                         strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
                         strSQL := strSQL + '  EMP_CODEMP,       ';
                         strSQL := strSQL + '  EMP_NOMEMP,       ';
                         strSQL := strSQL + '  EMP_NOMFAN,       ';
                         strSQL := strSQL + '  AUTOINCREM        ';
                         strSQL := strSQL + 'FROM                ';
                         strSQL := strSQL + '  CADEMP            ';

                         strWhere := strWhere + 'WHERE TRUE ';

                         If blnResEmp Then
                         Begin
                           If blnAceCtr Then
                             strWhere := strWhere + ' OR LOCATE(EMP_CODEMP,' + QuotedStr(strAceCtr) + ') > 0 ';

                           strWhere := strWhere + ')';
                         End;

                         If (Not fEmptyStr(strEmpresas)) Then
                           strWhere := strWhere + ' AND LOCATE(EMP_CODEMP,' + QuotedStr(strEmpresas) + ') > 0 ';

                         {***************************************}
                         {* TÍTULO DA COLUNA E MÁSCARA DO CAMPO *}
                         {************************************RV*}
                         SetLength(arrTitCol, 3);
                         arrTitCol[00] := 'Código';
                         arrTitCol[01] := 'Razão Social';
                         arrTitCol[02] := 'Nome Fantasia';
                       End;

         conEmpCompleta: Begin
                           strSQL := '';
                           strSQL := strSQL + 'SELECT          ';
                           strSQL := strSQL + '  E.EMP_CODEMP, ';
                           strSQL := strSQL + '  E.EMP_NOMEMP, ';
                           strSQL := strSQL + '  E.EMP_NOMFAN, ';
                           strSQL := strSQL + '  E.EMP_ENDERE, ';
                           strSQL := strSQL + '  E.EMP_ENDNUM, ';
                           strSQL := strSQL + '  E.EMP_BAIRRO, ';
                           strSQL := strSQL + '  C.CID_NOMCID, ';
                           strSQL := strSQL + '  C.CID_ESTADO, ';
                           strSQL := strSQL + '  E.EMP_CONTAT, ';
                           strSQL := strSQL + '  E.EMP_C_G_C_, ';
                           strSQL := strSQL + '  E.EMP_I_E_S_, ';
                           strSQL := strSQL + '  E.AUTOINCREM  ';
                           strSQL := strSQL + 'FROM            ';
                           strSQL := strSQL + '  CADEMP E      ';
                           strSQL := strSQL + '  LEFT JOIN CADCID C ON E.EMP_CODCID = C.CID_CODCID ';

                           SetLength(arrTitCol, 11);
                           arrTitCol[00] := 'Código';
                           arrTitCol[01] := 'Razão Social';
                           arrTitCol[02] := 'Nome Fantasia';
                           arrTitCol[03] := 'Endereço';
                           arrTitCol[04] := 'Número';
                           arrTitCol[05] := 'Bairro';
                           arrTitCol[06] := 'Cidade';
                           arrTitCol[07] := 'UF';
                           arrTitCol[08] := 'Contato';
                           arrTitCol[09] := 'CNPJ';
                           arrTitCol[10] := 'Insc. Est.';
                         End;
      end;

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsultaNova([strSQL, strWhere],
                       arrTitCol,
                       ['EMP_NOMEMP','EMP_NOMFAN','EMP_CODEMP'],
                       '',
                       'CADEMP',
                       Self.Name,
                       'Consulta de Empresas',
                       qryConsulta,
                       Nil,
                       blnConSim,
                       arrSel,
                       'EMP_CODEMP',
                       objConsulta) Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('EMP_CODEMP').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('EMP_CODEMP').AsString;
        End;

        If Assigned(edtNomEmp) Then
          edtNomEmp.Text := qryConsulta.FieldByName('EMP_NOMEMP').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 3)
            Else
              edtCodigo.Text := fStrZero('0', 3);
          End;

          If Assigned(edtNomEmp) Then
            edtNomEmp.Text := '+1';

        End;

        Result := True;

        If Not Assigned(qryTabela) Then
          FreeAndNil(qryConsulta);
      End;

      FreeAndNil(objConsulta);

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

function fPesqPortador(opcTipPor: TTipoConsultaSimples;
                       Self     : TForm;                       {* Formulário                                  *}
                       edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                       edtDesPor: TEditFocus;                  {* Edit da Descrição do item                   *}
                       qryTabela: TUniQuery;                   {* Query                                       *}
                       Var chrKey: Char;                       {* Key                                         *}
                       Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                       blnConSim: Boolean = True;              {* Consulta Simples ou Múltipla (multi select) *}
                       strTitulo: String = 'Consulta de Portadores';
                       strBolFat: String = '';                 {* Boleto no Faturamento                       *}
                       blnSalPor: Boolean = False): Boolean;   {* Entra no Relatório Saldo Portador           *}

  Var
    strSQL       : String;
    strWhere     : String;
    qryConsulta  : TUniQuery;
    arrTitCol    : TColunasArray;                                 {* Títulos das Colunas                         *}
    dfmPortadores: TDefConsultaPortadores;

    Procedure pAddNomeColuna(strNomCol: String);
    Begin
      SetLength(arrTitCol, Succ(Length(arrTitCol)));
      arrTitCol[High(arrTitCol)] := strNomCol;
    End;

begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      SetLength(arrTitCol, 0);

      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  POR_CODPOR, '; pAddNomeColuna('Código');
      strSQL := strSQL + '  POR_NOMPOR, '; pAddNomeColuna('Nome');
      strSQL := strSQL + '  POR_DTAINI, '; pAddNomeColuna('Data Inicial');
      strSQL := strSQL + '  POR_ENTANA, '; pAddNomeColuna('Entra na Análise');
      strSQL := strSQL + '  POR_ENTFLX, '; pAddNomeColuna('Fluxo de Caixa');
      strSQL := strSQL + '  POR_CTRANA, '; pAddNomeColuna('Entra em Contas a Receber da Análise');
      strSQL := strSQL + '  POR_ENTPCO, '; pAddNomeColuna('Entra na Posição Contábil');
      strSQL := strSQL + '  POR_TRANSF, '; pAddNomeColuna('Utilizado para Transferências');
      strSQL := strSQL + '  POR_CONCON, '; pAddNomeColuna('Conta Contábil');
      strSQL := strSQL + '  POR_PERBAI, '; pAddNomeColuna('Permitir Baixa CTP/CTR/CHQ/CAR?');
      strSQL := strSQL + '  POR_MOVBAN, '; pAddNomeColuna('Permitir Movimento Bancário');

      if fCampoExiste('CADPOR', 'POR_SALPOR') then
        strSQL := strSQL + '  POR_SALPOR, '; pAddNomeColuna('Entra no Saldo Por Portador');

      strSQL := strSQL + ' AUTOINCREM ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADPOR ';

      strWhere := '';
      strWhere := strWhere + 'WHERE ';
      strWhere := strWhere + '  POR_CODPOR IS NOT NULL ';

      If Not fEmptyStr(strBolFat) Then
        strWhere := strWhere + ' AND POR_BOLFAT = ' + QuotedStr(strBolFat);

      If (blnSalPor) And (fCampoExiste('CADPOR', 'POR_SALPOR')) Then
        strWhere := strWhere + ' AND POR_SALPOR = "S" ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If (blnConSim) Then
        dfmPortadores := TDefConsultaPortadores.Create
      Else
        dfmPortadores := Nil;

      if fConsultaNova([strSQL, strWhere],
                       arrTitCol,
                       ['POR_NOMPOR','POR_CODPOR'],
                       '',
                       'CADPOR',
                       Self.Name,
                       strTitulo,
                       qryConsulta,
                       Nil,
                       blnConSim,
                       arrSel,
                       'POR_CODPOR',
                       dfmPortadores) then
      begin
          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('POR_CODPOR').AsString
            Else
              edtCodigo.Text := qryConsulta.FieldByName('POR_CODPOR').AsString;
          End;

          If Assigned(edtDesPor) Then
            edtDesPor.Text := qryConsulta.FieldByName('POR_NOMPOR').AsString;

          If (Length(arrSel) > 1) Then
          Begin

            If Assigned(edtCodigo) then
            Begin
              If (edtCodigo Is TMaskEditFocus) Then
                (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 5)
              Else
                edtCodigo.Text := fStrZero('0', 5);
            End;

            If Assigned(edtDesPor) Then
              edtDesPor.Text := '+1';

          End;

        Result := True;

        If Not Assigned(qryTabela) Then
          FreeAndNil(qryConsulta);

        If Assigned(dfmPortadores) Then
          FreeAndNil(dfmPortadores);
      end;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End
end;

function fPesqCentroCusto(Self     : TForm;                     {* Formulário                                         *}
                          edtCodigo: TCustomEdit;               {* Edit do Código                                     *}
                          edtDescri: TEditFocus;                {* Edit da Descrição                                  *}
                          qryTabela: TUniQuery;                   {* Query                                              *}
                          Var chrKey: Char;                     {* Key                                                *}
                          Var arrSel: TConsultasArray;          {* Array de Seleção                                   *}
                          blnConSim: Boolean = True;            {* Consulta Simples ou Múltipla (multi select)        *}
                          blnUsaCtf: Boolean = False;           {* Só mostra os Plano de Contas vinculados do CADFOR *}
                          strCodFor: String  = ''): Boolean;    {* Código da empresa se blnUsaCtf = True              *}
  Var
    strSQL     : String;
    strWhere   : String;
    qryConsulta: TUniQuery;
    dfmCentroCusto: TDefMascaraCentroCusto;
    arrTitCol  : TColunasArray; {* Títulos das Colunas  *}

  Procedure pAddNomeColuna(strNomCol: String);
  Begin
    SetLength(arrTitCol, Succ(Length(arrTitCol)));
    arrTitCol[High(arrTitCol)] := strNomCol;
  End;

begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';

      SetLength(arrTitCol, 0);

      strSQL := strSQL + 'SELECT SQL_NO_CACHE  ';
      strSQL := strSQL + '  C.CTA_CODCTA, '; pAddNomeColuna('Código');
      strSQL := strSQL + '  C.CTA_DESCTA, '; pAddNomeColuna('Descrição');
      strSQL := strSQL + '  C.CTA_TIPCTA, '; pAddNomeColuna('Tipo');
      strSQL := strSQL + '    CTA_CTARES, '; pAddNomeColuna('Cta.Resultado');

      If blnUsaCtf Then
      Begin
        strSQL := strSQL + '    CTA_LINHA_, '; pAddNomeColuna('Linha');
        strSQL := strSQL + '    CTA_GRUPO_, '; pAddNomeColuna('Grupo');
      End;

      strSQL := strSQL + '  C.AUTOINCREM  ';
      strSQL := strSQL + 'FROM            ';
      strSQL := strSQL + '  CADCTA C      ';
      strSQL := strSQL + '  LEFT JOIN CTARES R ON CRE_CODCTA = CTA_CODCTA ';
      strSQL := strSQL + '  LEFT JOIN CTAGER G ON R.CRE_CODCRE = G.CRE_CODCRE ';

      strWhere := '';
      If blnUsaCtf Then
      Begin
        strWhere := strWhere + ' WHERE C.CTA_CODCTA IN (SELECT CTF_CODCTA ';
        strWhere := strWhere + ' FROM CTAFOR ';
        strWhere := strWhere + ' WHERE CTF_CODFOR = ' + QuotedStr(strCodFor);
        strWhere := strWhere + ') ';
        strWhere := strWhere + ' OR R.CRE_CODCTA IN (SELECT CTF_CODCTA ';
        strWhere := strWhere + ' FROM CTAFOR ';
        strWhere := strWhere + ' WHERE CTF_CODFOR = ' + QuotedStr(strCodFor);

        strWhere := strWhere + ')';
      End;

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      dfmCentroCusto := TDefMascaraCentroCusto.Create;
      dfmCentroCusto.pIncluiSubConsulta('CTA_CTARES', 'CONCAT(G.CRE_CODCRE, " - ", CRE_DESCRE)');

      If fConsulta([strSQL, strWhere],
                   arrTitCol,
                   ['CTA_DESCTA','CTA_TIPCTA','CTA_CODCTA'],
                   '',
                   'CADCTA',
                   Self.Name,
                   'Consulta de Plano de Contas',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'CTA_CODCTA',
                   dfmCentroCusto) Then

      Begin
        If Assigned(edtCodigo) then
        Begin
          If edtCodigo.ClassNameIs('TMaskEditFocus') Then
            TMaskEditFocus(edtCodigo).Text := qryConsulta.FieldByName('CTA_CODCTA').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('CTA_CODCTA').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('CTA_DESCTA').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If edtCodigo.ClassNameIs('TMaskEditFocus') Then
              TMaskEditFocus(edtCodigo).Text := '0'
            Else
              edtCodigo.Text := fStrZero('0', 7);
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';

        End;

        Result := True;

        If Not Assigned(qryTabela) Then
          FreeAndNil(qryConsulta);

      End;
      FreeAndNil(dfmCentroCusto);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

function fPesqCFOP(Self     : TForm;                              {* Formulário                                  *}
                   edtCodigo: TCustomEdit;                        {* Edit do Código                              *}
                   edtDescri: TEditFocus;                         {* Edit da Descrição                           *}
                   qryTabela: TUniQuery;                          {* Query                                       *}
                   Var chrKey: Char;                              {* Key                                         *}
                   Var arrSel: TConsultasArray;                   {* Array de Seleção                            *}
                   blnConSim: Boolean = True;                     {* Consulta Simples ou Múltipla (multi select) *}
                   strFiltro: String = ''): Boolean;              {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strWhere,
    strSQL     : String;
    qryConsulta: TUniQuery;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  CFO_CODCFO,       ';
      strSQL := strSQL + '  CFO_NATOPE,       ';
      strSQL := strSQL + '  CFO_DESCR1,       ';
      strSQL := strSQL + '  CFO_DESCR2,       ';
      strSQL := strSQL + '  CFO_DESCR3,       ';
      strSQL := strSQL + '  CFO_DESCR4,       ';
      strSQL := strSQL + '  CFO_DESCR5,       ';
      strSQL := strSQL + '  CFO_PRESTA,       ';
      strSQL := strSQL + '  CFO_MNAT01,       ';
      strSQL := strSQL + '  CFO_MNAT02,       ';
      strSQL := strSQL + '  CFO_MNAT03,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  CADCFO            ';

      strWhere := '';

      If Not fEmptyStr(strFiltro) Then
      Begin
        strWhere := strWhere + ' WHERE ';
        strWhere := strWhere + strFiltro;
      End;

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL, strWhere],
                  ['Código',
                   'Nat. Operação',
                   'Descrição 1',
                   'Descrição 2',
                   'Descrição 3',
                   'Descrição 4',
                   'Descrição 5',
                   'Prest. Serv.'],
                   ['CFO_NATOPE','CFO_DESCR1','CFO_DESCR2','CFO_CODCFO'],
                   '',
                   'CADCFO',
                   Self.Name,
                   'Consulta de CFOP',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'CFO_CODCFO') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('CFO_CODCFO').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('CFO_CODCFO').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('CFO_NATOPE').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 4)
            Else
              edtCodigo.Text := fStrZero('0', 4);
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';

        End;

        Result := True;

        If Not Assigned(qryTabela) Then
          FreeAndNil(qryConsulta);
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

function fPesqProduto(Self     : TForm;                              {* Formulário                                  *}
                      edtCodigo: TCustomEdit;                        {* Edit do Código                              *}
                      edtDescri: TEditFocus;                         {* Edit da Descrição                           *}
                      qryTabela: TUniQuery;                          {* Query                                       *}
                      Var chrKey: Char;                              {* Key                                         *}
                      Var arrSel: TConsultasArray;                   {* Array de Seleção                            *}
                      blnConSim: Boolean = True;                     {* Consulta Simples ou Múltipla (multi select) *}
                      strFiltro: String = ''): Boolean;              {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strWhere,
    strSQL     : String;
    qryConsulta: TUniQuery;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT  ';
      strSQL := strSQL + '  ITE_CODITE,       ';
      strSQL := strSQL + '  ITE_DESITE,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  CADITE            ';

      strWhere := '';

      If Not fEmptyStr(strFiltro) Then
      Begin
        strWhere := strWhere + ' WHERE ';
        strWhere := strWhere + strFiltro;
      End;

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL, strWhere],
                  ['Código', 'Descrição'],
                   ['ITE_CODITE','ITE_DESITE'],
                   '',
                   'CADITE',
                   Self.Name,
                   'Consulta de Produto',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'ITE_CODITE') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('ITE_CODITE').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('ITE_CODITE').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('ITE_DESITE').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 5)
            Else
              edtCodigo.Text := fStrZero('0', 5);
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';

        End;

        Result := True;

        If Not Assigned(qryTabela) Then
          FreeAndNil(qryConsulta);
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

{ TDefConsultaPortadores }

constructor TDefConsultaPortadores.Create;
  Var
    strPorOpe: String;
Begin

  cxsPorOpe := TcxStyle.Create(Nil);
  cxsPorOpe.TextColor := clRed;

  strPorOpe := '';
  strPorOpe := strPorOpe + '  SELECT  ';
  strPorOpe := strPorOpe + '     P.POR_CODPOR      ';
  strPorOpe := strPorOpe + '   FROM                ';
  strPorOpe := strPorOpe + '     CADPOR P          ';

  pIncluiSubConsulta('POR_CODPOR_', strPorOpe);
end;

destructor TDefConsultaPortadores.Destroy;
begin
  FreeAndNil(cxsPorOpe);
  inherited;
end;

function TDefConsultaPortadores.fGetCellStyle(AView: TcxGridDBTableView;
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
  ADataSet: TDataSet): TcxStyle;
  Var
    ARowInfo: TcxRowInfo;

  function fIdxColumn(strCampo: String): Integer;
  begin
    Result := -1;

    If ADataSet.FindField(strCampo) <> nil Then
      Result := AView.GetColumnByFieldName(strCampo).Index;
  end;

  function fGetValor(ColumnIndex: Integer): Variant;
  begin
    Result := null;

    ARowInfo := AView.DataController.GetRowInfo(ARecord.Index);

    With AView, DataController Do
      If ColumnIndex > -1 Then
      Begin
        Result := Values[ARowInfo.RecordIndex, ColumnIndex];
      End;
  end;
begin
  Result := nil;
end;

{ TDefMascaraCentroCusto }

constructor TDefMascaraCentroCusto.Create;
  Var
    strLinha,
    strGrupo: String;
Begin
  Inherited Create;

  cxsGrupos           := TcxStyle.Create(nil);
  cxsGrupos.TextColor := clRed;

  pIncluiDefMascara('CTA_CODCTA', pDisplayCodigo);

  strLinha := '';
  strLinha := strLinha + '  (SELECT SQL_NO_CACHE ';
  strLinha := strLinha + '    CONCAT(LINHAS.CTA_CODCTA, " - ", LINHAS.CTA_DESCTA) ';
  strLinha := strLinha + '  FROM ';
  strLinha := strLinha + '    CADCTA LINHAS ';
  strLinha := strLinha + '  WHERE ';
  strLinha := strLinha + '    LEFT(LINHAS.CTA_CODCTA, 2) = LEFT(C.CTA_CODCTA, 2) AND ';
  strLinha := strLinha + '    RIGHT(LINHAS.CTA_CODCTA, 5) = "00000")';

  strGrupo := '';
  strGrupo := strGrupo + '  (SELECT SQL_NO_CACHE ';
  strGrupo := strGrupo + '    CONCAT(GRUPOS.CTA_CODCTA, " - ", GRUPOS.CTA_DESCTA) ';
  strGrupo := strGrupo + '  FROM ';
  strGrupo := strGrupo + '    CADCTA GRUPOS ';
  strGrupo := strGrupo + '  WHERE ';
  strGrupo := strGrupo + '    LEFT(GRUPOS.CTA_CODCTA, 4) = LEFT(C.CTA_CODCTA, 4) AND ';
  strGrupo := strGrupo + '    RIGHT(GRUPOS.CTA_CODCTA, 3) = "000")';

  pIncluiSubConsulta('CTA_LINHA_', strLinha);
  pIncluiSubConsulta('CTA_GRUPO_', strGrupo);
end;

destructor TDefMascaraCentroCusto.Destroy;
begin
  FreeAndNil(cxsGrupos);
  inherited;
end;

function TDefMascaraCentroCusto.fGetCellStyle(AView: TcxGridDBTableView;
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
  ADataSet: TDataSet): TcxStyle;
  var
    ARowInfo: TcxRowInfo;

  function fIdxColumn(strCampo: string): Integer;
  begin
    Result := -1;

    {********************************************************}
    {* ESSA FUNÇAO TEVE DE ALTERAR O COMPONENTE DEV-EXPRESS *}
    {* SE ESTA OCORRENDO ERRO DE TYPECAST VC DEVE VERIFICAR *}
    {* NOS COMPONENTES SE A CORREÇÃO FOI APLICADA EM SUA    *}
    {* MÁQUINA                                              *}
    {*****************************************************AF*}
    if ADataSet.FindField(strCampo) <> nil then
      if AView.GetColumnByFieldName(strCampo) <> nil then
        Result := AView.GetColumnByFieldName(strCampo).Index;
  end;

  function fGetValor(ColumnIndex: Integer): Variant;
  begin
    Result := null;

    ARowInfo := AView.DataController.GetRowInfo(ARecord.Index);

    with AView, DataController do
      if ColumnIndex > -1 then
      begin
        Result := Values[ARowInfo.RecordIndex, ColumnIndex];
      end;
  end;

begin
  Result := nil;

  if ARecord.IsData and (ARecord.Index > -1) then
  begin
    if fIdxColumn('CTA_CODCTA') > -1 then
      if RightStr(fGetValor(fIdxColumn('CTA_CODCTA')), 3) = '000' then
        Result := cxsGrupos;
  end;
end;

procedure TDefMascaraCentroCusto.pDisplayCodigo(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AText: string);
begin
  AText := FormatMaskText('99.99.999;0;', AText)
end;

end.