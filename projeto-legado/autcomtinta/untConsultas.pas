{********************************}
{* UNIT DE CONSULTAS DO SISTEMA *}
{*****************************RV*}
unit untConsultas;

interface

uses
  Uni, SysUtils, Forms, StdCtrls, EditFocus, MaskEditFocus, untTypesSistema,
  untClassPanelCx, untFuncoesSimples, Variants, UniClientDataSet, DB, Dialogs,
  StrUtils, DBEditFocus, ExtCtrls, cxStyles, Graphics, cxCustomData, System.Generics.Collections,
  Controls, Classes, untICadastros, Windows, BitBtnLockedIncrem;


  function fPesqCidade(Self     : TForm;                            {* Formulário                                  *}
                       edtCodigo: TCustomEdit;                      {* Edit do Código                              *}
                       edtCidade: TEditFocus;                       {* Edit da Cidade                              *}
                       edtEstado: TEditFocus;                       {* Edit do Estado (UF)                         *}
                       qryTabela: TUniQuery;                        {* Query                                       *}
                       Var chrKey: Char;                            {* Key                                         *}
                       Var arrSel: TConsultasArray;                 {* Array de Seleção                            *}
                       blnConSim: Boolean = True): Boolean;         {* Consulta Simples ou Múlti pla (multi select) *}

  function fPesqLoteFat(Self       : TForm;                            {* Formulário                                  *}
                        edtNumLote : TCustomEdit;                      {* Edit do Código                              *}
                        intDecUni  : Integer;                          {* Casas decimais                              *}
                        strCodIte  : String;                           {* Código do produto                           *}
                        blnSalPos  : Boolean;                          {* Boleana                                     *}
                        blnSemADef : Boolean;                          {* Boleana                                     *}
                        qryTabela  : TUniQuery;                        {* Query                                       *}
                        Var chrKey : Char;                             {* Key                                         *}
                        Var arrSel : TConsultasArray;                  {* Array de Seleção                            *}
                        strEmpLot  : String = '';                      {* Empresa do Item para consulta do Lote       *}
                        objFrmPnl  : TPanelCx = Nil;                   {* Painel                                      *}
                        blnConSim  : Boolean = True;                   {* Consulta Simples ou Múltipla (multi select) *}
                        arrNumLot  : TStringArray = Nil;               {* Array com lista de Lotes a serem mostrados  *}
                        blnSoAtivo : Boolean = True;                   {* Mostra somente os Lotes Ativos ou Não       *}
                        blnApenasAprovados : Boolean = False;
                        blnApenasPrincipalVendaOuCheckout: Boolean = False;
                        bnlMovimentacaoProgramada: Boolean = False;
                        blnApenasChapa: Boolean = False;
                        arrLotesAdd: TStringArray = Nil;               {* Lotes já adicionados no Pedido              *}
                        strPicking: String = '';
                        blnSemGarantia : Boolean = False;               {* Boleana, Sem Lote Garantia                  *}
                        blnChamadaViaFaturamento : Boolean = False;
                        blnMostrarLotePickingCheckout : Boolean = False;
                        strEspDoc: String = '';
                        fltValorUnitario: Double = 0;
                        fltSaldoMinimo: Double = 0;
                        blnSemGar: Boolean = False;
                        stlListaNumLotExcluido: String = '';
                        strTabPre: String = '';
                        strEntRet: String = '';
                        blnSomentePicking : Boolean = False;               {* Mostra somente os Lotes PICKING          *}
                        blnNaoExibeLotTransi : Boolean = False):Boolean;  {* Mostra somente os Lotes PICKING             *}




  function fPesqCamsposLayout(Self     : TForm;                         {* Formulário                                  *}
                              edtCodigo: TCustomEdit;                   {* Edit do Código                              *}
                              edtDescri: TEditFocus;                    {* Edit da Descrição                           *}
                              qryTabela: TUniQuery;                       {* Query                                       *}
                              Var chrKey: Char;                         {* Key                                         *}
                              Var arrSel: TConsultasArray;              {* Array de Seleção                            *}
                              strFiltro: String;
                              intPosCam: Integer = -1;
                              blnConSim: Boolean = True): Boolean;      {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqLayout(Self     : TForm;                 {* Formulário                                  *}
                       edtCodigo: TCustomEdit;           {* Edit do Código                              *}
                       edtDescri: TEditFocus;            {* Edit da Descrição                           *}
                       qryTabela: TUniQuery;             {* Query                                       *}
                       strTipImp: String;                {* JATO / MATRICIAL                            *}
                       Var chrKey: Char;                 {* Key                                         *}
                       Var arrSel: TConsultasArray;      {* Array de Seleção                            *}
                       blnConSim: Boolean = True;        {* Consulta Simples ou Múltipla (multi select) *}
                       strTipLay: String = '';           {* Tipo do Layout                              *}
                       tplTipLay: TTipoLayout = tplDocumentos): Boolean; {* Documento / Etiqueta        *}

  function fPesqLayoutEtiquetaDespacho(Self     : TForm;                         {* Formulário                                  *}
                                      edtCodigo: TCustomEdit;                   {* Edit do Código                              *}
                                      edtDescri: TEditFocus;                    {* Edit da Descrição                           *}
                                      qryTabela: TUniQuery;                     {* Query                                       *}
                                      Var chrKey: Char;                         {* Key                                         *}
                                      Var arrSel: TConsultasArray;              {* Array de Seleção                            *}
                                      blnConSim: Boolean = True): Boolean;      {* Consulta Simples ou Múltipla (multi select) *}




  function fPesqModeloRelatorio(Self     : TForm;                 {* Formulário                                  *}
                                edtCodigo: TCustomEdit;           {* Edit do Código                              *}
                                edtDescri: TEditFocus;            {* Edit da Descrição                           *}
                                qryTabela: TUniQuery;             {* Query                                       *}
                                blnBackup: Boolean;               {* True = Backup                               *}
                                strTipImp: String;
                                Var chrKey: Char;                 {* Key                                         *}
                                Var arrSel: TConsultasArray;      {* Array de Seleção                            *}
                                blnConSim: Boolean = True;
                                strRelBkp: String = ''): Boolean; {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqRelatorio(Self     : TForm;              {* Formulário                                  *}
                          edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                          edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                          qryTabela: TUniQuery;                {* Query                                       *}
                          blnBackup: Boolean;                  {* True = Backup                               *}
                          strTipImp: String;
                          Var chrKey: Char;                    {* Key                                         *}
                          Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                          blnConSim: Boolean = True;           {* Consulta Simples ou Múltipla (multi select) *}
                          strRelBkp: String = ''): Boolean;

  function fPesqTemplateSQL(Self     : TForm;                    {* Formulário                                  *}
                            edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                            edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                            qryTabela: TUniQuery;                {* Query                                       *}
                            Var chrKey: Char;                    {* Key                                         *}
                            Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                            blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}



  function fPesqPesquisa(Self     : TForm;                         {* Formulário                                  *}
                         edtCodigo: TCustomEdit;                   {* Edit do Código                              *}
                         edtDescri: TEditFocus;                    {* Edit da Descrição                           *}
                         qryTabela: TUniQuery;                       {* Query                                       *}
                         Var chrKey: Char;                         {* Key                                         *}
                         Var arrSel: TConsultasArray;              {* Array de Seleção                            *}
                         blnConSim: Boolean = True): Boolean;      {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqMontadora(Self     : TForm;                    {* Formulário                                  *}
                          edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                          edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                          qryTabela: TUniQuery;                  {* Query                                       *}
                          Var chrKey: Char;                    {* Key                                         *}
                          Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                          blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}







  function fPesqGrupo(Self     : TForm;                             {* Formulário                                  *}
                      edtCodigo: TCustomEdit;                       {* Edit do Código                              *}
                      edtDescri: TEditFocus;                        {* Edit da Descrição                           *}
                      qryTabela: TUniQuery;                           {* Query                                       *}
                      Var chrKey: Char;                             {* Key                                         *}
                      Var arrSel: TConsultasArray;                  {* Array de Seleção                            *}
                      blnConSim: Boolean = True;                    {* Consulta Simples ou Múltipla (multi select) *}
                      blnDesRes: Boolean = False): Boolean;         {* Mostrar Descricao Resumida(INDUSTRIAL)      *}


  {*****************************}
  {* CONSULTA DE CLIENTE TABLET*}
  {**************************RV*}




  function fPesqRegiao(Self     : TForm;                            {* Formulário                                  *}
                       edtCodigo: TCustomEdit;                      {* Edit do Código                              *}
                       edtDescri: TEditFocus;                       {* Edit da Descrição                           *}
                       qryTabela: TUniQuery;                          {* Query                                       *}
                       Var chrKey: Char;                            {* Key                                         *}
                       Var arrSel: TConsultasArray;                 {* Array de Seleção                            *}
                       blnConSim: Boolean = True): Boolean;         {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqEfetivacaoDePreco(Self: TForm;              {* Formulário                                  *}
                       edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                       edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                       qryTabela: TUniQuery;                {* Query                                       *}
                       Var chrKey: Char;                    {* Key                                         *}
                       Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                       blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqDic(Self     : TForm;                            {* Formulário                                  *}
                    edtCodigo: TCustomEdit;                      {* Edit do Código                              *}
                    edtDescri: TEditFocus;                       {* Edit da Descrição                           *}
                    qryTabela: TUniQuery;                          {* Query                                       *}
                    Var chrKey: Char;                            {* Key                                         *}
                    Var arrSel: TConsultasArray;                 {* Array de Seleção                            *}
                    blnConSim: Boolean = True): Boolean;         {* Consulta Simples ou Múltipla (multi select) *}


  function fPesqSubRegiao(Self     : TForm;                            {* Formulário                                  *}
                          edtCodigo: TCustomEdit;                      {* Edit do Código                              *}
                          edtDescri: TEditFocus;                       {* Edit da Descrição                           *}
                          qryTabela: TUniQuery;                          {* Query                                       *}
                          Var chrKey: Char;                            {* Key                                         *}
                          Var arrSel: TConsultasArray;                 {* Array de Seleção                            *}
                          blnConSim: Boolean = True): Boolean;         {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqOperador(Self     : TForm;                             {* Formulário                                  *}
                         edtCodigo: TCustomEdit;                               {* Edit do Código                                            *}
                         edtDescri: TEditFocus;                                {* Edit da Descrição                                         *}
                         qryTabela: TUniQuery;                                 {* Query                                                     *}
                         Var chrKey: Char;                                     {* Key                                                       *}
                         Var arrSel: TConsultasArray;                          {* Array de Seleção                                          *}
                         blnConSim: Boolean = True;                            {* Consulta Simples ou Múltipla (multi select)               *}
                         blnAtivos: Boolean = False;                           {* Somente Operadores Ativos                                 *}
                         blnGerentes: Boolean = False;                         {* Somente Operadores Gerentes                               *}
                         blnMecanicos: Boolean = False;                        {* Somente Operadores Mecânicos                              *}
                         blnVenRepre: Boolean = False;                         {* Somente Vendedor Interno/Representante Externo            *}
                         blnCompradores: Boolean = False;                      {* Somente Compradores                                       *}
                         blnAdministrativo: Boolean = False;                   {* Somente Operadores Administrativos                        *}
                         blnSubGerentes: Boolean = False;
                         blnVendedorEmpLog: Boolean = False;                   {* Somente vendedor da empresa logada                        *}
                         blnPermissaoTransferencia: Boolean = False;           {* Somente Operadores com permissão de receber transferencia *}
                         blnPermissaoBalancoColetor: Boolean = False): Boolean;{* Somente Operadores com permissão de balanço de estoque - coletor*}
  function fPesqGrupoAtividade(Self     : TForm;                      {* Formulário                                  *}
                               edtCodigo: TCustomEdit;                {* Edit do Código                              *}
                               edtDescri: TEditFocus;                 {* Edit da Descrição                           *}
                               qryTabela: TUniQuery;                    {* Query                                       *}
                               Var chrKey: Char;                      {* Key                                         *}
                               Var arrSel: TConsultasArray;           {* Array de Seleção                            *}
                               blnConSim: Boolean = True): Boolean;   {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqTipoCliente(Self     : TForm;                       {* Formulário                                  *}
                            edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                            edtDescri: TEditFocus;                  {* Edit da Descrição                           *}
                            qryTabela: TUniQuery;                     {* Query                                       *}
                            Var chrKey: Char;                       {* Key                                         *}
                            Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                            blnConSim: Boolean = True): Boolean;    {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqAgendaTelef(Self     : TForm;                       {* Formulário                                  *}
                            edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                            edtDescri: TEditFocus;                  {* Edit da Descrição                           *}
                            qryTabela: TUniQuery;                     {* Query                                       *}
                            Var chrKey: Char;                       {* Key                                         *}
                            Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                            blnConSim: Boolean = True): Boolean;    {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqEnquadramentoIPI(Self     : TForm;                       {* Formulário                                  *}
                                 edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                                 edtDescri: TEditFocus;                  {* Edit da Descrição                           *}
                                 qryTabela: TUniQuery;                   {* Query                                       *}
                                 Var chrKey: Char;                       {* Key                                         *}
                                 Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                                 blnConSim: Boolean = True;              {* Consulta Simples ou Múltipla (multi select) *}
                                 strGrupoCST: String = '*'): Boolean;    {* Grupo do CST desejado - '*' para TODOS      *}


  function fPesqGrupoCompra(Self     : TForm;                       {* Formulário                                  *}
                            edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                            edtDescri: TEditFocus;                  {* Edit da Descrição                           *}
                            qryTabela: TUniQuery;                     {* Query                                       *}
                            Var chrKey: Char;                       {* Key                                         *}
                            Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                            blnConSim: Boolean = True): Boolean;    {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqGrupoUnidade(Self     : TForm;                       {* Formulário                                  *}
                             edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                             edtDescri: TEditFocus;                  {* Edit da Descrição                           *}
                             qryTabela: TUniQuery;                   {* Query                                       *}
                             Var chrKey: Char;                       {* Key                                         *}
                             Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                             blnConSim: Boolean = True): Boolean;    {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqKmRodadoVeic(Self     : TForm;                      {* Formulário                                  *}
                             edtCodigo: TCustomEdit;                {* Edit do Código                              *}
                             edtDescri: TEditFocus;                 {* Edit da Descrição                           *}
                             qryTabela: TUniQuery;                    {* Query                                       *}
                             Var chrKey: Char;                      {* Key                                         *}
                             Var arrSel: TConsultasArray;           {* Array de Seleção                            *}
                             blnConSim: Boolean = True): Boolean;   {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqCotacaoMoeda(Self     : TForm;                      {* Formulário                                  *}
                             edtCodigo: TCustomEdit;                {* Edit do Código                              *}
                             edtDescri: TEditFocus;                 {* Edit da Descrição                           *}
                             qryTabela: TUniQuery;                  {* Query                                       *}
                             Var chrKey: Char): Boolean;

  function fPesqEmitCheques(Self     : TForm;                       {* Formulário                                  *}
                            edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                            edtDescri: TEditFocus;                  {* Edit da Descrição                           *}
                            qryTabela: TUniQuery;                     {* Query                                       *}
                            Var chrKey: Char;                       {* Key                                         *}
                            Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                            blnConSim: Boolean = True): Boolean;    {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqGrupoOperador(Self     : TForm;                     {* Formulário                                  *}
                              edtCodigo: TCustomEdit;               {* Edit do Código                              *}
                              edtDescri: TEditFocus;                {* Edit da Descrição                           *}
                              qryTabela: TUniQuery;                   {* Query                                       *}
                              Var chrKey: Char;                     {* Key                                         *}
                              Var arrSel: TConsultasArray;          {* Array de Seleção                            *}
                              blnConSim: Boolean = True): Boolean;  {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqFeriados(Self     : TForm;                          {* Formulário                                  *}
                         edtCodigo: TCustomEdit;                    {* Edit do Código                              *}
                         edtDescri: TEditFocus;                     {* Edit da Descrição                           *}
                         qryTabela: TUniQuery;                        {* Query                                       *}
                         Var chrKey: Char): Boolean;                {* Key                                         *}

  function fPesqIrregFiscal(Self     : TForm;                       {* Formulário                                  *}
                            edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                            edtDescri: TEditFocus;                  {* Edit da Descrição                           *}
                            qryTabela: TUniQuery;                     {* Query                                       *}
                            Var chrKey: Char): Boolean;             {* Key                                         *}

  function fPesqVerbas(Self     : TForm;                            {* Formulário                                  *}
                       edtCodigo: TCustomEdit;                      {* Edit do Código                              *}
                       edtDescri: TEditFocus;                       {* Edit da Descrição                           *}
                       qryTabela: TUniQuery;                          {* Query                                       *}
                       Var chrKey: Char;                            {* Key                                         *}
                       Var arrSel: TConsultasArray;                 {* Array de Seleção                            *}
                       blnConSim: Boolean = True): Boolean;         {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqVerbasCliFor(Self     : TForm;                            {* Formulário                                  *}
                             edtCodigo: TCustomEdit;                      {* Edit do Código                              *}
                             qryTabela: TUniQuery;                        {* Query                                       *}
                             Var chrKey: Char;                            {* Key                                         *}
                             Var arrSel: TConsultasArray;                 {* Array de Seleção                            *}
                             blnConSim: Boolean = True): Boolean;         {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqFidelidade(Self     : TForm;                        {* Formulário                                  *}
                           edtCodigo: TCustomEdit;                  {* Edit do Código                              *}
                           qryTabela: TUniQuery;                      {* Query                                       *}
                           Var chrKey: Char;                        {* Key                                         *}
                           Var arrSel: TConsultasArray;             {* Array de Seleção                            *}
                           blnConSim: Boolean = True): Boolean;     {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqGrupoPrecos(Self     : TForm;                       {* Formulário                                  *}
                            edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                            edtDescri: TEditFocus;                  {* Edit da Descrição                           *}
                            qryTabela: TUniQuery;                   {* Query                                       *}
                            Var chrKey: Char;                       {* Key                                         *}
                            Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                            blnConSim: Boolean = True): Boolean;    {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqMotReprovacao(Self      : TForm;                     {* Formulário                                  *}
                              edtCodigo : TCustomEdit;               {* Edit do Código                              *}
                              edtDescri : TEditFocus;                {* Edit da Descrição                           *}
                              qryTabela : TUniQuery;                 {* Query                                       *}
                              Var chrKey: Char;                     {* Key                                         *}
                              Var arrSel: TConsultasArray;          {* Array de Seleção                            *}
                              blnConSim : Boolean = True): Boolean;  {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqDefeito(Self      : TForm;                     {* Formulário                                  *}
                        edtCodigo : TCustomEdit;               {* Edit do Código                              *}
                        edtDescri : TEditFocus;                {* Edit da Descrição                           *}
                        qryTabela : TUniQuery;                 {* Query                                       *}
                        Var chrKey: Char;                      {* Key                                         *}
                        Var arrSel: TConsultasArray;           {* Array de Seleção                            *}
                        blnConSim : Boolean = True;            {* Consulta Simples ou Múltipla (multi select) *}
                        objFrmPnl : TPanelCx = Nil): Boolean;  {* Painel                                      *}

  function fPesqEquipamento(Self      : TForm;                     {* Formulário                                  *}
                            edtCodigo : TCustomEdit;               {* Edit do Código                              *}
                            edtDescri : TEditFocus;                {* Edit da Descrição                           *}
                            qryTabela : TUniQuery;                 {* Query                                       *}
                            Var chrKey: Char;                      {* Key                                         *}
                            Var arrSel: TConsultasArray;           {* Array de Seleção                            *}
                            blnConSim : Boolean = True): Boolean;  {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqMarcas(Self     : TForm;                            {* Formulário                                  *}
                       edtCodigo: TCustomEdit;                      {* Edit do Código                              *}
                       edtDescri: TEditFocus;                       {* Edit da Descrição                           *}
                       qryTabela: TUniQuery;                          {* Query                                       *}
                       Var chrKey: Char;                            {* Key                                         *}
                       Var arrSel: TConsultasArray;                 {* Array de Seleção                            *}
                       blnConSim: Boolean = True): Boolean;         {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqPos(Self     : TForm;                            {* Formulário                                  *}
                    edtCodigo: TCustomEdit;                      {* Edit do Código                              *}
                    edtDescri: TEditFocus;                       {* Edit da Descrição                           *}
                    qryTabela: TUniQuery;                          {* Query                                       *}
                    Var chrKey: Char;                            {* Key                                         *}
                    Var arrSel: TConsultasArray;                 {* Array de Seleção                            *}
                    blnConSim: Boolean = True): Boolean;         {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqAdquirente(Self     : TForm;                            {* Formulário                                  *}
                           edtCodigo: TCustomEdit;                      {* Edit do Código                              *}
                           edtDescri: TEditFocus;                       {* Edit da Descrição                           *}
                           qryTabela: TUniQuery;                        {* Query                                       *}
                           Var chrKey: Char;                            {* Key                                         *}
                           Var arrSel: TConsultasArray;                 {* Array de Seleção                            *}
                           blnConSim: Boolean = True): Boolean;         {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqMotivoVerbas(Self     : TForm;                    {* Formulário                                  *}
                             edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                             edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                             qryTabela: TUniQuery;                {* Query                                       *}
                             Var chrKey: Char;                    {* Key                                         *}
                             Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                             blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqTabelaPreco(Self     : TForm;                            {* Formulário                                  *}
                            edtCodigo: TCustomEdit;                      {* Edit do Código                              *}
                            edtDescri: TEditFocus;                       {* Edit da Descrição                           *}
                            qryTabela: TUniQuery;                          {* Query                                       *}
                            Var chrKey: Char;                            {* Key                                         *}
                            Var arrSel: TConsultasArray;                 {* Array de Seleção                            *}
                            blnConSim: Boolean = True): Boolean;         {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqServicos(Self     : TForm;                          {* Formulário                                  *}
                         edtCodigo: TCustomEdit;                    {* Edit do Código                              *}
                         edtDescri: TEditFocus;                     {* Edit da Descrição                           *}
                         qryTabela: TUniQuery;                      {* Query                                       *}
                         Var chrKey: Char;                          {* Key                                         *}
                         Var arrSel: TConsultasArray;               {* Array de Seleção                            *}
                         blnConSim: Boolean = True;                 {* Consulta Simples ou Múltipla (multi select) *}
                         blnAutCen: Boolean = False;                {* Se CFG_AUTCEN = "S"                         *}
                         objFrmPnl: TPanelCx = Nil;                 {* Painel exibindo a aplicação                 *}
                         blnCadSer: Boolean = False                 {* Chamou através do cadastro de serviço?      *}
                        ): Boolean;

  function fPesqTipoServico(Self     : TForm;                          {* Formulário                                  *}
                            edtCodigo: TCustomEdit;                    {* Edit do Código                              *}
                            edtDescri: TEditFocus;                     {* Edit da Descrição                           *}
                            qryTabela: TUniQuery;                        {* Query                                       *}
                            Var chrKey: Char;                          {* Key                                         *}
                            Var arrSel: TConsultasArray;               {* Array de Seleção                            *}
                            blnConSim: Boolean = True): Boolean;       {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqStatusServico(Self     : TForm;                          {* Formulário                                  *}
                              edtCodigo: TCustomEdit;                    {* Edit do Código                              *}
                              edtDescri: TEditFocus;                     {* Edit da Descrição                           *}
                              qryTabela: TUniQuery;                        {* Query                                       *}
                              Var chrKey: Char;                          {* Key                                         *}
                              Var arrSel: TConsultasArray;               {* Array de Seleção                            *}
                              blnConSim: Boolean = True): Boolean;       {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqParceiro(Self     : TForm;                          {* Formulário                                  *}
                         edtCodigo: TCustomEdit;                    {* Edit do Código                              *}
                         edtDescri: TEditFocus;                     {* Edit da Descrição                           *}
                         qryTabela: TUniQuery;                        {* Query                                       *}
                         Var chrKey: Char;                          {* Key                                         *}
                         Var arrSel: TConsultasArray;               {* Array de Seleção                            *}
                         blnConSim: Boolean = True): Boolean;       {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqFaixaPeso(Self     : TForm;                         {* Formulário                                  *}
                          edtCodigo: TCustomEdit;                   {* Edit do Código                              *}
                          edtDescri: TEditFocus;                    {* Edit da Descrição                           *}
                          qryTabela: TUniQuery;                       {* Query                                       *}
                          Var chrKey: Char;                         {* Key                                         *}
                          Var arrSel: TConsultasArray;              {* Array de Seleção                            *}
                          blnConSim: Boolean = True): Boolean;      {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqFuncionarios(Self     : TForm;                      {* Formulário                                  *}
                             edtCodigo: TCustomEdit;                {* Edit do Código                              *}
                             edtDescri: TEditFocus;                 {* Edit do Nome do Funcionário                 *}
                             qryTabela: TUniQuery;                  {* Query                                       *}
                             Var chrKey: Char;                      {* Key                                         *}
                             Var arrSel: TConsultasArray;           {* Array de Seleção                            *}
                             blnConSim: Boolean = True;             {* Consulta Simples ou Múltipla (multi select) *}
                             arrEmpresa: TConsultasArray = nil      {* Array da(s) empresa(s) selecionada(s)       *}
                             ;autIncrem: string = ''
                             ): Boolean;                            

  function fPesqCondicoesPgto(Self     : TForm;                     {* Formulário                                  *}
                              edtCodigo: TCustomEdit;               {* Edit do Código                              *}
                              edtDescri: TEditFocus;                {* Edit da Descrição                           *}
                              qryTabela: TUniQuery;                   {* Query                                       *}
                              Var chrKey: Char;                     {* Key                                         *}
                              Var arrSel: TConsultasArray;          {* Array de Seleção                            *}
                              blnConSim: Boolean = True;            {* Consulta Simples ou Múltipla (multi select) *}
                              blnTablet: Boolean = False;
                              opcTipCon: TTipoConsultaCondPagto = conCndSimples;
                              fltMarDoc: Double = 0;
                              fltValDoc: Double = 0;
                              strCodCli: String = '';
                              blnAtivas: Boolean = False;
                              blnFaturamento: Boolean = False;
                              blnIgnMar: Boolean = False): Boolean;


  function fPesqFormaPgto(opcTipPgt: TTipoConsultaFormaPagto;
                          Self     : TForm;                         {* Formulário                                  *}
                          edtCodigo: TCustomEdit;                   {* Edit do Código                              *}
                          edtDescri: TEditFocus;                    {* Edit da Descrição                           *}
                          qryTabela: TUniQuery;                       {* Query                                       *}
                          Var chrKey: Char;                         {* Key                                         *}
                          Var arrSel: TConsultasArray;              {* Array de Seleção                            *}
                          blnConSim: Boolean = True;                {* Consulta Simples ou Múltipla (multi select) *}
                          blnTablet: Boolean = False): Boolean;


  function fPesqAtivoImob(Self     : TForm;                         {* Formulário                                  *}
                          edtCodigo: TCustomEdit;                   {* Edit do Código                              *}
                          edtDescri: TEditFocus;                    {* Edit da Descrição                           *}
                          qryTabela: TUniQuery;                     {* Query                                       *}
                          Var chrKey: Char;                         {* Key                                         *}
                          Var arrSel: TConsultasArray;              {* Array de Seleção                            *}
                          blnConSim: Boolean = True): Boolean;      {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqDiversos(Self        : TForm;                       {* Formulário                                  *}
                         edtCodigo   : TCustomEdit;                 {* Edit do Código                              *}
                         edtDescri   : TEditFocus;                  {* Edit da Descrição                           *}
                         qryTabela   : TUniQuery;                   {* Query                                       *}
                         Var chrKey  : Char;                        {* Key                                         *}
                         Var arrSel  : TConsultasArray;             {* Array de Seleção                            *}
                         blnConSim   : Boolean = True;              {* Consulta Simples ou Múltipla (multi select) *}
                         blnVerStatus: Boolean = False;
                         blnVerEmpAce: Boolean = False;
                         strCodCli   : String  = ''): Boolean;      {* Verifica Status (Ativo Sim ou Não)          *}

  function fPesqContratos(Self     : TForm;                         {* Formulário                                  *}
                          edtCodigo: TCustomEdit;                   {* Edit do Código                              *}
                          edtDescri: TEditFocus;                    {* Edit da Descrição                           *}
                          qryTabela: TUniQuery;                       {* Query                                       *}
                          Var chrKey: Char;                         {* Key                                         *}
                          Var arrSel: TConsultasArray;              {* Array de Seleção                            *}
                          blnConSim: Boolean = True;
                          strCodCli: String = ''): Boolean;

  function fPesqMovtoCartao(Self     : TForm;                       {* Formulário                                  *}
                            edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                            qryTabela: TUniQuery;                     {* Query                                       *}
                            Var chrKey: Char;                       {* Key                                         *}
                            Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                            blnConSim: Boolean = True;              {* Consulta Simples ou Múltipla (multi select) *}
                            intOpcao: Integer = 1): Boolean;        {* Tipo - 1 = Todos 2 = Baixados 3 = Abertos   *}

  function fPesqMotorista(Self     : TForm;                         {* Formulário                                  *}
                          edtCodigo: TCustomEdit;                   {* Edit do Código                              *}
                          edtDescri: TEditFocus;                    {* Edit da Descrição                           *}
                          qryTabela: TUniQuery;                     {* Query                                       *}
                          Var chrKey: Char;                         {* Key                                         *}
                          Var arrSel: TConsultasArray;              {* Array de Seleção                            *}
                          blnConSim: Boolean = True;                {* Consulta Simples ou Múltipla (multi select) *}
                          blnAtivos: Boolean = False): Boolean;     {* Apenas com status ativo                     *}

  function fPesqECF(Self     : TForm;                               {* Formulário                                  *}
                    edtCodigo: TCustomEdit;                         {* Edit do Código                              *}
                    edtDescri: TEditFocus;                          {* Edit da Descrição                           *}
                    qryTabela: TUniQuery;                           {* Query                                       *}
                    Var chrKey: Char;                               {* Key                                         *}
                    Var arrSel: TConsultasArray;                    {* Array de Seleção                            *}
                    blnConSim: Boolean = True): Boolean;            {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqSetFlz(Self     : TForm;                            {* Formulário                                  *}
                       edtCodigo: TCustomEdit;                      {* Edit do Código                              *}
                       edtDescri: TEditFocus;                       {* Edit da Descrição                           *}
                       qryTabela: TUniQuery;                          {* Query                                       *}
                       Var chrKey: Char;                            {* Key                                         *}
                       Var arrSel: TConsultasArray;                 {* Array de Seleção                            *}
                       blnConSim: Boolean = True): Boolean;         {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqOcorrencia(Self     : TForm;                        {* Formulário                                  *}
                           edtCodigo: TCustomEdit;                  {* Edit do Código                              *}
                           edtDescri: TEditFocus;                   {* Edit da Descrição                           *}
                           qryTabela: TUniQuery;                      {* Query                                       *}
                           Var chrKey: Char;                        {* Key                                         *}
                           Var arrSel: TConsultasArray;             {* Array de Seleção                            *}
                           blnConSim: Boolean = True): Boolean;     {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqSitTributaria(Self     : TForm;                     {* Formulário                                  *}
                              edtCodigo: TCustomEdit;               {* Edit do Código                              *}
                              edtDescri: TEditFocus;                {* Edit da Descrição                           *}
                              qryTabela: TUniQuery;                   {* Query                                       *}
                              Var chrKey: Char;                     {* Key                                         *}
                              Var arrSel: TConsultasArray;          {* Array de Seleção                            *}
                              blnConSim: Boolean = True): Boolean;  {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqProtocoloCancelamento(Self     : TForm;                     {* Formulário                                  *}
                                      qryTabela: TUniQuery;                 {* Query                                       *}
                                      Var chrKey: Char;                     {* Key                                         *}
                                      Var arrSel: TConsultasArray;          {* Array de Seleção                            *}
                                      blnConSim: Boolean = True;            {* Consulta Simples ou Múltipla (multi select) *}
                                      strEspSel : String = ''): Boolean;

  function fPesqVeiculos(Self     : TForm;                          {* Formulário                                  *}
                         edtCodigo: TCustomEdit;                    {* Edit do Código                              *}
                         edtDescri: TEditFocus;                     {* Edit da Descrição                           *}
                         qryTabela: TUniQuery;                      {* Query                                       *}
                         Var chrKey: Char;                          {* Key                                         *}
                         Var arrSel: TConsultasArray;               {* Array de Seleção                            *}
                         blnConSim: Boolean = True;                 {* Consulta Simples ou Múltipla (multi select) *}
                         blnComMsk: Boolean = True;                 {* Com máscara (XXX-9999)                      *}
                         strFiltro: String = ''): Boolean;          {* Filtro para apesquisa                       *}

  function fPesqModeloVeiculo(Self     : TForm;                             {* Formulário                                  *}
                              edtCodigo: TCustomEdit;                       {* Edit do Código                              *}
                              edtDescri: TEditFocus;                        {* Edit da Descrição                           *}
                              qryTabela: TUniQuery;                           {* Query                                       *}
                              Var chrKey: Char;                             {* Key                                         *}
                              Var arrSel: TConsultasArray;                  {* Array de Seleção                            *}
                              blnConSim: Boolean = True;                    {* Consulta Simples ou Múltipla (multi select) *}
                              strCodMar: String = ''): Boolean;             {* Marca do modelo de veículo                  *}

  function fPesqMarcaVeiculo(Self     : TForm;                             {* Formulário                                  *}
                             edtCodigo: TCustomEdit;                       {* Edit do Código                              *}
                             edtDescri: TEditFocus;                        {* Edit da Descrição                           *}
                             qryTabela: TUniQuery;                           {* Query                                       *}
                             Var chrKey: Char;                             {* Key                                         *}
                             Var arrSel: TConsultasArray;                  {* Array de Seleção                            *}
                             blnConSim: Boolean = True): Boolean;          {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqCorVeiculo(Self     : TForm;                             {* Formulário                                  *}
                           edtCodigo: TCustomEdit;                       {* Edit do Código                              *}
                           edtDescri: TEditFocus;                        {* Edit da Descrição                           *}
                           qryTabela: TUniQuery;                           {* Query                                       *}
                           Var chrKey: Char;                             {* Key                                         *}
                           Var arrSel: TConsultasArray;                  {* Array de Seleção                            *}
                           blnConSim: Boolean = True): Boolean;          {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqProCod(Self     : TForm;                            {* Formulário                                  *}
                       edtCodigo: TCustomEdit;                      {* Edit do Código                              *}
                       qryTabela: TUniQuery;                          {* Query                                       *}
                       Var chrKey: Char): Boolean;                  {* Key                                         *}

  function fPesqEmpresa(opcTipCon: TTipoConsultaEmpresa;
                        Self     : TForm;                           {* Formulário                                  *}
                        edtCodigo: TCustomEdit;                     {* Edit do Código                              *}
                        edtNomEmp: TEditFocus;                      {* Edit do Nome da Empresa                     *}
                        qryTabela: TUniQuery;                         {* Query                                       *}
                        Var chrKey: Char;                           {* Key                                         *}
                        Var arrSel: TConsultasArray;                {* Array de Seleção                            *}
                        blnConSim: Boolean = True;                  {* Consulta Simples ou Múltipla (multi select) *}
                        blnResEmp: Boolean = False;                 {* Restringir empresas que usuário tem acesso  *}
                        strEmpresas: String = '';                   {* Empresas                                    *}
                        blnAceCtr: Boolean = False;                 {* Verifica se filtrará as empresas que o usuário tem acesso na Baixa de Contas a Receber *}
                        strAceCtr: String = '';                     {* Empresas que o usuário possui acesso na Baixa de Contas a Receber        *}
                        strConcil: String  = ''): Boolean;          {* Condição da Conciliação de Cartões          *}

  function fPesqFornecedor(opcConFor: TTipoConsultaFornecedor;
                           Self     : TForm;                        {* Formulário                                  *}
                           edtCodigo: TCustomEdit;                  {* Edit do Código                              *}
                           edtNomEmp: TCustomEdit;                  {* Edit do Nome da Empresa                     *}
                           qryTabela: TUniQuery;                    {* Query                                       *}
                           Var chrKey: Char;                        {* Key                                         *}
                           Var arrSel: TConsultasArray;             {* Array de Seleção                            *}
                           blnConSim: Boolean = True;               {* Consulta Simples ou Múltipla (multi select) *}
                           objFrmPnl: TPanelCx = Nil;
                           strWhere : String = ''):Boolean;


  function fPesqItem(opcTipIte: TTipoConsultaItem;
                     Self     : TForm;                         {* Formulário                                  *}
                     edtCodigo: TCustomEdit;                   {* Edit do Código                              *}
                     edtDesIte: TCustomEdit;                   {* Edit da Descrição do item                   *}
                     qryTabela: TUniQuery;                       {* Query                                       *}
                     Var chrKey: Char;                         {* Key                                         *}
                     Var arrSel: TConsultasArray;              {* Array de Seleção                            *}
                     blnConSim: Boolean = True;                {* Consulta Simples ou Múltipla (multi select) *}
                     objFrmPnl: TPanelCx = Nil;                {* Painel                                      *}
                     strTitulo: string = 'Consulta de Itens';
                     strTabPre: String = '1';
                     strConPag: String = '';
                     fltTaxVpr: Double = 0;
                     blnEmpFat: Boolean = False;
                     blnExiPar: Boolean = False;
                     intOpcAtivos: Integer = 0;
                     opcCodIte: TCodigoRetornoItem = cdrCodIte;
                     strAplica: String = '';
                     blnPedCom: Boolean = False;   {* Se é pedido de compra                        *}
                     strCodCli: String = '';
                     blnMostrarPrecos: Boolean = True;
                     blnTablet: Boolean = False;
                     blnConsiderarExiLis: Boolean = True;
                     strCodCmp: String = '';
                     blnDepMatPriIndustrial: Boolean = False; {Departamento materia prima cadestruturaindustrial}
                     blnDepProAcaIndustrial: Boolean = False; {Departamento produto acabado cadcomposicaoProdAcab}
                     blnDepProEmbIndustrial: Boolean = False; {Departamento produto embalagem cadcomposicaoProdAcab}
                     blnDepProGraIndustrial: Boolean = False; {Departamento produto granel cadestruturaindustrial}
                     blnVeioF11: Boolean = False;
                     blnSomenteAgrotoxico: Boolean = False;
                     blnMostrarItensDeServico: Boolean = False;
                     blnExibeColunaSaldoCD: Boolean = False;
                     strEmp_CD: String = '';
                     fltDescFidelidade: Double = -1;
                     blnFaturamento: Boolean = False;
                     strCodFab: String = '';
                     blnMostraSaldo: Boolean = True;
                     strFiltros: string = '';
                     strCodEmp: String = '';
                     strEmpSaldoMatrizCD: String = '';
                     strDescri: String = '';
                     strCodBar: String = '';
                     strProdutoLocalizar: String = '';
                     blnConfirma: Boolean = True;
                     blnConEquEnt: Boolean = False;
                     blnSomenteEstrutura: Boolean = False;
                     objPnlBanner: TPanelCx = Nil;
                     objPnlPreFiltro: TPanelCx = Nil;
                     strCodCnd: String = '';
                     strNumOrc: String = '';
                     strEspOrc: String = ''): Boolean;

  {*******************************************************}
  {* FUNÇÃO CRIDA PARA CHAMADA DA NOVA CONSULTA DE ITENS *}
  {****************************************************JU*}

  function fPesqPortador(opcTipPor: TTipoConsultaSimples;
                         Self     : TForm;                       {* Formulário                                  *}
                         edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                         edtDesPor: TEditFocus;                  {* Edit da Descrição do item                   *}
                         qryTabela: TUniQuery;                     {* Query                                       *}
                         Var chrKey: Char;                       {* Key                                         *}
                         Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                         blnConSim: Boolean = True;              {* Consulta Simples ou Múltipla (multi select) *}
                         strTitulo: String = 'Consulta de Portadores';
                         strBolFat: String = '';                 {* Boleto no Faturamento                       *}
                         blnSalPor: Boolean = False;             {* Entra no Relatório Saldo Portador           *}
                         blnImpBol: Boolean = False): Boolean;   {* Pesquisa da Impressão de Boletos            *}

  function fPesqUnidade(Self      : TForm;                            {* Formulário                                  *}
                        edtCodigo : TCustomEdit;                      {* Edit do Código                              *}
                        edtUnidade: TEditFocus;                       {* Edit da Unidade                             *}
                        edtSigla  : TEditFocus;                       {* Edit da Sigla da Unidade                    *}
                        qryTabela : TUniQuery;                          {* Query                                       *}
                        Var chrKey: Char;                             {* Key                                         *}
                        Var arrSel: TConsultasArray;                  {* Array de Seleção                            *}
                        blnConSim : Boolean = True;                  {* Consulta Simples ou Múltipla (multi select) *}
                        blnPesqSigla : Boolean = False;
                        blnFiltroCodEmp: Boolean = False;
                        strFiltros: string = ''): Boolean;                    { Passa o filtro no Select com o Código da Empresa *}

  function fPesqTabelaSimplesNacional(Self      : TForm;                            {* Formulário                                  *}
                                      edtCodigo : TCustomEdit;                      {* Edit do Código                              *}
                                      edtDescri : TEditFocus;                       {* Edit da Descrição                           *}
                                      qryTabela : TUniQuery;                        {* Query                                       *}
                                      Var chrKey: Char;                             {* Key                                         *}
                                      Var arrSel: TConsultasArray;                  {* Array de Seleção                            *}
                                      blnConSim : Boolean = True): Boolean;         {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqCadastroEmbarcacoes(Self      : TForm;                            {* Formulário                                  *}
                                    edtCodigo : TCustomEdit;                      {* Edit do Código                              *}
                                    edtDescri : TEditFocus;                       {* Edit da Descrição                           *}
                                    qryTabela : TUniQuery;                        {* Query                                       *}
                                    Var chrKey: Char;                             {* Key                                         *}
                                    Var arrSel: TConsultasArray;                  {* Array de Seleção                            *}
                                    blnConSim : Boolean = True;                   {* Consulta Simples ou Múltipla (multi select) *}
                                    strCodCli : String = ''): Boolean;            {* Código do Cliente *}

  function fPesqCadastroEquipLocacao(Self      : TForm;                            {* Formulário                                  *}
                                     edtCodigo : TCustomEdit;                      {* Edit do Código                              *}
                                     edtDescri : TEditFocus;                       {* Edit da Descrição                           *}
                                     qryTabela : TUniQuery;                        {* Query                                       *}
                                     Var chrKey: Char;                             {* Key                                         *}
                                     Var arrSel: TConsultasArray;                  {* Array de Seleção                            *}
                                     blnConSim : Boolean = True): Boolean;         {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqContratoLocEquip(Self      : TForm;                                {* Formulário     *}
                                 edtCodigo : TCustomEdit;                          {* Edit do Código *}
                                 qryTabela : TUniQuery;                            {* Query          *}
                                 Var chrKey: Char): Boolean;                       {* Key            *}

  function fPesqFreteTransportadora(Self      : TForm;                             {* Formulário                                  *}
                                    edtCodTra : TCustomEdit;                       {* Edit da Transportadora                      *}
                                    edtCodCid : TCustomEdit;                       {* Edit da Cidade                              *}
                                    qryTabela : TUniQuery;                         {* Query                                       *}
                                    Var chrKey: Char): Boolean;                    {* Key                                         *}

  function fPesqAD( Self      : TForm;                            {* Formulário        *}
                    edtCodAD  : TCustomEdit;                      {* Edit do AD        *}
                    qryTabela : TUniQuery;                        {* Query             *}
                    Var chrKey: Char;                             {* Key               *}
                    strCodCli : String;                           {* Cliente           *}
                    blnSomAbe : Boolean = False;                  {* Somente em aberto *}
                    strGarant : String = ''): Boolean;

  function fPesqConEquEnt(Self      : TForm;
                          edtNumDoc : TCustomEdit;
                          qryTabela : TUniQuery;
                          Var chrKey: Char;
                          Var strAutInc: String): Boolean;

  function fPesqAgendamentoDevolucao(Self      : TForm;                           {* Formulário                                  *}
                                    edtCodAD  : TCustomEdit;                      {* Edit do AD                                  *}
                                    qryTabela : TUniQuery;                          {* Query                                       *}
                                    Var chrKey: Char;                             {* Key                                         *}
                                    strCodCli : String;                           {* Cliente                                     *}
                                    blnSemDev : Boolean = False): Boolean;        {* Sem devolucoes realizadas}


  function fPesqOrdProIndustrial(Self     : TForm;                            {* Formulário                                  *}
                                 edtCodigo: TCustomEdit;                      {* Edit do Código                              *}
                                 edtDescri: TCustomEdit;                      {* Edit da Descrição                           *}
                                 qryTabela: TUniQuery;                          {* Query                                       *}
                                 Var chrKey: Char;                            {* Key                                         *}
                                 Var arrSel: TConsultasArray;                 {* Array de Seleção                            *}
                                 tpcPsqOPI: TPesquisaOPI;
                                 blnConSim: Boolean = True;
                                 staState: TStateOPI = staTodas;              {* Consulta Simples ou Múltipla (multi select) *}
                                 strCodIte: String = '';
                                 strCodCor: String = ''):Boolean;

  function fPesqConfiguracaoRel(opcTipCfg: TTipoConsultaSimples;
                                Self     : TForm;                       {* Formulário                                  *}
                                edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                                edtDesPor: TEditFocus;                  {* Edit da Descrição do item                   *}
                                qryTabela: TUniQuery;                     {* Query                                       *}
                                Var chrKey: Char;                       {* Key                                         *}
                                Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                                strWhere : String;                      {* Where                                       *}
                                blnConSim: Boolean = True;              {* Consulta Simples ou Múltipla (multi select) *}
                                strTitulo: String = 'Configuração de Relatórios'): Boolean;


  function fPesqRecComissaoVen(opcTipCom: TTipoConsultaSimples;
                               Self     : TForm;                       {* Formulário                                  *}
                               edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                               edtDesRec: TEditFocus;                  {* Edit da Descrição do item                   *}
                               qryTabela: TUniQuery;                     {* Query                                       *}
                               Var chrKey: Char;                       {* Key                                         *}
                               Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                               blnConSim: Boolean = True;              {* Consulta Simples ou Múltipla (multi select) *}
                               strTitulo: String = 'Consulta Faixas de Recebimento para Comissão (Vendedor)'): Boolean;

  Function fSQLNotasEntrada(finalidadeXML: tpeFinalidadeXML; Var strWhere: String; blnOpcSQL: Boolean = False): String;

  Procedure pCarregaCabecalhoNota(qryConsulta: TUniQuery; Var recNotEle: TRecInfoNotaEletronica);

  function fPesqConsumidores(Self      : TForm;                            {* Formulário                                  *}
                             edtCodCon : TDBEditFocus;                     {* Edit do Código                              *}
                             edtDesCon : TDBEditFocus;                     {* Edit da Descricao                           *}
                             edtCgcCpf : TEditFocus;                       {* Edit CgcCpf                                 *}
                             mskNumCgc : TMaskEditFocus;                   {* Edit NumCgc                                 *}
                             qryTabela : TUniQuery;                          {* Query                                       *}
                             Var chrKey: Char;                             {* Key                                         *}
                             Var arrSel: TConsultasArray;                  {* Array de Seleção                            *}
                             strCodCli : String  = '';                     {* Parametro Filtro Estado Consumidor          *}
                             blnConSim : Boolean = True;                   {* Consulta Simples ou Múltipla (multi select) *}
                             blnRetDoc : Boolean = False): Boolean;        {* Retorna CPF/CNPJ Para consulta Editor de Relatório*}

  function fPesqComissaoProf(opcTipCom: TTipoConsultaSimples;
                             Self     : TForm;                       {* Formulário                                  *}
                             edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                             edtDesPro: TEditFocus;                  {* Edit da Descrição do item                   *}
                             qryTabela: TUniQuery;                     {* Query                                       *}
                             Var chrKey: Char;                       {* Key                                         *}
                             Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                             blnOpcInc: Boolean;                     {* Condição para o Where                       *}
                             strTCoPro: String;                      {* Tipo de Comissão Profissional               *}
                             blnConSim: Boolean = True;              {* Consulta Simples ou Múltipla (multi select) *}
                             strTitulo: String = 'Consulta Faixas de Recebimento para Comissão (Profissional)'): Boolean;

  function fPesqComissaoFat(opcTipCom: TTipoConsultaSimples;
                           Self     : TForm;                       {* Formulário                                  *}
                           edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                           edtDescri: TEditFocus;                  {* Edit da Descrição do item                   *}
                           qryTabela: TUniQuery;                     {* Query                                       *}
                           Var chrKey: Char;                       {* Key                                         *}
                           Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                           blnConSim: Boolean = True;              {* Consulta Simples ou Múltipla (multi select) *}
                           strTitulo: String = 'Consulta Faixas de Faturamento para Comissão'): Boolean;

  function fPesqComissaoFatVend(opcTipCom: TTipoConsultaSimples;
                                Self     : TForm;                       {* Formulário                                  *}
                                edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                                edtDescri: TEditFocus;                  {* Edit da Descrição do item                   *}
                                qryTabela: TUniQuery;                     {* Query                                       *}
                                Var chrKey: Char;                       {* Key                                         *}
                                Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                                blnConSim: Boolean = True;              {* Consulta Simples ou Múltipla (multi select) *}
                                strTitulo: String = 'Consulta Faixas de Faturamento para Comissão'): Boolean;

  function fPesqComissaoFatVendDepart(opcTipCom: TTipoConsultaSimples;
                                      Self     : TForm;                       {* Formulário                                  *}
                                      edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                                      edtDescri: TEditFocus;                  {* Edit da Descrição do item                   *}
                                      qryTabela: TUniQuery;                     {* Query                                       *}
                                      Var chrKey: Char;                       {* Key                                         *}
                                      Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                                      blnConSim: Boolean = True;              {* Consulta Simples ou Múltipla (multi select) *}
                                      strTitulo: String = 'Consulta Faixa de Faturamento Geral do Vendedor X Departamento'): Boolean;

  function fPesqComissaoFatDepart(opcTipCom: TTipoConsultaSimples;
                                  Self     : TForm;                       {* Formulário                                  *}
                                  edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                                  edtDescri: TEditFocus;                  {* Edit da Descrição do item                   *}
                                  qryTabela: TUniQuery;                     {* Query                                       *}
                                  Var chrKey: Char;                       {* Key                                         *}
                                  Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                                  blnConSim: Boolean = True;              {* Consulta Simples ou Múltipla (multi select) *}
                                  strTitulo: String = 'Consulta Faixa de Desconto por Departamento'): Boolean;

  function fPesqOrdemProd(opcTipCom: TTipoConsultaSimples;
                          Self     : TForm;                       {* Formulário                                  *}
                          edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                          edtDescri: TEditFocus;                  {* Edit da Descrição do item                   *}
                          qryTabela: TUniQuery;                     {* Query                                       *}
                          Var chrKey: Char;                       {* Key                                         *}
                          Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                          strWhere : String = '';
                          blnConSim: Boolean = True;              {* Consulta Simples ou Múltipla (multi select) *}
                          strTitulo: String = 'Consulta Ordens de Produção';
                          intOpcStatus : integer = 3): Boolean;

  function fPesqPromocoes(Self      : TForm;                            {* Formulário                                  *}
                          edtCodPro : TEditFocus;                       {* Edit do Código                              *}
                          edtDesPro : TEditFocus;                       {* Edit da Descricao                           *}
                          qryTabela : TUniQuery;                          {* Query                                       *}
                          Var chrKey: Char;                             {* Key                                         *}
                          Var arrSel: TConsultasArray;                  {* Array de Seleção                            *}
                          blnConSim : Boolean = True): Boolean;         {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqNegociacao(Self      : TForm;                            {* Formulário                                  *}
                           edtCodNeg : TEditFocus;                       {* Edit do Código                              *}
                           edtDesNeg : TEditFocus;                       {* Edit da Descricao                           *}
                           qryTabela : TUniQuery;                        {* Query                                       *}
                           Var chrKey: Char;                             {* Key                                         *}
                           Var arrSel: TConsultasArray;                  {* Array de Seleção                            *}
                           blnConSim : Boolean = True): Boolean;         {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqPromocoesBrindes(Self      : TForm;                            {* Formulário                                  *}
                                 edtCodPro : TEditFocus;                       {* Edit do Código                              *}
                                 edtDesPro : TEditFocus;                       {* Edit da Descricao                           *}
                                 qryTabela : TUniQuery;                        {* Query                                       *}
                                 Var chrKey: Char;                             {* Key                                         *}
                                 Var arrSel: TConsultasArray;                  {* Array de Seleção                            *}
                                 blnConSim : Boolean = True): Boolean;         {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqPedidoCompraNFImport(Self      : TForm;                            {* Formulário                                  *}
                                     edtNumPed : TEditFocus;                       {* Edit do Código                              *}
                                     edtNumCtn : TEditFocus;                       {* Edit da Descricao                           *}
                                     qryTabela : TUniQuery;                          {* Query                                       *}
                                     Var chrKey: Char;                             {* Key                                         *}
                                     Var arrSel: TConsultasArray;                  {* Array de Seleção                            *}
                                     objFrmPnl : TPanelCx = Nil;                   {* Painel                                      *}
                                     blnConSim : Boolean = True): Boolean;         {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqPedidoCompraCancelPedido(Self       : TForm;                            {* Formulário                                  *}
                                         edtNumPed  : TEditFocus;                       {* Edit do Código                              *}
                                         rdgOpcoes  : TRadioGroup;                      {* Radio group tipo Pedido                     *}
                                         edtCodEmp  : TEditFocus;                       {* Edit da Empresa                             *}
                                         qryTabela  : TUniQuery;                          {* Query                                       *}
                                         Var chrKey : Char;                             {* Key                                         *}
                                         Var arrSel : TConsultasArray;                  {* Array de Seleção                            *}
                                         blnConSim  : Boolean = True): Boolean;         {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqLoteItens(Self       : TForm;                            {* Formulário                                  *}
                          edtNumLote : TCustomEdit;                      {* Edit do Número do Lote                      *}
                          edtCodIte  : TCustomEdit;                      {* Edit do Código do Item                      *}
                          intDecUni  : Integer;                          {* Casas decimais                              *}
                          qryTabela  : TUniQuery;                        {* Query                                       *}
                          Var chrKey : Char;                             {* Key                                         *}
                          Var arrSel : TConsultasArray;                  {* Array de Seleção                            *}
                          blnConSim  : Boolean = True;                   {* Consulta Simples ou Múltipla (multi select) *}
                          strCodIte  : String = '';
                          strCodEmp  : String = '';
                          blnSoAtivos: Boolean = False;
                          blnRetNumLot: Boolean = False): Boolean;


  function fPesqTipoAtendimento(Self     : TForm;                         {* Formulário                                  *}
                                edtCodigo: TCustomEdit;                   {* Edit do Código                              *}
                                edtDescri: TEditFocus;                    {* Edit da Descrição                           *}
                                qryTabela: TUniQuery;                       {* Query                                       *}
                                Var chrKey: Char;                         {* Key                                         *}
                                Var arrSel: TConsultasArray;              {* Array de Seleção                            *}
                                blnConSim: Boolean = True): Boolean;      {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqControleEntrega(Self     : TForm;                    {* Formulário                                  *}
                                edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                Var chrKey: Char): Boolean;


  function fPesqPedidoCompra(Self       : TForm;                            {* Formulário                                  *}
                             edtCodPed  : TCustomEdit;                      {* Edit do Código                              *}
                             qryTabela  : TUniQuery;                          {* Query                                       *}
                             Var chrKey : Char;                             {* Key                                         *}
                             Var arrSel : TConsultasArray;                  {* Array de Seleção                            *}
                             Var strDoc : String;                           {* Espécie de Documento                        *}
                             strCodEmp  : String;                           {* Código da Empresa                           *}
                             intIndice  : Integer;                          {* Pedido ou Orçamento                         *}
                             blnConSim  : Boolean = True;                   {* Consulta Simples ou Múltipla (multi select) *}
                             objFrmPnl : TPanelCx = Nil;                    {* Painel                                      *}
                             strLitGal  : String = '3.600';
                             strTitulo  : String = 'Consulta de Pedidos de Compra';
                             blnLotPre  : Boolean = False): Boolean;

  function fPesqCampanha(Self       : TForm;                                {* Formulário                                  *}
                         edtCodCam  : TCustomEdit;                          {* Edit do Codigo                              *}
                         edtDesCam  : TEditFocus;                           {* Edit da Descrição                           *}
                         qryConCam  : TUniQuery;                              {* Query                                       *}
                         Var chrKey : Char;                                 {* Key                                         *}
                         Var arrSel : TConsultasArray;                      {* Array de Seleção                            *}
                         blnConSim  : Boolean = True;                       {* Consulta Simples ou Múltipla (multi select) *}
                         strTitulo  : String = 'Consulta de Campanhas';
                         blnRetCod  : Boolean = False): Boolean;

  function fPesqEntrga(Self      : TForm;                                   {* Formulário                                  *}
                       edtNumEnt : TCustomEdit;                             {* Edit do Número de entrega                   *}
                       qryConEnt : TUniQuery;                                 {* Query                                       *}
                       Var chrKey: Char;                                    {* Key                                         *}
                       Var arrSel: TConsultasArray;                         {* Array de Seleção                            *}
                       blnConSimp: Boolean = True;                          {* Consulta Simples ou Múltipla (multi select) *}
                       strTitulo : String = 'Consulta de Entregas'): Boolean;


  function fPesqRequisicao(Self      : TForm;                                   {* Formulário                                  *}
                           edtNumReq : TCustomEdit;                             {* Edit do Número de Requisicao                *}
                           qryConReq : TUniQuery;                               {* Query                                       *}
                           Var chrKey: Char;                                    {* Key                                         *}
                           Var arrSel: TConsultasArray;                         {* Array de Seleção                            *}
                           strCodEmp : String;                                  {* Codigo da Empresa                           *}
                           blnConSim : Boolean = True;                          {* Consulta Simples ou Múltipla (multi select) *}
                           strTitulo : String = 'Consulta de Requisições de Envio de Materiais'): Boolean;

  function fPesqNFCompra(Self      : TForm;                                   {* Formulário                                  *}
                         edtNumDoc : TCustomEdit;                             {* Edit do Número de Requisicao                *}
                         qryConDoc : TUniQuery;                               {* Query                                       *}
                         Var chrKey: Char;                                    {* Key                                         *}
                         Var arrSel: TConsultasArray;                         {* Array de Seleção                            *}
                         strCodEmp : String;                                  {* Codigo da Empresa                           *}
                         Var dtaNFComp: TDatetime;                            {* Data da NF                                  *}
                         blnConSim : Boolean = True;                          {* Consulta Simples ou Múltipla (multi select) *}
                         objFrmPnl : TPanelCx = Nil;                          {* Painel                                      *}
                         strTitulo : String = 'Consulta de NF de Compra';
                         strCodCli : String = ''): Boolean;

  function fPesqNFEntrada(Self      : TForm;                                   {* Formulário                                  *}
                          edtNumDoc : TCustomEdit;                             {* Edit do Número de Requisicao                *}
                          qryConDoc : TUniQuery;                               {* Query                                       *}
                          Var chrKey: Char;                                    {* Key                                         *}
                          Var arrSel: TConsultasArray;                         {* Array de Seleção                            *}
                          blnConSim : Boolean = True;                          {* Consulta Simples ou Múltipla (multi select) *}
                          objFrmPnl : TPanelCx = Nil;                          {* Painel                                      *}
                          strTitulo : String = 'Consulta de NF de Entrada'): Boolean;

  function fPesqClaIPI(Self      : TForm;                                   {* Formulário                                  *}
                       edtClaIPI : TCustomEdit;                             {* Edit do Número de Ajuste                    *}
                       qryConIPI : TUniQuery;                                 {* Query                                       *}
                       Var chrKey: Char;                                    {* Key                                         *}
                       Var arrSel: TConsultasArray;                         {* Array de Seleção                            *}
                       blnConSim : Boolean = True;                          {* Consulta Simples ou Múltipla (multi select) *}
                       strTitulo : String  = 'Consulta de Classificação de IPI'): Boolean;

  function fPesqCfgSis(Self      : TForm;                                   {* Formulário                                  *}
                       edtCodCfg : TCustomEdit;                             {* Edit do Codigo                              *}
                       edtDesCfg : TEditFocus;                              {* Edit da Descrição                           *}
                       qryConCfg : TUniQuery;                                 {* Query                                       *}
                       Var chrKey: Char;                                    {* Key                                         *}
                       Var arrSel: TConsultasArray;                         {* Array de Seleção                            *}
                       blnConSim : Boolean = True;                          {* Consulta Simples ou Múltipla (multi select) *}
                       strTitulo : String  = 'Consulta de Configurações'): Boolean;

  function fPesqCfgTin(Self      : TForm;                                   {* Formulário                                  *}
                       edtCodCfg : TCustomEdit;                             {* Edit do Codigo                              *}
                       edtDesCfg : TEditFocus;                              {* Edit da Descrição                           *}
                       qryConCfg : TUniQuery;                                 {* Query                                       *}
                       Var chrKey: Char;                                    {* Key                                         *}
                       Var arrSel: TConsultasArray;                         {* Array de Seleção                            *}
                       blnConSim : Boolean = True;                          {* Consulta Simples ou Múltipla (multi select) *}
                       strTitulo : String  = 'Consulta de Configurações da Tinta de Máquina'): Boolean;

  function fPesqOrdServ(Self      : TForm;                                  {* Formulário                                  *}
                        edtNumOrd : TCustomEdit;                            {* Edit do Número da Ordem de Serviço          *}
                        qryConOrd : TUniQuery;                              {* Query                                       *}
                        Var chrKey: Char;                                   {* Key                                         *}
                        Var arrSel: TConsultasArray;                        {* Array de Seleção                            *}
                        Var dtaNFOS: TDatetime;                             {* Data da OS                                  *}
                        strStatus : String;                                 {* Status                                      *}
                        strFone   : String;                                 {* Fone                                        *}
                        blnConSim : Boolean = True;                         {* Consulta Simples ou Múltipla (multi select) *}
                        strTitulo : String  = 'Consulta de Ordens de Serviço';
                        intOpcoes : Integer = 3;                            {* 1 = Ordens Abertas, 2 = Ordens Baixadas, 3 = Todas, 4 = Ordens COM STATUS 'APROVADA' OU 'EM MANUTENÇÃO', 5 = Ordens COM STATUS APROVADA / EM MANUTENÇÃO / REALIZADA / REPROVADA *}
                        strSubSta : String = '';                            {* Sub Status                                  *}
                        strSituac : String = '';                            {* Situação                                    *}
                        objFrmPnl : TPanelCx = Nil;                         {* Painel                                      *}
                        strCodCli : String = '';                            {* Cliente                                     *}
                        strNum_OS : String = '';                            {* Não considerar essa O.S.                    *}
                        blnConsOutrasSaidas: Boolean = False): Boolean;     {* Consulta realizada para emissão de outras saídas *}

  function fPesqCtaResultado(Self      : TForm;                             {* Formulário                                  *}
                             edtCodCta : TCustomEdit;                       {* Edit do Codigo                              *}
                             edtDesCta : TEditFocus;                        {* Edit da Descrição                           *}
                             qryConCta : TUniQuery;                           {* Query                                       *}
                             Var chrKey: Char;                              {* Key                                         *}
                             Var arrSel: TConsultasArray;                   {* Array de Seleção                            *}
                             blnConSim : Boolean = True;                    {* Consulta Simples ou Múltipla (multi select) *}
                             blnCodCre : Boolean = False;
                             strTitulo : String  = 'Consulta de Contas Resultado'): Boolean;

  function fPesqCEP(Self      : TForm;                                      {* Formulário                                  *}
                    edtCEP    : TCustomEdit;                                {* Edit do CEP                                 *}
                    qryConCEP : TUniQuery;                                    {* Query                                       *}
                    Var chrKey: Char;                                       {* Key                                         *}
                    Var arrSel: TConsultasArray;                            {* Array de Seleção                            *}
                    strId_uf  : String;                                     {* Estado                                      *}
                    strId_cid : String;                                     {* Cidade                                      *}
                    strNomCid : String;                                     {* Nome da Cidade                              *}
                    blnConSim : Boolean = True;                             {* Consulta Simples ou Múltipla (multi select) *}
                    strTitulo : String  = 'Consulta de Endereços'):Boolean;

  function fPesqCheqDep(Self      : TForm;                                  {* Formulário                                  *}
                        qryCheque : TUniQuery;                                {* Query                                       *}
                        strTabChq : String;                                 {* Tabela de Cheques                           *}
                        blnCanDev : Boolean;                                {* Cancelamento Devolução                      *}
                        Var chrKey: Char;                                   {* Key                                         *}
                        Var arrSel: TConsultasArray;                        {* Array de Seleção                            *}
                        blnConSim : Boolean = True;                         {* Consulta Simples ou Mútipla (multi select)  *}
                        strTitulo : String  = 'Consulta de Cheques Depositados'):Boolean;

  function fPesqRomaneio(Self      : TForm;                                  {* Formulário                                  *}
                         edtNumRom : TCustomEdit;                            {* Edit do Número do Romaneio                  *}
                         qryConRom : TUniQuery;                                {* Query                                       *}
                         Var chrKey: Char;                                   {* Key                                         *}
                         Var arrSel: TConsultasArray;                        {* Array de Seleção                            *}
                         strCadRec : String;                                 {* CADREC ou CADRCXX                           *}
                         blnConSim : Boolean = True;                         {* Consulta Simples ou Múltipla (multi select) *}
                         blnFatRom : Boolean = False;                        {* Se a Chamada é do FatRomaneio ou não        *}
                         strTitulo : String  = 'Consulta de Romaneios'): Boolean;

  function fPesqCtaPagar(Self      : TForm;                                  {* Formulário                                  *}
                         edtCodCtp : TCustomEdit;                            {* Edit do Número do Romaneio                  *}
                         qryConCtp : TUniQuery;                                {* Query                                       *}
                         Var chrKey: Char;                                   {* Key                                         *}
                         Var arrSel: TConsultasArray;                        {* Array de Seleção                            *}
                         intOpcao  : Integer;                                {* Abertos, Baixados ou Todos                  *}
                         blnConSim : Boolean = True;                         {* Consulta Simples ou Múltipla (multi select) *}
                         strTitulo : String  = 'Consulta Contas Pagar'): Boolean;

  function fSqlfPesqIteDev(strNomTab, strOpcDoc, strIteSer, strSerTer: String; blnUsaSer: Boolean): TConsIteDev;
  function fSqlfPesqIteDevEsp(strNomTab, strOpcDoc, strIteSer, strSerTer: String; blnUsaSer: Boolean): TConsIteDev;
  function fPesqIteDev(Self         : TForm;                                 {* Formulário                                  *}
                       qryConIteDev : TUniQuery;                               {* Query                                       *}
                       Var chrKey   : char;                                  {* Key                                         *}
                       Var arrSel   : TConsultasArray;                       {* Array de Seleção                            *}
                       strNomTab    : String;                                {* Nome da Tabela                              *}
                       strOpcDoc    : String;                                {* Vendedor ou Comprador                       *}
                       strIteSer    : String;                                {* Item Serviço                                *}
                       strSerTer    : String;                                {* Item Serviço - Terceirizado                 *}
                       blnUsaSer    : Boolean;                               {* Usa Serviço                                 *}
                       blnConSim    : Boolean = True;                        {* Consulta Simples ou Múltipla (multi select) *}
                       objFrmPnl    : TPanelCx = Nil;                        {* Painel                                      *}
                       strTitulo    : String  = 'Consulta de Itens para Devolução';
                       blnDevEsp    : Boolean = False): Boolean;

  function fPesqCheques(Self      : TForm;                                    {* Formulário                                  *}
                        qryConChq : TUniQuery;                                  {* Query                                       *}
                        Var chrKey: Char;                                     {* Key                                         *}
                        Var arrSel: TConsultasArray;                          {* Array de Seleção                            *}
                        strNomTab : String;                                   {* Nome da Tabela                              *}
                        intOpcao  : Integer;                                  {* Baixados ou Abertos                         *}
                        blnConSim : Boolean = True;                           {* Consulta Simples ou Múltipla (multi select) *}
                        strTitulo : String  = 'Consulta de Cheques'): Boolean;

  function fPesqServAtCli(Self      : TForm;                                  {* Formulário                                  *}
                          qryConSAC : TUniQuery;                                {* Query                                       *}
                          Var chrKey: Char;                                   {* Key                                         *}
                          Var arrSel: TConsultasArray;                        {* Array de Consulta                           *}
                          blnConSim : Boolean = True;                         {* Consulta Simples ou Múltipla (multi select) *}
                          strTitulo : String  = 'Consulta de Serviços de Atendimento ao Cliente'): Boolean;

  function fPesqLotePre(Self      : TForm;                                    {* Formulário                                  *}
                        qryLotPre : TUniQuery;                                  {* Query                                       *}
                        Var chrKey: Char;                                     {* Key                                         *}
                        Var arrSel: TConsultasArray;                          {* Array de Consulta                           *}
                        blnConSim : Boolean = True;                           {* Consulta Simples ou Múltipla (multi select) *}
                        strTitulo : String  = 'Consulta de Lotes de Preço'): Boolean;

  function fPesqVenPerd(Self      : TForm;                                    {* Formulário                                  *}
                        edtCodigo : TCustomEdit;                              {* Edit do Código                              *}
                        qryVenPer : TUniQuery;                                  {* Query                                       *}
                        Var chrKey: Char;                                     {* Key                                         *}
                        Var arrSel: TConsultasArray;                          {* Array de Consulta                           *}
                        blnConSim : Boolean = True;                           {* Consulta Simples ou Múltipla (multi select) *}
                        strTitulo : String  = 'Consulta de Vendas Pedidas'): Boolean;

  function fPesqRequisicaoCompra(Self      : TForm;                                    {* Formulário                                  *}
                                 edtCodigo : TCustomEdit;                              {* Edit do Código                              *}
                                 Var chrKey: Char;                                     {* Key                                         *}
                                 strTitulo : String  = 'Consulta de Requisição de Compras'): Boolean;

  function fPesqContEnt(Self      : TForm;                                    {* Formulário                                  *}
                        edtProxEnt: TCustomEdit;                              {* Edit do Código                              *}
                        qryConEnt : TUniQuery;                                  {* Query                                       *}
                        Var chrKey: Char;                                     {* Key                                         *}
                        Var arrSel: TConsultasArray;                          {* Array de Consulta                           *}
                        blnConSim : Boolean = True;                           {* Consulta Simples ou Múltipla (multi select) *}
                        strTitulo : String  = 'Consulta de Controle de Entregadores'): Boolean;


  function fPesqEstrutura(Self      : TForm;                                  {* Formulário                                  *}
                          edtCodPro : TCustomEdit;                            {* Edit do Código                              *}
                          qryConEst : TUniQuery;                                {* Query                                       *}
                          Var chrKey: Char;                                   {* Key                                         *}
                          Var arrSel: TConsultasArray;                        {* Array de Consulta                           *}
                          blnConSim : Boolean = True;                         {* Consulta Simples ou Múltipla (multi select) *}
                          strTitulo : String  = 'Consulta de Estruturas';
                          blnCodIte : Boolean = False): Boolean;






  function fPesqProdAcabado(Self      : TForm;                                {* Formulário                                  *}
                            edtCodAca : TCustomEdit;                          {* Edit do Código                              *}
                            edtDesAca : TEditFocus;                           {* Edit da Descrição                           *}
                            qryConAca : TUniQuery;                              {* Query                                       *}
                            Var chrKey: Char;                                 {* Key                                         *}
                            Var arrSel: TConsultasArray;                      {* Array de Consulta                           *}
                            strEmpAca : String;                               {* Código da Empresa                           *}
                            strEmpEst : String;
                            blnConSim : Boolean = True;                       {* Consulta Simples ou Múltipla (multi select) *}
                            strTitulo : String  = 'Consulta de Produtos Acabados';
                            blnCodAca : Boolean = False): Boolean;







  function fPesqMotVendasPerdidas(Self     : TForm;                    {* Formulário                                  *}
                                  edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                  edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                                  qryTabela: TUniQuery;                  {* Query                                       *}
                                  Var chrKey: Char;                    {* Key                                         *}
                                  Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                  blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}

  {Pesquisa as cores}
  function fPesqCores(Self     : TForm;                           {* Formulário                                  *}
                      edtCodigo: TCustomEdit;                     {* Edit do Código                              *}
                      edtDescri: TEditFocus;                      {* Edit da Descrição                           *}
                      qryTabela: TUniQuery;                         {* Query                                       *}
                      Var chrKey: Char;                           {* Key                                         *}
                      Var arrSel: TConsultasArray;                {* Array de Seleção                            *}
                      blnConSim: Boolean = True;                  {* Consulta Simples ou Múltipla (multi select) *}
                      strCodGra: String = ''): Boolean;           {* Código do Prouto a Granel *}




  function fPesqSubItensDaEstrutura(Self      : TForm;                    {* Formulário                                  *}
                                    edtCodigo : TCustomEdit;              {* Edit do Código                              *}
                                    edtDescri : TEditFocus;               {* Edit da Cidade                              *}
                                    qryTabela : TUniQuery;                {* Query                                       *}
                                    Var chrKey: Char;                     {* Key                                         *}
                                    Var arrSel: TConsultasArray;          {* Array de Seleção                            *}
                                    strCodIte : String;                   {*Código do produto acabado                    *}
                                    blnConSim : Boolean = True):Boolean;  {* Consulta Simples ou Múltipla (multi select) *}



  function fPesqGrupoProduto(Self         : TForm;                            {* Formulário                                  *}
                             edtCodigo    : TCustomEdit;                      {* Edit do Código                              *}
                             edtDescricao : TEditFocus;                       {* Edit da Descrição                           *}
                             qryTabela    : TUniQuery;                          {* Query                                       *}
                             Var chrKey   : Char;                             {* Key                                         *}
                             Var arrSel   : TConsultasArray;                  {* Array de Seleção                            *}
                             blnConSim    : Boolean = True): Boolean;         {* Consulta Simples ou Múltipla (multi select) *}


  function fPesqAltPar(Self     : TForm;                    {* Formulário                                  *}
                       edtDtaAlt: TEditFocus;               {* Edit da Data de Alteração                   *}
                       edtNomCam: TEditFocus;               {* Edit do Nome do Campo                       *}
                       edtValAnt: TEditFocus;               {* Edit do Valor anterior                      *}
                       qryTabela: TUniQuery;                  {* Query                                       *}
                       Var chrKey: Char;                    {* Key                                         *}
                       Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                       strTpPart: String;                   {* Tipo Participante - Cliente/Forn/Consumidor *}
                       strCdPart: String;                   {* Código Participante                         *}
                       blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}




  function fPesqCadAdendo(Self     : TForm;                         {* Formulário                                  *}
                          edtCodigo: TCustomEdit;                   {* Edit do Código                              *}
                          edtDescri: TEditFocus;                    {* Edit da Descrição                           *}
                          qryTabela: TUniQuery;                       {* Query                                       *}
                          Var chrKey: Char;                         {* Key                                         *}
                          Var arrSel: TConsultasArray;              {* Array de Seleção                            *}
                          blnConSim: Boolean = True): Boolean;      {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqLocSep(Self     : TForm;                            {* Formulário                                  *}
                       edtCodigo: TCustomEdit;                      {* Edit do Código                              *}
                       edtDescri: TEditFocus;                       {* Edit da Descrição                           *}
                       qryTabela: TUniQuery;                        {* Query                                       *}
                       Var chrKey: Char;                            {* Key                                         *}
                       Var arrSel: TConsultasArray;                 {* Array de Seleção                            *}
                       blnConSim: Boolean = True): Boolean;         {* Consulta Simples ou Múltipla (multi select) *}


  function fPesqColorantes(Self: TForm;
                           opcConsulta: TTipoTintas;
                           edtCodCol,
                           edtCodIte: TCustomEdit;
                           qryTabela: TUniQuery;
                           Var chrKey: Char;
                           Var arrSel: TConsultasArray;
                           blnConSim: Boolean = True;
                           strFiltros: string = '';
                           CampoRelacionamento: String = ''; blnComProdutos: boolean = True): Boolean;

  function fPesqBaseTinta(Self: TForm;
                          opcConsulta: TTipoTintas;
                          edtBase,
                          edtDescBase: TCustomEdit;
                          qryTabela: TUniQuery;
                          Var chrKey: Char;
                          Var arrSel: TConsultasArray;
                          blnConSim: Boolean = True;
                          strFiltros: string = '';
                          CampoRelacionamento: string = ''; blnComProdutos: boolean = True): Boolean;

  function fPesqEmbalagemUnidadeTinta(Self: TForm;
                        opcConsulta: TTipoTintas;
                        edtCodEmabalagem,
                        edtCodUnidade,
                        edtQuantidade: TCustomEdit;
                        strFiltro: String; {Campo de Filtro para quando o }
                        qryTabela: TUniQuery;
                        Var chrKey: Char;
                        Var arrSel: TConsultasArray;
                        blnConSim: Boolean = True): Boolean;

  function fPesqEmbalagens(self: TForm;
                     strNomeTabela: string;
                     edtCodEmb,
                     edtQuanti,
                     edtUnidad: TCustomEdit;
                     qryTabela: TUniQuery;
                     Var chrKey: Char;
                     Var arrSel: TConsultasArray;
                     blnConSim: Boolean = True): Boolean;

  function fPesqFormulaTinta(self: TForm;
                        opcConsulta: TTipoTintas;
                        edtCodFormula: TCustomEdit;
                        qryTabela: TUniQuery;
                        Var chrKey: Char;
                        Var arrSel: TConsultasArray;
                        blnConSim: Boolean = True;
                         strFiltros: String = ''): Boolean;

function fPesqSkyGrupoTinta(Self: TForm;
                         edtCodGru: TCustomEdit;
                         qryTabela: TUniQuery;
                         Var chrKey: Char;
                         Var arrSel: TConsultasArray;
                         blnConSim: Boolean = True): Boolean;

function fPesqSkySubGrupoTinta(Self: TForm;
                         edtCodGru: TCustomEdit;
                         qryTabela: TUniQuery;
                         Var chrKey: Char;
                         Var arrSel: TConsultasArray;
                         blnConSim: Boolean = True): Boolean;

function fPesqMontadoraTinta(Self: TForm;
                             opcConsulta: TTipoTintas;
                             edtCodMontadora,
                             edtDesMontadora: TCustomEdit;
                             qryTabela: TUniQuery;
                             Var chrKey: Char;
                             Var arrSel: TConsultasArray;
                             blnConSim: Boolean = True): Boolean;

function fPesqLinhaTinta(Self: TForm;
                             opcConsulta: TTipoTintas;
                             edtCodLinha,
                             edtDesLinha: TCustomEdit;
                             qryTabela: TUniQuery;
                             Var chrKey: Char;
                             Var arrSel: TConsultasArray;
                             blnConSim: Boolean = True): Boolean;

function fPesqAcabamentosTinta(Self: TForm;
                             opcConsulta: TTipoTintas;
                             qryTabela: TUniQuery;
                             Var chrKey: Char;
                             Var arrSel: TConsultasArray;
                             blnConSim: Boolean = True): Boolean;




function fPesqMZA_CADLIN(Self: TForm;
                             edtLinCod: TCustomEdit;
                             qryTabela: TUniQuery;
                             Var chrKey: Char;
                             Var arrSel: TConsultasArray;
                             blnConSim: Boolean = True): Boolean;

function fPesqMZD_CADLIN(Self: TForm;
                             edtLinCod: TCustomEdit;
                             qryTabela: TUniQuery;
                             Var chrKey: Char;
                             Var arrSel: TConsultasArray;
                             blnConSim: Boolean = True): Boolean;



function fPesqCadastroTintas(Self: TForm;
                             opcConsulta: TTipoTintas;
                             qryTabela: TUniQuery;
                             Var chrKey: Char;
                             Var arrSel: TConsultasArray;
                             blnConSim: Boolean = True): Boolean;


function fPesqGenericaTinta(Self: TForm;
                                     strTabela: String;
                                     qryTabela: TUniQuery;
                                     var chrKey: char;
                                     var arrSel: TConsultasArray;
                                     blnConSim: Boolean = True;
                                     campoAgrupador: string = '';
                                     strFiltros: string = '';
                                     blnComProdutos: Boolean = True): Boolean;

function fPesqItemBase(Self: TForm;
                       edtCodBas,
                       edtDescri: TCustomEdit;
                       qryTabela: TUniQuery;
                       Var chrKey: Char;
                       Var arrSel: TConsultasArray): Boolean;

function fPesqItemColorante(Self: TForm;
                            edtCodIte,
                            edtDescri: TCustomEdit;
                            qryTabela: TUniQuery;
                            Var chrKey: Char;
                            Var arrSel: TConsultasArray): Boolean;


function fPesqItemEmbalagem(Self: TForm;
                            edtCodIte,
                            edtDescri: TCustomEdit;
                            qryTabela: TUniQuery;
                            Var chrKey: Char;
                            Var arrSel: TConsultasArray;
                            blnProEmb: Boolean = True;
                            strFiltro: string = ''): Boolean;

function fPesqProdutosAcabados(Self            : TForm;
                               qryTabela       : TUniQuery;
                               Var chrKey      : Char;
                               Var arrSel      : TConsultasArray;
                               blnComSaldo     : boolean = False;
                               blnSaldoDifZero : boolean = False;
                               strEmpEst       : String  = '';
                               btnConfirmaVisivel: Boolean = True): Boolean;

function fPesqRei_cadCor(Self: TForm;
                               qryTabela: TUniQuery;
                               Var chrKey: Char;
                               Var arrSel: TConsultasArray): boolean;

function fSQLNomCam: string;

  function fPesqGrupoServicos(Self     : TForm;                            {* Formulário                                  *}
                              edtCodigo: TCustomEdit;                      {* Edit do Código                              *}
                              edtDescri: TEditFocus;                       {* Edit da Descrição                           *}
                              qryTabela: TUniQuery;                        {* Query                                       *}
                              Var chrKey: Char;                            {* Key                                         *}
                              Var arrSel: TConsultasArray;                 {* Array de Seleção                            *}
                              blnConSim: Boolean = True): Boolean;         {* Consulta Simples ou Múltipla (multi select) *}

function fPesqCest(Self: TForm;                            {* Formulario                                  *}
                   edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                   edtDescri: TEditFocus;                  {* Edit da Descrição                           *}
                   qryTabela: TUniQuery;                     {* Query                                       *}
                   Var chrKey: Char;                       {* Key                                         *}
                   Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                   blnConSim: Boolean = True;
                   strCodNCM: String = ''): Boolean;    {* Consulta Simples ou Múltipla (multi select) *}

function fPesqCondPagBosch(Self: TForm;                            {* Formulario                                  *}
                           edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                           edtDescri: TEditFocus;                  {* Edit da Descrição                           *}
                           qryTabela: TUniQuery;                     {* Query                                       *}
                           Var chrKey: Char;                       {* Key                                         *}
                           Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                           blnConSim: Boolean = True): Boolean;    {* Consulta Simples ou Múltipla (multi select) *}

function fPesqCondPagBosch2(Self: TForm;                            {* Formulario                                  *}
                           edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                           edtDescri: TEditFocus;                  {* Edit da Descrição                           *}
                           qryTabela: TUniQuery;                     {* Query                                       *}
                           Var chrKey: Char;                       {* Key                                         *}
                           Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                           blnConSim: Boolean = True): Boolean;    {* Consulta Simples ou Múltipla (multi select) *}

function fPesqCliCtt(Self: TForm;                            {* Formulario                                  *}
                     edtDescri: TEditFocus;                  {* Edit da Descrição                           *}
                     qryTabela: TUniQuery;                   {* Query                                       *}
                     Var chrKey: Char;                       {* Key                                         *}
                     Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                     strCodCli : String = '';                {* Código do cliente                           *}
                     blnConSim: Boolean = True): Boolean;    {* Consulta Simples ou Múltipla (multi select) *}

function fPesqComboVenda(Self: TForm;                        {* Formulario                                  *}
                         edtCodigo: TCustomEdit;             {* Edit do Código                              *}
                         edtDescri: TEditFocus;              {* Edit da Descrição                           *}
                         qryTabela: TUniQuery;               {* Query                                       *}
                         Var chrKey: Char;                   {* Key                                         *}
                         Var arrSel: TConsultasArray;        {* Array de Seleção                            *}
                         blnConSim: Boolean = True;          {* Consulta Simples ou Múltipla (multi select) *}
                         blnRetCodCom: Boolean = False): Boolean; {* Retorna CodCom ou Autoincrem                *}

  function fPesqMaterialConsumo(Self     : TForm;                        {* Formulário                                  *}
                              edtCodigo: TCustomEdit;                    {* Edit do Código                              *}
                              edtDescri: TCustomEdit;                    {* Edit da Descrição                           *}
                              qryTabela: TUniQuery;                      {* Query                                       *}
                              Var chrKey: Char;                          {* Key                                         *}
                              Var arrSel: TConsultasArray;               {* Array de Seleção                            *}
                              blnConSim: Boolean = True;                 {* Consulta Simples ou Múltipla (multi select) *}
                              strCodFor: String = ''): Boolean;       {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqFaixasCndPagtoAgr(Self   : TForm;                                   {* Formulário                                  *}
                                  qryCadFai : TUniQuery;                            {* Query                                       *}
                                  Var chrKey: Char;                                 {* Key                                         *}
                                  Var arrSel: TConsultasArray;                      {* Array de Consulta                           *}
                                  blnConSim : Boolean = True;                       {* Consulta Simples ou Múltipla (multi select) *}
                                  strTitulo : String  = 'Consulta de Faixas de Condição de Pagamento para agrupamento'): Boolean;

  function fPesqAgendaVisita(Self   : TForm;           {* Formulário                             *}
                             Var strNumLote: String;   {* Número do lote do registro selecionado *}
                             Var strAutoIncrem: String {* Chave primária do registro selecionado *}
                             ): Boolean;

  function fPesqFornecedorAtualCRM(Self     : TForm;                            {* Formulário                                  *}
                                   edtCodigo: TCustomEdit;                      {* Edit do Código                              *}
                                   edtDescri: TEditFocus;                       {* Edit da Descrição                           *}
                                   qryTabela: TUniQuery;                        {* Query                                       *}
                                   Var chrKey: Char;                            {* Key                                         *}
                                   Var arrSel: TConsultasArray;                 {* Array de Seleção                            *}
                                   blnConSim: Boolean = True): Boolean;         {* Consulta Simples ou Múlti pla (multi select) *}

  function fPesqFrequenciaCRM(Self     : TForm;                            {* Formulário                                  *}
                              edtCodigo: TCustomEdit;                      {* Edit do Código                              *}
                              edtDescri: TEditFocus;                       {* Edit da Descrição                           *}
                              qryTabela: TUniQuery;                        {* Query                                       *}
                              Var chrKey: Char;                            {* Key                                         *}
                              Var arrSel: TConsultasArray;                 {* Array de Seleção                            *}
                              blnConSim: Boolean = True): Boolean;         {* Consulta Simples ou Múlti pla (multi select) *}




  function fPesqGruCfg(Self      : TForm;                                   {* Formulário                                  *}
                       edtDesCfg : TEditFocus;                              {* Edit da Descrição                           *}
                       qryConCfg : TUniQuery;                                 {* Query                                       *}
                       Var chrKey: Char;                                    {* Key                                         *}
                       Var arrSel: TConsultasArray;                         {* Array de Seleção                            *}
                       blnConSim : Boolean = True;                          {* Consulta Simples ou Múltipla (multi select) *}
                       strTitulo : String  = 'Consulta de Grupos de Configurações'): Boolean;

  function fPesqContatosOperador(Self     : TForm;                         {* Formulário                                  *}
                                 edtCodigo: TCustomEdit;                   {* Edit do Código                              *}
                                 edtDescri: TEditFocus;                    {* Edit da Descrição                           *}
                                 qryTabela: TUniQuery;                     {* Query                                       *}
                                 Var chrKey: Char;                         {* Key                                         *}
                                 Var arrSel: TConsultasArray;              {* Array de Seleção                            *}
                                 blnConSim: Boolean = True): Boolean;      {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqDescClienteProduto(Self     : TForm;                          {* Formulário                                  *}
                                   edtCodigo: TCustomEdit;                    {* Edit do Código                              *}
                                   qryTabela: TUniQuery;                      {* Query                                       *}
                                   Var chrKey: Char;                          {* Key                                         *}
                                   Var arrSel: TConsultasArray;               {* Array de Seleção                            *}
                                   blnConSim: Boolean = True): Boolean;       {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqCliDes(strFormName : String;                      {* Formulário                                  *}
                       edtCodigo: TCustomEdit;                    {* Edit do Código                              *}
                       qryTabela: TUniQuery;                      {* Query                                       *}
                       Var chrKey: Char;                          {* Key                                         *}
                       Var arrSel: TConsultasArray;               {* Array de Seleção                            *}
                       blnConSim: Boolean = True): Boolean;       {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqRegDes(strFormName : String;                      {* Formulário                                  *}
                       edtCodigo: TCustomEdit;                    {* Edit do Código                              *}
                       qryTabela: TUniQuery;                      {* Query                                       *}
                       Var chrKey: Char;                          {* Key                                         *}
                       Var arrSel: TConsultasArray;               {* Array de Seleção                            *}
                       blnConSim: Boolean = True): Boolean;       {* Consulta Simples ou Múltipla (multi select) *}

  function fPesqDocas(Self      : TForm;                       {* Formulário                                  *}
                    edtCodigo : TCustomEdit;                   {* Edit do Codigo                              *}
                    edtDescri : TCustomEdit;                   {* Edit da Descrição                           *}
                    qryTabela : TUniQuery;                     {* Query                                       *}
                    Var chrKey: Char;                          {* Key                                         *}
                    Var arrSel: TConsultasArray;               {* Array de Seleção                            *}
                    blnConSim : Boolean = True;                {* Consulta Simples ou Múltipla (multi select) *}
                    strStatus : String = ''):Boolean;
  function fPesqAgendamentoEntregaWMS(Self      : TForm;                         {* Formulário                                  *}
                                    edtCodigo : TCustomEdit;                   {* Edit do Codigo                              *}
                                    qryTabela : TUniQuery;                     {* Query                                       *}
                                    Var chrKey: Char;                          {* Key                                         *}
                                    Var arrSel: TConsultasArray;               {* Array de Seleção                            *}
                                    blnConSim : Boolean = True;                {* Consulta Simples ou Múltipla (multi select) *}
                                    strStatus : String = '';
                                    strPlaca  : String = ''):Boolean;

  function fPesqClasseLocFis(Self     : TForm;                    {* Formulário                                  *}
                           edtSigla: TCustomEdit;                 {* Edit da Sigla                               *}
                           qryTabela: TUniQuery;                  {* Query                                       *}
                           Var chrKey: Char;                      {* Key                                         *}
                           Var arrSel: TConsultasArray;           {* Array de Seleção                            *}
                           blnConSim: Boolean = True;             {* Consulta Simples                            *}
                           strCodIte: String = '';                {* Código do Item                              *}
                           objFrmPnl: TPanelCx = nil): Boolean;   {* Panel para legendas                         *}

  function fPesqBoxWms(Self     : TForm;                    {* Formulário                                  *}
                       edtCodigo: TCustomEdit;                 {* Edit da Sigla                               *}
                       qryTabela: TUniQuery;                  {* Query                                       *}
                       Var chrKey: Char;                      {* Key                                         *}
                       Var arrSel: TConsultasArray;           {* Array de Seleção                            *}
                       blnConSim: Boolean = True;             {* Consulta Simples                            *}
                       blnSomenteDisponivel : Boolean = False):Boolean;


  function fPesqRotasRegiao(Self      : TForm;                            {* Formulário                                  *}
                            edtCodigo : TCustomEdit;                      {* Edit do Código                              *}
                            edtDescri : TEditFocus;                       {* Edit da Cidade                              *}
                            qryTabela : TUniQuery;                        {* Query                                       *}
                            Var chrKey: Char;                             {* Key                                         *}
                            Var arrSel: TConsultasArray;                  {* Array de Seleção                            *}
                            blnConSim : Boolean = True): Boolean;         {* Consulta Simples ou Múltipla (multi select) *}


  function fPesqEntregasRotasRegiao(Self      : TForm;                            {* Formulário                                  *}
                                    edtCodigo : TCustomEdit;                      {* Edit do Código                              *}
                                    edtDescri : TEditFocus;                       {* Edit da Cidade                              *}
                                    qryTabela : TUniQuery;                        {* Query                                       *}
                                    Var chrKey: Char;                             {* Key                                         *}
                                    Var arrSel: TConsultasArray;                  {* Array de Seleção                            *}
                                    blnConSim : Boolean = True;                   {* Consulta Simples ou Múltipla (multi select) *}
                                    strCodCid : String = '';                      {* Cidade do endereco de entrega               *}
                                    blnFiltroPorData : Boolean = True;
                                    fltPesBru : Double = 0): Boolean;

  //Chamadas de Cadastro
  function fCadFor(blnCheck :Boolean = False):Boolean;
  function fCadCli(blnCheck :Boolean = False):Boolean;
  function fGetFiltroClienteEmpresaIdentificadora(strCodOpe: String; blnComAnd: Boolean = True): String;
  function fGetSQLNumCmp(strAliasFatGor: String = 'FATGOR'): String;





Var
  objCadastros   : ICadastros;
  VS_Application : TApplication;
  fMskCon: TfMskCon;

implementation

Uses
  cxGridCustomTableView, cxGridDBTableView,untFuncoesGenerica,  untConstantes,
  MaskUtils, untLegendasItem,  {untConsultaFiltrosCtaReceber,} untConsultasTinta,
  untPesqItem, untCadPro, {untTSituacaoPedidoVenda} untModuloLegenda, Math,
  untPnlBotoesProdutoAcabadoConsulta, untPanelCxBotoesProdutoAcabadoConsulta;

Type
  TDefMascaraContasReceber = Class(TDefConsulta)
  private
    procedure pDisplayCGCCPF(Sender: TcxCustomGridTableItem;
                             ARecord: TcxCustomGridRecord;
                             var AText: string);
  public
    Constructor Create; Reintroduce;
  End;

  TDefMascaraCheque = Class(TDefConsulta)
  private
    procedure pDisplayCGCCPF(Sender: TcxCustomGridTableItem;
                             ARecord: TcxCustomGridRecord;
                             var AText: string);
  public
    Constructor Create; Reintroduce;
  End;

  TDefMascaraLinhaGrupo = Class(TDefConsulta)
  private
    procedure pDisplayLinhaGrupo(Sender: TcxCustomGridTableItem;
                             ARecord: TcxCustomGridRecord;
                             var AText: string);
  public
    Constructor Create; Reintroduce;
  End;

  TDefMascaraCliente = Class(TDefConsulta)
  private

    procedure pDisplayCGCCPF(Sender: TcxCustomGridTableItem;
                             ARecord: TcxCustomGridRecord;
                             var AText: string);

    function fGetCellStyle(AView: TcxGridDBTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; ADataSet: TDataSet): TcxStyle; override;
  public

    cxsInativo,
    cxsSCPC: TcxStyle;

    blnColorirGrid: Boolean;

    Constructor Create; Reintroduce;
    Destructor Destroy; override;

  End;

  TDefMascaraFornecedor = Class(TDefConsulta)

  private
    cxsStatusInativo: TcxStyle;
    procedure pDisplayCGCCPF(Sender: TcxCustomGridTableItem;
                             ARecord: TcxCustomGridRecord;
                             var AText: string);
    function fGetCellStyle(AView: TcxGridDBTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; ADataSet: TDataSet): TcxStyle; override;

  public

    Constructor Create; Reintroduce;
    Destructor destroy; reintroduce;

  End;

  TDefMascaraCadFisCGC = Class(TDefConsulta)
  private
    procedure pDisplayCGCCPF(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
  public
    Constructor Create; Reintroduce;
  End;


  TDefMascaraOPIndustrial = Class(TDefConsulta)
  private

    procedure pDisplayNumLot(Sender: TcxCustomGridTableItem;
                             ARecord: TcxCustomGridRecord;
                             var AText: string);

  public

    Constructor Create; Reintroduce;

  End;

  TDefMascaraCentroCusto = Class(TDefConsulta)
  private
    cxsGrupos: TcxStyle;
    procedure pDisplayPlanoContabil(Sender: TcxCustomGridTableItem;
                                    ARecord: TcxCustomGridRecord;
                                    var AText: string);

    procedure pDisplayCodigo(Sender: TcxCustomGridTableItem;
                             ARecord: TcxCustomGridRecord;
                             var AText: string);

    function fGetCellStyle(AView: TcxGridDBTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; ADataSet: TDataSet): TcxStyle; override;
  public

    Constructor Create; Reintroduce;
    Destructor Destroy; override;
  End;

  TDefMascaraKmRodado = Class(TDefConsulta)
  private

    procedure pDisplayPlacaVeiculo(Sender: TcxCustomGridTableItem;
                             ARecord: TcxCustomGridRecord;
                             var AText: string);

  public

    Constructor Create; Reintroduce;

  End;

  TDefMascaraCNAE = Class(TDefConsulta)
  private
    procedure pDisplayCNAE(Sender: TcxCustomGridTableItem;
                          ARecord: TcxCustomGridRecord;
                        var AText: string);
  public
    Constructor Create; Reintroduce;
  End;

  TDefConsulaItem = class(TDefConsulta)
  private
    cdsLegendas: TLegendasItem;
    blnSitPro: Boolean;

    function fGetCellStyle(AView: TcxGridDBTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; ADataSet: TDataSet): TcxStyle; override;
  public

    strTabPre,
    strCodCli: String;

    blnColorirGrid: Boolean;

    Constructor Create; Reintroduce;
    Destructor Destroy; override;

  End;

  TDefConsultaConEntrega = class(TDefConsulta)
  private
    cxsBaixado: TcxStyle;

    function fGetCellStyle(AView: TcxGridDBTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; ADataSet: TDataSet): TcxStyle; override;
  public

    Constructor Create; Reintroduce;
    Destructor Destroy; override;

  End;

  TDefConsultaPed = class(TDefConsulta)
  private
    cxPedBlue : TcxStyle;
    cxPedBlack: TcxStyle;
    cxPedPurple: TcxStyle;

    function fGetCellStyle(AView: TcxGridDBTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; ADataSet: TDataSet): TcxStyle; override;
  public

    Constructor Create; Reintroduce;
    Destructor Destroy; override;
  End;


  TDefConsultaPedidoCompra = class(TDefConsulta)
  private
    cxsRed    : TcxStyle;
    cxsBlue   : TcxStyle;
    cxsBlack  : TcxStyle;

    function fGetCellStyle(AView: TcxGridDBTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; ADataSet: TDataSet): TcxStyle; override;
  public

    Constructor Create; Reintroduce;
    Destructor Destroy; override;

  End;

  TDefConsultaPortadores = Class(TDefConsulta)
  private
    cxsPorOpe: TcxStyle;

    function fGetCellStyle(AView: TcxGridDBTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; ADataSet: TDataSet): TcxStyle; override;

    procedure pDisplayPlanoContabil(Sender: TcxCustomGridTableItem;
                                    ARecord: TcxCustomGridRecord;
                                    var AText: string);
  public
    Constructor Create; Reintroduce;
    Destructor Destroy; override;
  End;

  TDefConsultaOS = Class(TDefConsulta)
  private
    cxsVencendoPrazo: TcxStyle;
    cxsPrazoVencido : TcxStyle;

    function fGetCellStyle(AView: TcxGridDBTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; ADataSet: TDataSet): TcxStyle; override;
    procedure pDisplayCGCCPF(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);

  public
    Constructor Create; Reintroduce;
    Destructor destroy; reintroduce;
  End;

  TDefConsultaClasseLocal = Class(TDefConsulta)
  private
    cxsMapeadasItem: TcxStyle;
    cxsNormal : TcxStyle;

    function fGetCellStyle(AView: TcxGridDBTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; ADataSet: TDataSet): TcxStyle; override;

  public
    Constructor Create; Reintroduce;
    Destructor destroy; reintroduce;
  End;

  TDefConsultaLotFat = Class(TDefConsulta)
  private
    function fCellBold(AView: TcxGridDBTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; ADataSet: TDataSet): Boolean; override;
  End;


  TDefMascaraDiversos = Class(TDefConsulta)

  private
    procedure pDisplayCGCCPF(Sender: TcxCustomGridTableItem;
                             ARecord: TcxCustomGridRecord;
                             var AText: string);

  public

    Constructor Create; Reintroduce;
    Destructor  Destroy; reintroduce;

  End;

  TDefConsultaDefeito = Class(TDefConsulta)
  private
    sltDefeitos: TStringList;
    procedure pParametriza(qryConsulta: TUniQuery); override;
  public
    Constructor Create; Reintroduce;
    Destructor  Destroy; Reintroduce;
  End;

  TDefConsultaServico = Class(TDefConsulta)
  private
    sltServicos: TStringList;
    procedure pParametriza(qryConsulta: TUniQuery); override;
  public
    Constructor Create; Reintroduce;
    Destructor  Destroy; Reintroduce;
  End;

  TDefConsultaPlanoContabil = Class(TDefConsulta)
  private
    strMskCon : String;
    procedure pDisplayPlanoContabil(Sender: TcxCustomGridTableItem;
                                    ARecord: TcxCustomGridRecord;
                                    var AText: string);
  public
    constructor Create(arrCampos : TStringArray); reintroduce;
    destructor Destroy; reintroduce;
  end;


    function fPesqLoteFat(Self       : TForm;                            {* Formulário                                  *}
                        edtNumLote : TCustomEdit;                      {* Edit do Código                              *}
                        intDecUni  : Integer;                          {* Casas decimais                              *}
                        strCodIte  : String;                           {* Código do produto                           *}
                        blnSalPos  : Boolean;                          {* Boleana                                     *}
                        blnSemADef : Boolean;                          {* Boleana                                     *}
                        qryTabela  : TUniQuery;                        {* Query                                       *}
                        Var chrKey : Char;                             {* Key                                         *}
                        Var arrSel : TConsultasArray;                  {* Array de Seleção                            *}
                        strEmpLot  : String = '';                      {* Empresa do Item para consulta do Lote       *}
                        objFrmPnl  : TPanelCx = Nil;                   {* Painel                                      *}
                        blnConSim  : Boolean = True;                   {* Consulta Simples ou Múltipla (multi select) *}
                        arrNumLot  : TStringArray = Nil;               {* Array com lista de Lotes a serem mostrados  *}
                        blnSoAtivo : Boolean = True;                   {* Mostra somente os Lotes Ativos ou Não       *}
                        blnApenasAprovados : Boolean = False;
                        blnApenasPrincipalVendaOuCheckout: Boolean = False;
                        bnlMovimentacaoProgramada: Boolean = False;
                        blnApenasChapa: Boolean = False;
                        arrLotesAdd: TStringArray = Nil;               {* Lotes já adicionados no Pedido              *}
                        strPicking: String = '';
                        blnSemGarantia : Boolean = False;               {* Boleana, Sem Lote Garantia                  *}
                        blnChamadaViaFaturamento : Boolean = False;
                        blnMostrarLotePickingCheckout : Boolean = False;
                        strEspDoc: String = '';
                        fltValorUnitario: Double = 0;
                        fltSaldoMinimo: Double = 0;
                        blnSemGar: Boolean = False;
                        stlListaNumLotExcluido: String = '';
                        strTabPre: String = '';
                        strEntRet: String = '';
                        blnSomentePicking : Boolean = False;               {* Mostra somente os Lotes PICKING          *}
                        blnNaoExibeLotTransi : Boolean = False):Boolean;  {* Mostra somente os Lotes PICKING             *}

begin
  Result := false;
end;

{*****************************}
{* CONSULTA DE CIDADES       *}
{**************************RV*}
function fPesqCidade(Self     : TForm;                    {* Formulário                                  *}
                     edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                     edtCidade: TEditFocus;               {* Edit da Cidade                              *}
                     edtEstado: TEditFocus;               {* Edit do Estado (UF)                         *}
                     qryTabela: TUniQuery;                  {* Query                                       *}
                     Var chrKey: Char;                    {* Key                                         *}
                     Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                     blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}
  Var
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
      strSQL := strSQL + '  CID_CODCID,       ';
      strSQL := strSQL + '  CID_NOMCID,       ';
      strSQL := strSQL + '  CID_ESTADO,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  CADCID            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Código',
                   'Cidade',
                   'UF',
                   'AUTOINCREM'],
                   ['CID_NOMCID','CID_ESTADO','CID_CODCID'],
                   '',
                   'CADCID',
                   Self.Name,
                   'Consulta de Cidades',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'CID_CODCID') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('CID_CODCID').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('CID_CODCID').AsString;
        End;

        If Assigned(edtCidade) Then
          edtCidade.Text := qryConsulta.FieldByName('CID_NOMCID').AsString;

        If Assigned(edtEstado) Then
          edtEstado.Text := qryConsulta.FieldByName('CID_ESTADO').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 5)
            Else
              edtCodigo.Text := fStrZero('0', 5);
          End;

          If Assigned(edtCidade) Then
            edtCidade.Text := '+1';

          If Assigned(edtEstado) Then
            edtEstado.Text := '';

        End;

        Result := True;
      End;
      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;



{********************************************************}
{* CONSULTA DE LAYOUTS DO EDITOR DE DOCUMENTOS          *}
{*****************************************************LA*}
function fPesqLayout(Self     : TForm;                 {* Formulário                                  *}
                     edtCodigo: TCustomEdit;           {* Edit do Código                              *}
                     edtDescri: TEditFocus;            {* Edit da Descrição                           *}
                     qryTabela: TUniQuery;             {* Query                                       *}
                     strTipImp: String;                {* JATO / MATRICIAL                            *}
                     Var chrKey: Char;                 {* Key                                         *}
                     Var arrSel: TConsultasArray;      {* Array de Seleção                            *}
                     blnConSim: Boolean = True;        {* Consulta Simples ou Múltipla (multi select) *}
                     strTipLay: String = '';
                     tplTipLay: TTipoLayout = tplDocumentos): Boolean; {* Tipo do Layout                              *}
  Var
    strSQL,
    strSQLWhere: String;
    qryConsulta: TUniQuery;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  LAY_CODLAY,       ';
      strSQL := strSQL + '  LAY_NOMLAY,       ';
      strSQL := strSQL + '  LAY_DESCRI,       ';
      strSQL := strSQL + '  LAY_PADRAO,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  LAYETI            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      strSQLWhere := ' WHERE LAY_TIPIMP = ' + QuotedStr(strTipImp) +
                     '  AND LAY_CODEMP = ' + QuotedStr(VS_strCodEmp);

      case tplTipLay of
        tplDocumentos:  strSQLWhere := strSQLWhere + ' AND LAY_TIPREG = 1 ';
        tplEtiquetas :  strSQLWhere := strSQLWhere + ' AND LAY_TIPREG = 0 ';
      end;

      If Not fEmptyStr(strTipLay) Then
      Begin
        strSQLWhere := strSQLWhere +
                       '   AND LAY_TIPLAY = ' + QuotedStr(strTipLay);
      End;

      If fConsulta([strSQL, strSQLWhere],
                  ['Código',
                   'Tipo do Layout',
                   'Descrição',
                   'Padrão'],
                   ['LAY_NOMLAY','LAY_DESCRI','LAY_CODLAY'],
                    'LAY_CODLAY',
                    'LAYETI',
                   Self.Name,
                   'Consulta de Layouts',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'LAY_CODLAY') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('LAY_CODLAY').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('LAY_CODLAY').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('LAY_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 6)
            Else
              edtCodigo.Text := fStrZero('0', 6);
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';

        End;

        Result := True;

      End;
      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
End;

{********************************************************}
{* CONSULTA DE CAMPOS DO LAYOUT DO EDITOR DE DOCUMENTOS *}
{*****************************************************LA*}
function fPesqCamsposLayout(Self     : TForm;                         {* Formulário                                  *}
                            edtCodigo: TCustomEdit;                   {* Edit do Código                              *}
                            edtDescri: TEditFocus;                    {* Edit da Descrição                           *}
                            qryTabela: TUniQuery;                     {* Query                                       *}
                            Var chrKey: Char;                         {* Key                                         *}
                            Var arrSel: TConsultasArray;              {* Array de Seleção                            *}
                            strFiltro: String;
                            intPosCam: Integer = -1;
                            blnConSim: Boolean = True): Boolean;      {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL,
    strSQLWhere: String;
    qryConsulta: TUniQuery;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  CAM_CODCAM,       ';
      strSQL := strSQL + '  CAM_DESCAM,       ';
      strSQL := strSQL + '  CAM_CODCAM AS AUTOINCREM ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  CAMETI            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      strSQLWhere := ' WHERE ';

      strSQLWhere := strSQLWhere + strFiltro;

      If intPosCam >= 0 Then
        strSQLWhere := strSQLWhere + ' AND CAM_POSCAM = ' + IntToStr(intPosCam);

      If fConsulta([strSQL, strSQLWhere],
                  ['Código',
                   'Descrição'],
                   ['CAM_DESCAM','CAM_CODCAM'],
                   'CAM_CODCAM',
                   'CAMETI',
                   Self.Name,
                   'Consulta de Campos',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'CAM_CODCAM') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('CAM_CODCAM').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('CAM_CODCAM').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('CAM_DESCAM').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 6)
            Else
              edtCodigo.Text := fStrZero('0', 6);
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';

        End;

        Result := True;

      End;
      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;


{*****************************}
{* CONSULTA DE ATIVIDADES    *}
{**************************RV*}

{*************************************}
{* CONSULTA DE MODELOS DE RELATORIO  *}
{**********************************LA*}
function fPesqModeloRelatorio(Self     : TForm;                 {* Formulário                                  *}
                              edtCodigo: TCustomEdit;           {* Edit do Código                              *}
                              edtDescri: TEditFocus;            {* Edit da Descrição                           *}
                              qryTabela: TUniQuery;             {* Query                                       *}
                              blnBackup: Boolean;               {* True = Backup                               *}
                              strTipImp: String;
                              Var chrKey: Char;                 {* Key                                         *}
                              Var arrSel: TConsultasArray;      {* Array de Seleção                            *}
                              blnConSim: Boolean = True;
                              strRelBkp: String = ''): Boolean; {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL,
    strWhere   : String;
    qryConsulta: TUniQuery;
    objConsulta: TDefConsulta;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  MOD_CODMOD,       ';
      strSQL := strSQL + '  MOD_DESCRI,       ';
      strSQL := strSQL + '  TIPOIMPRES,       ';
      strSQL := strSQL + '  MOD_DTAALT,       ';
      strSQL := strSQL + '  MOD_HORALT,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  CADMOD            ';

      strWhere := ' WHERE ';

      If blnBackup Then
      Begin
        If fEmptyStr(strRelBkp) Then
          strWhere := strWhere + ' MOD_CODBKP IS NOT NULL '
        Else
          strWhere := strWhere + ' MOD_CODBKP = '+ QuotedStr(strRelBkp);

      End Else
        strWhere := strWhere + ' MOD_CODBKP IS NULL ';

      If Not fEmptyStr(strTipImp) Then
        strWhere := strWhere + ' AND MOD_TIPIMP = ' + QuotedStr(strTipImp) + ' ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      objConsulta := TDefConsulta.Create;
      objConsulta.pIncluiSubConsulta('TIPOIMPRES', 'IF(MOD_TIPIMP = "J", "JATO", "MATRICIAL")');

      If fConsulta([strSQL, strWhere],
                  ['Código',
                   'Descrição',
                   'Tipo Impressão',
                   'Data Alteração',
                   'Hora Alteração'],
                   ['MOD_DESCRI','MOD_CODMOD'],
                   '',
                   'CADMOD',
                   Self.Name,
                   'Consulta de Modelos de Relatórios',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'MOD_CODMOD',
                   objConsulta) Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('MOD_CODMOD').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('MOD_CODMOD').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('MOD_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 6)
            Else
              edtCodigo.Text := fStrZero('0', 6);
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';

        End;

        Result := True;
      End;

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);

      FreeAndNil(objConsulta);

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

{*************************************}
{* CONSULTA DE VIEWS                 *}
{**********************************LA*}
function fPesqTemplateSQL(Self     : TForm;                    {* Formulário                                  *}
                          edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                          edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                          qryTabela: TUniQuery;                {* Query                                       *}
                          Var chrKey: Char;                    {* Key                                         *}
                          Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                          blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL,
    strWhere     : String;
    qryConsulta: TUniQuery;
    objConsulta: TDefConsulta;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT              ';
      strSQL := strSQL + '  TEM_CODIGO,       ';
      strSQL := strSQL + '  TEM_DESGRU,       ';
      strSQL := strSQL + '  TEM_DESCRI,       ';
      strSQL := strSQL + '  TEM_TIPSQL,       ';
      strSQL := strSQL + '  TEM_SIMBOL,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  CADTEM            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      strWhere := '';

      objConsulta := TDefConsulta.Create;

      If fConsulta([strSQL, strWhere],
                  ['Código',
                   'Grupo',
                   'Descrição',
                   'Tipo',
                   'Símbolo',
                   'AUTOINCREM'],
                   ['TEM_DESCRI','TEM_CODIGO', 'TEM_DESGRU'],
                   '',
                   'CADTEM',
                   Self.Name,
                   'Consulta de Templates (SQL)',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'TEM_CODIGO',
                   objConsulta) Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('TEM_CODIGO').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('TEM_CODIGO').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('TEM_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 6)
            Else
              edtCodigo.Text := fStrZero('0', 6);
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';

        End;

        Result := True;
      End;

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);

      FreeAndNil(objConsulta);

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

{*************************************}
{* CONSULTA DE RELATORIOS            *}
{**********************************LA*}
function fPesqRelatorio(Self     : TForm;                    {* Formulário                                  *}
                        edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                        edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                        qryTabela: TUniQuery;                {* Query                                       *}
                        blnBackup: Boolean;                  {* True = Backup                               *}
                        strTipImp: String;
                        Var chrKey: Char;                    {* Key                                         *}
                        Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                        blnConSim: Boolean = True;           {* Consulta Simples ou Múltipla (multi select) *}
                        strRelBkp: String = ''): Boolean;
  Var
    strSQL,
    strWhere     : String;
    qryConsulta: TUniQuery;
    objConsulta: TDefConsulta;
    blnOrdInd: Boolean;
    strMetPed: String;
    strModMkp: String;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      blnOrdInd := fCfgSis('UTIIND', varBoolean);
      strMetPed := fCfgSis('METPED', varString);
      strModMkp := fCfgSis('MODMKP', varString);

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  REL_CODREL,       ';
      strSQL := strSQL + '  REL_DESCRI,       ';
      strSQL := strSQL + '  TIPOIMPRES,       ';
      strSQL := strSQL + '  REL_DTAALT,       ';
      strSQL := strSQL + '  REL_HORALT,       ';
      strSQL := strSQL + '  MEN_CAPMEN,       ';
      strSQL := strSQL + '  CADREL.AUTOINCREM ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  CADREL            ';
      strSQL := strSQL + ' LEFT JOIN RELMEN ON MEN_CODREL = REL_CODREL ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      strWhere := ' WHERE ';

      If blnBackup Then
      Begin
        If fEmptyStr(strRelBkp) Then
          strWhere := strWhere + ' REL_CODBKP IS NOT NULL '
        Else
          strWhere := strWhere + ' REL_CODBKP = '+ QuotedStr(strRelBkp);

      End Else
        strWhere := strWhere + ' REL_CODBKP IS NULL ';

      If Not fEmptyStr(strTipImp) Then
        strWhere := strWhere + ' AND REL_TIPIMP = ' + QuotedStr(strTipImp) + ' ';

      If blnOrdInd Then
        strWhere := strWhere + ' AND IFNULL(REL_CHAVE_, 0) NOT IN (22, 23) '
      Else
        strWhere := strWhere + ' AND IFNULL(REL_CHAVE_, 0) NOT IN (130, 131) ';

      If (strMetPed = '1') Then
        strWhere := strWhere + ' AND IFNULL(REL_CHAVE_, 0) NOT IN (350,351,356,357,352,353)';

      If (strMetPed = '2') Then
        strWhere := strWhere + ' AND IFNULL(REL_CHAVE_, 0) NOT IN (354,355,356,357,352,353)';

      If (strMetPed = '3') Then
        strWhere := strWhere + ' AND IFNULL(REL_CHAVE_, 0) NOT IN (354,355,350,351,352,353)';

      If (strMetPed = '4') Then
        strWhere := strWhere + ' AND IFNULL(REL_CHAVE_, 0) NOT IN (354,355,350,351,356,357)';

      If (strModMkp = '1') Then
        strSQL := strSQL + 'AND IFNULL(REL_CHAVE_, 0) NOT IN(1082,1084,1088,1090,1142,1144,1145,1147)';

      If (strModMkp = '2') Then
         strSQL := strSQL + 'AND IFNULL(REL_CHAVE_, 0) NOT IN(1079,1085,1142,1144,1145,1147)';

      If (strModMkp = '3') Then
         strSQL := strSQL + 'AND IFNULL(REL_CHAVE_, 0) NOT IN(1079,1085,1082,1084,1088,1090)';

      objConsulta := TDefConsulta.Create;
      objConsulta.pIncluiSubConsulta('TIPOIMPRES', 'IF(REL_TIPIMP = "J", "JATO", "MATRICIAL")');

      If fConsulta([strSQL, strWhere],
                  ['Código',
                   'Nome',
                   'Tipo Impressão',
                   'Data Alteração',
                   'Hora Alteração',
                   'Menu',
                   'AUTOINCREM'],
                   ['REL_DESCRI','REL_CODREL'],
                   '',
                   'CADREL',
                   Self.Name,
                   'Consulta de Relatórios',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'REL_CODREL',
                   objConsulta) Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('REL_CODREL').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('REL_CODREL').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('REL_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 6)
            Else
              edtCodigo.Text := fStrZero('0', 6);
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';

        End;

        Result := True;
      End;

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);

      FreeAndNil(objConsulta);

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;



function fPesqPesquisa(Self     : TForm;                    {* Formulário                                  *}
                       edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                       edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                       qryTabela: TUniQuery;                  {* Query                                       *}
                       Var chrKey: Char;                    {* Key                                         *}
                       Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                       blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}
  Var
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
      strSQL := strSQL + '  PES_CODPES, ';
      strSQL := strSQL + '  PES_DESPES, ';
      strSQL := strSQL + '  AUTOINCREM ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADPES ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Código',
                   'Descrição'],
                   ['PES_DESPES','PES_CODPES', 'PES_CODEMP'],
                   '',
                   'CADPES',
                   Self.Name,
                   'Consulta de Pesquisas',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'PES_CODPES') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('PES_CODPES').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('PES_CODPES').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('PES_DESPES').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 3)
            Else
              edtCodigo.Text := fStrZero('0', 3);
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


function fPesqMontadora(Self     : TForm;                    {* Formulário                                  *}
                        edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                        edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                        qryTabela: TUniQuery;                  {* Query                                       *}
                        Var chrKey: Char;                    {* Key                                         *}
                        Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                        blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}
  Var
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
      strSQL := strSQL + '  MON_CODMON,       ';
      strSQL := strSQL + '  MON_DESCRI,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  CADMON            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Código',
                   'Descrição'],
                   ['MON_DESCRI','MON_CODMON'],
                   '',
                   'CADMON',
                   Self.Name,
                   'Consulta de Montadoras',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'MON_CODMON') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('MON_CODMON').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('MON_CODMON').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('MON_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 3)
            Else
              edtCodigo.Text := fStrZero('0', 3);
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


{ TDefMascaraLinhaGrupo }
constructor TDefMascaraLinhaGrupo.Create;
begin
  pIncluiIndCampos(['GRU_CODGRU']);
  pIncluiDefMascara('GRU_CODGRU', pDisplayLinhaGrupo);

  pSetaCarecteresIgnorados('GRU_CODGRU', '.');
end;

procedure TDefMascaraLinhaGrupo.pDisplayLinhaGrupo(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  AText := FormatMaskText('999.999;0;', AText)
end;


{*****************************}
{* CONSULTA DE LINHA/GRUPO   *}
{**************************RV*}
function fPesqGrupo(Self     : TForm;                          {* Formulário                                  *}
                    edtCodigo: TCustomEdit;                    {* Edit do Código                              *}
                    edtDescri: TEditFocus;                     {* Edit da Descrição                           *}
                    qryTabela: TUniQuery;                        {* Query                                       *}
                    Var chrKey: Char;                          {* Key                                         *}
                    Var arrSel: TConsultasArray;               {* Array de Seleção                            *}
                    blnConSim: Boolean = True;                 {* Consulta Simples ou Múltipla (multi select) *}
                    blnDesRes: Boolean = False): Boolean;      {* Mostrar Descricao Resumida(INDUSTRIAL)      *}
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
    arrPesq    : Array of String;
    objConsulta: TDefMascaraLinhaGrupo;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      objConsulta := TDefMascaraLinhaGrupo.Create;
      objConsulta.pIncluiSubConsulta('DESLIN', '(SELECT L.GRU_DESGRU FROM CADGRU L WHERE L.GRU_CODGRU = CONCAT(LEFT(C.GRU_CODGRU, 3), "000"))');

      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  GRU_CODGRU,       ';
      strSQL := strSQL + '  GRU_DESGRU,       ';

      strSQL := strSQL + '  DESLIN,           ';

      If blnDesRes Then
      begin
        strSQL := strSQL + '  GRU_DRELIN,       ';
        strSQL := strSQL + '  GRU_DREGRU,       ';

        SetLength(arrPesq, 4);

        arrPesq[0] := 'GRU_DESGRU';
        arrPesq[1] := 'GRU_DRELIN';
        arrPesq[2] := 'GRU_DREGRU';
        arrPesq[3] := 'GRU_CODGRU';
      end
      else
      begin
        SetLength(arrPesq, 2);

        arrPesq[0] := 'GRU_DESGRU';
        arrPesq[1] := 'GRU_CODGRU';
      end;

      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  CADGRU C          ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                   ['Código do Grupo',
                    'Descrição do Grupo',
                    'Descrição da Linha',

                    IfThen(blnDesRes,'Descr. Resum. Linha',''),
                    IfThen(blnDesRes,'Descr. Resum. Grupo',''),
                    'AUTOINCREM'],
                   arrPesq,
                   '',
                   'CADGRU',
                   Self.Name,
                   'Consulta de Linha e Grupo',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'GRU_CODGRU',
                   objConsulta) Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If edtCodigo.ClassNameIs('TMaskEditFocus') Then
            TMaskEditFocus(edtCodigo).Text := qryConsulta.FieldByName('GRU_CODGRU').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('GRU_CODGRU').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('GRU_DESGRU').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If edtCodigo.ClassNameIs('TMaskEditFocus')  Then
              TMaskEditFocus(edtCodigo).Text := fStrZero('0', 6)
            Else
              edtCodigo.Text := fStrZero('0', 6);
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';

        End;

        Result := True;

      End;

      FreeAndNil(objConsulta);

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;



{*****************************}
{* CONSULTA DE CLIENTE       *}
{**************************RV*}
function fCadCli(blnCheck :Boolean = False):Boolean;
Begin
  Result := False;
  If fVerificaAcessoSistema('frmCadClientes') And Assigned(objCadastros) Then
  Begin
    If blnCheck Then
      Result := True
    Else
      objCadastros.pChamaCadastroCliente;
  End;
End;


{***********************}
{* CONSULTA DE REGIOES *}
{********************DP*}
function fPesqRegiao(Self     : TForm;                    {* Formulário                                  *}
                     edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                     edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                     qryTabela: TUniQuery;                  {* Query                                       *}
                     Var chrKey: Char;                    {* Key                                         *}
                     Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                     blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}
  Var
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
      strSQL := strSQL + '  REG_CODREG,       ';
      strSQL := strSQL + '  REG_DESREG,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  CADREG            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Código',
                   'Descrição',
                   'AUTOINCREM'],
                   ['REG_DESREG','REG_CODREG'],
                   '',
                   'CADREG',
                   Self.Name,
                   'Consulta de Regiões',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'REG_CODREG') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('REG_CODREG').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('REG_CODREG').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('REG_DESREG').AsString;

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

{***********************************}
{* CONSULTA DE EFETIVAÇÃO DE PREÇO *}
{********************************VM*}
function fPesqEfetivacaoDePreco(Self: TForm;              {* Formulário                                  *}
                     edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                     edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                     qryTabela: TUniQuery;                {* Query                                       *}
                     Var chrKey: Char;                    {* Key                                         *}
                     Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                     blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL     : String;
    strWhere   : String;
    qryConsulta: TUniQuery;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + ' SELECT          ';
      strSQL := strSQL + '  DTAPRE,        ';
      strSQL := strSQL + '  QTDITE,        ';
      strSQL := strSQL + '  AUTOINCREM     ';
      strSQL := strSQL + ' FROM (          ';
      strSQL := strSQL + ' SELECT          ';
      strSQL := strSQL + '   DISTINCT(DATE_FORMAT(PRE_DTAPRE,"%d/%m/%Y")) AS DTAPRE,      ';
      strSQL := strSQL + '   (SELECT COUNT(P.PRE_DTAPRE) FROM PREITE P WHERE P.PRE_DTAPRE = PREITE.PRE_DTAPRE) AS QTDITE,        ';
      strSQL := strSQL + '   DATE_FORMAT(PRE_DTAPRE,"%d%m%Y") AS AUTOINCREM,   ';
      strSQL := strSQL + '   PRE_CODEMP                ';
      strSQL := strSQL + ' FROM                        ';
      strSQL := strSQL + '   PREITE                    ';
      strSQL := strSQL + ' WHERE PRE_CODEMP =  '+ QuotedStr(VS_strCodEmp);
      strSQL := strSQL + '   ) AS TAB                  ';

      strWhere := '';
      strWhere := strWhere + ' WHERE PRE_CODEMP =  '+ QuotedStr(VS_strCodEmp);

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL,strWhere],
                   ['Data da Alteração',
                   'Quantidade de Itens'],
                   ['DTAPRE','QTDITE'],
                   '',
                   'PREITE',
                   Self.Name,
                   'Consulta de Efetivação de Preços',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'AUTOINCREM') Then
      Begin
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

function fPesqDic(Self     : TForm;                            {* Formulário                                  *}
                  edtCodigo: TCustomEdit;                      {* Edit do Código                              *}
                  edtDescri: TEditFocus;                       {* Edit da Descrição                           *}
                  qryTabela: TUniQuery;                          {* Query                                       *}
                  Var chrKey: Char;                            {* Key                                         *}
                  Var arrSel: TConsultasArray;                 {* Array de Seleção                            *}
                  blnConSim: Boolean = True): Boolean;         {* Consulta Simples ou Múltipla (multi select) *}
  Var
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
      strSQL := strSQL + '  DIC_CODDIC,       ';
      strSQL := strSQL + '  DIC_DESCRI,       ';
      strSQL := strSQL + '  DIC_CODDIC AS AUTOINCREM ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  CADDIC            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Código',
                   'Descrição'],
                   ['DIC_DESCRI','DIC_CODDIC'],
                   'DIC_CODDIC',
                   'CADDIC',
                   Self.Name,
                   'Consulta DIC',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'DIC_CODDIC') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('DIC_CODDIC').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('DIC_CODDIC').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('DIC_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 7)
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
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

function fPesqSubRegiao(Self     : TForm;                            {* Formulário                                  *}
                        edtCodigo: TCustomEdit;                      {* Edit do Código                              *}
                        edtDescri: TEditFocus;                       {* Edit da Descrição                           *}
                        qryTabela: TUniQuery;                          {* Query                                       *}
                        Var chrKey: Char;                            {* Key                                         *}
                        Var arrSel: TConsultasArray;                 {* Array de Seleção                            *}
                        blnConSim: Boolean = True): Boolean;         {* Consulta Simples ou Múltipla (multi select) *}
  Var
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
      strSQL := strSQL + '  SUB_CODSUB,       ';
      strSQL := strSQL + '  SUB_DESSUB,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  CADSUB            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

        If fConsulta([strSQL],
                  ['Código',
                   'Descrição',
                   'AUTOINCREM'],
                   ['SUB_DESSUB','SUB_CODSUB'],
                   '',
                   'CADSUB',
                   Self.Name,
                   'Consulta de Sub-Regiões',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'SUB_CODSUB') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('SUB_CODSUB').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('SUB_CODSUB').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('SUB_DESSUB').AsString;

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

function fPesqOperador(Self     : TForm;                                     {* Formulário                                                *}
                       edtCodigo: TCustomEdit;                               {* Edit do Código                                            *}
                       edtDescri: TEditFocus;                                {* Edit da Descrição                                         *}
                       qryTabela: TUniQuery;                                 {* Query                                                     *}
                       Var chrKey: Char;                                     {* Key                                                       *}
                       Var arrSel: TConsultasArray;                          {* Array de Seleção                                          *}
                       blnConSim: Boolean = True;                            {* Consulta Simples ou Múltipla (multi select)               *}
                       blnAtivos: Boolean = False;                           {* Somente Operadores Ativos                                 *}
                       blnGerentes: Boolean = False;                         {* Somente Operadores Gerentes                               *}
                       blnMecanicos: Boolean = False;                        {* Somente Operadores Mecânicos                              *}
                       blnVenRepre: Boolean = False;                         {* Somente Vendedor Interno/Representante Externo            *}
                       blnCompradores: Boolean = False;                      {* Somente Compradores                                       *}
                       blnAdministrativo: Boolean = False;                   {* Somente Operadores Administrativos                        *}
                       blnSubGerentes: Boolean = False;
                       blnVendedorEmpLog: Boolean = False;                   {* Somente vendedor da empresa logada                        *}
                       blnPermissaoTransferencia: Boolean = False;           {* Somente Operadores com permissão de receber transferencia *}
                       blnPermissaoBalancoColetor: Boolean = False): Boolean;{* Somente Operadores com permissão de balanço de estoque - coletor*}

  Var
    strSQL     : String;
    strWhere   : String;
    strIntExt  : String;
    qryConsulta: TUniQuery;
    objConsulta: TDefConsulta;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  OPECOD,           ';
      strSQL := strSQL + '  OPERAD,           ';
      strSQL := strSQL + '  CODEMP,           ';
      strSQL := strSQL + '  STAOPE,           ';
      strSQL := strSQL + '  TIPVEN,           ';
      strSQL := strSQL + '  NOMDEP,           ';
      strSQL := strSQL + '  OPEGER,           ';
      strSQL := strSQL + '  NOMGER,           ';
      strSQL := strSQL + '  V1.AUTOINCREM,    ';
      strSQL := strSQL + '  V1.OPE_CODOPE     ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  CADOPE AS V1      ';
      strSQL := strSQL + '  LEFT JOIN CADDEP DP ON DP.DEP_CODIGO = V1.OPE_CODDEP ';
      strSQL := strSQL + '  LEFT JOIN CADOPE V2 ON V2.OPE_CODOPE = V1.OPE_CODGER ';

      If blnPermissaoBalancoColetor Then
      Begin
        strSQL := strSQL + ' INNER JOIN DIROPE DO ON DO.OPE_CODOPE = V1.OPE_CODOPE';
        strSQL := strSQL + '                     AND DO.DIR_NOMFRM = "btnBalanco" ';
      End;

      strWhere := ' WHERE TRUE ';

      If blnAtivos Then
        strWhere := strWhere + ' AND V1.OPE_STATUS = "A" ';

      If blnPermissaoTransferencia Then
        strWhere := strWhere + ' AND V1.OPE_PERTRF = "S" ';

      strIntExt := EmptyStr;

      If blnGerentes Then
        strIntExt := strIntExt + '"G",';

      If blnSubGerentes Then
        strIntExt := strIntExt + '"S",';

      If blnMecanicos Then
        strIntExt := strIntExt + '"M",';

      If blnVenRepre Then
        strIntExt := strIntExt + '"I", "E", "D",';

      If blnCompradores Then
        strIntExt := strIntExt + '"C",';

      If blnAdministrativo Then
        strIntExt := strIntExt + '"A",';

      If Not fEmptyStr(strIntExt) Then
      Begin
        strIntExt := Copy(strIntExt,1,Length(strIntExt)-1); // TIRA ÚLTIMA VÍRGULA
        If fEmptyStr(strWhere) Then
          strWhere := strWhere + 'WHERE V1.OPE_INTEXT IN (' + strIntExt + ') '
        Else
          strWhere := strWhere + '  AND V1.OPE_INTEXT IN (' + strIntExt + ') ';
      End;

      if blnVendedorEmpLog then
      begin
        strWhere := strWhere + ' AND LOCATE('+QuotedStr(VS_strCodEmp)+', V1.OPE_EMPACE) > 0 ';
      end;

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      objConsulta := TDefConsulta.Create;
      objConsulta.pIncluiSubConsulta('NOMDEP', 'DP.DEP_DESCRI');
      objConsulta.pIncluiSubConsulta('NOMGER', 'V2.OPE_NOMOPE');
      objConsulta.pIncluiSubConsulta('TIPVEN', 'CASE WHEN V1.OPE_INTEXT = "I" THEN "VEND.INTERNO" '+
                                               '     WHEN V1.OPE_INTEXT = "E" THEN "REPRES. EXT. LOJA" '+
                                               '     WHEN V1.OPE_INTEXT = "D" THEN "REPRES. EXT. DISTRIB." '+
                                               '     WHEN V1.OPE_INTEXT = "C" THEN "COMPRAS" '+
                                               '     WHEN V1.OPE_INTEXT = "A" THEN "ADMINISTRATIVO" '+
                                               '     WHEN V1.OPE_INTEXT = "G" THEN "GERENTE" '+
                                               '     WHEN V1.OPE_INTEXT = "S" THEN "SUB-GERENTE" '+
                                               '     WHEN V1.OPE_INTEXT = "M" THEN "MECANICO" '+
                                               '     WHEN V1.OPE_INTEXT = "O" THEN "OPERACIONAL" '+
                                               '     ELSE "" END ');
      objConsulta.pIncluiSubConsulta('OPECOD', 'V1.OPE_CODOPE');
      objConsulta.pIncluiSubConsulta('OPERAD', 'V1.OPE_NOMOPE');
      objConsulta.pIncluiSubConsulta('CODEMP', 'V1.OPE_CODEMP');
      objConsulta.pIncluiSubConsulta('STAOPE', 'V1.OPE_STATUS');
      objConsulta.pIncluiSubConsulta('OPEGER', 'IF(V1.OPE_INTEXT = "G", "S", "N")');

      If fConsulta([strSQL, strWhere],
                  ['Código',
                   'Descrição',
                   'Empresa',
                   'Status',
                   'Interno/Externo',
                   'Departamento',
                   'Gerente?',
                   'Nome Gerente',
                   'AUTOINCREM'],
                  ['OPERAD','CODEMP','NOMDEP','OPECOD'],
                   '',
                   'CADOPE',
                   Self.Name,
                   'Consulta de Operadores',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'OPE_CODOPE',
                   objConsulta) Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('OPE_CODOPE').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('OPE_CODOPE').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('OPE_NOMOPE').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 3)
            Else
              edtCodigo.Text := fStrZero('0', 3);
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';

        End;

        Result := True;

      End;

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);

      FreeAndNil(objConsulta);

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;


{**********************************************}
{* CONSULTA DE PARCELAS DE FINANCEIRAS        *}
{*******************************************LA*}
(*function fPesqParcelaFinanc(Self     : TForm;                    {* Formulário                                  *}
                            edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                            edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                            qryTabela: TUniQuery;                  {* Query                                       *}
                            Var chrKey: Char;                    {* Key                                         *}
                            Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                            Var intQtdPar: Integer;              (* Quantidade de Parcelas                      *}
                            blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
    objFrmPnl  : TPanelCx;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  FIN_CODIGO,       ';
      strSQL := strSQL + '  FIN_DESCRI,       ';
      strSQL := strSQL + '  IND_QTDPAR,       ';
      strSQL := strSQL + '  CADFIN.AUTOINCREM ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  CADFIN            ';
      strSQL := strSQL + 'INNER JOIN INDFIN ON IND_CODFIN = FIN_CODIGO ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      objFrmPnl :=  TPanelCx.Create(False);

      SetLength(objFrmPnl.arrNomCam, 1);
      objFrmPnl.arrNomCam[0] := 'IND_QTDPAR';

      If fConsulta([strSQL],
                  ['Código',
                   'Descrição',
                   'Parcelas',
                   'AUTOINCREM'],
                   ['FIN_CODIGO'],
                   '',
                   'CADFIN',
                   Self.Name + '_PARC',
                   'Consulta de Financeiras',
                   qryConsulta,
                   objFrmPnl,
                   blnConSim,
                   arrSel,
                   'FIN_CODIGO') Then
      Begin
        If Assigned(objFrmPnl.arrRetCam) And
           (Length(objFrmPnl.arrRetCam) > 0) Then
        Begin
          intQtdPar := objFrmPnl.arrRetCam[0];
          SetLength(objFrmPnl.arrRetCam, 0);
        End
        Else
          intQtdPar := 0;

        SetLength(objFrmPnl.arrNomCam, 0);
        FreeAndNil(objFrmPnl);

        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('FIN_CODIGO').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('FIN_CODIGO').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('FIN_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := '0'
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
end;*)







function fPesqGrupoAtividade(Self     : TForm;                      {* Formulário                                  *}
                             edtCodigo: TCustomEdit;               {* Edit do Código                              *}
                             edtDescri: TEditFocus;                {* Edit da Descrição                           *}
                             qryTabela: TUniQuery;                   {* Query                                       *}
                             Var chrKey: Char;                     {* Key                                         *}
                             Var arrSel: TConsultasArray;          {* Array de Seleção                            *}
                             blnConSim: Boolean = True): Boolean;  {* Consulta Simples ou Múltipla (multi select) *}
  Var
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
      strSQL := strSQL + '  GAT_CODGAT,       ';
      strSQL := strSQL + '  GAT_DESCRI,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  CADGAT            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Código',
                   'Descrição',
                   'AUTOINCREM'],
                   ['GAT_DESCRI','GAT_CODGAT'],
                   '',
                   'CADGAT',
                   Self.Name,
                   'Consulta de Grupo de Atividade',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'GAT_CODGAT') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('GAT_CODGAT').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('GAT_CODGAT').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('GAT_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 3)
            Else
              edtCodigo.Text := fStrZero('0', 3);
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

{*******************************}
{* CONSULTA DE TIPO DE CLIENTE *}
{****************************RV*}
function fPesqTipoCliente(Self     : TForm;                       {* Formulário                                  *}
                            edtCodigo: TCustomEdit;               {* Edit do Código                              *}
                            edtDescri: TEditFocus;                {* Edit da Descrição                           *}
                            qryTabela: TUniQuery;                   {* Query                                       *}
                            Var chrKey: Char;                     {* Key                                         *}
                            Var arrSel: TConsultasArray;          {* Array de Seleção                            *}
                            blnConSim: Boolean = True): Boolean;  {* Consulta Simples ou Múltipla (multi select) *}
  Var
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
      strSQL := strSQL + '  TIP_CODTIP,       ';
      strSQL := strSQL + '  TIP_DESTIP,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  TIPCLG            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Código',
                   'Descrição',
                   'AUTOINCREM'],
                   ['TIP_DESTIP','TIP_CODTIP'],
                   '',
                   'TIPCLG',
                   Self.Name,
                   'Consulta de Tipo de Cliente',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'TIP_CODTIP') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('TIP_CODTIP').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('TIP_CODTIP').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('TIP_DESTIP').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 3)
            Else
              edtCodigo.Text := fStrZero('0', 3);
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

{***********************************}
{* CONSULTA DE AGENDA DE TELEFONES *}
{********************************RV*}
function fPesqAgendaTelef(Self     : TForm;                       {* Formulário                                  *}
                            edtCodigo: TCustomEdit;               {* Edit do Código                              *}
                            edtDescri: TEditFocus;                {* Edit da Descrição                           *}
                            qryTabela: TUniQuery;                   {* Query                                       *}
                            Var chrKey: Char;                     {* Key                                         *}
                            Var arrSel: TConsultasArray;          {* Array de Seleção                            *}
                            blnConSim: Boolean = True): Boolean;  {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
    objConsulta: TDefConsulta;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  TEL_CODTEL,       ';
      strSQL := strSQL + '  TEL_NOMCON,       ';
      strSQL := strSQL + '  TEL_FONE01,       ';
      strSQL := strSQL + '  TEL_F_A_X_,       ';
      strSQL := strSQL + '  TEL_CONTAT,       ';
      strSQL := strSQL + '  TEL_E_MAIL,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  TELCON            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      objConsulta := TDefConsulta.Create;

      objConsulta.pIncluiCamposFone(['TEL_FONE01', 'TEL_F_A_X_']);

      If fConsulta([strSQL],
                  ['Código',
                   'Nome',
                   'Fone',
                   'Fax',
                   'Contato',
                   'E-mail',
                   'AUTOINCREM'],
                   ['TEL_NOMCON','TEL_FONE01','TEL_CODTEL'],
                   '',
                   'TELCON',
                   Self.Name,
                   'Consulta de Telefones',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'TEL_CODTEL',
                   objConsulta) Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('TEL_CODTEL').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('TEL_CODTEL').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('TEL_NOMCON').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 8)
            Else
              edtCodigo.Text := fStrZero('0', 8);
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';

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

{*******************************}
{* CONSULTA DE GRUPO DE COMPRA *}
{****************************RV*}
function fPesqGrupoCompra(Self     : TForm;                       {* Formulário                                  *}
                          edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                          edtDescri: TEditFocus;                  {* Edit da Descrição                           *}
                          qryTabela: TUniQuery;                     {* Query                                       *}
                          Var chrKey: Char;                       {* Key                                         *}
                          Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                          blnConSim: Boolean = True): Boolean;    {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE     ';
      strSQL := strSQL + '  GRU_CODIGO,           ';
      strSQL := strSQL + '  GRU_DESCRI,           ';
      strSQL := strSQL + '  OPE_NOMOPE,           ';
      strSQL := strSQL + '  GRU_COMPRA.AUTOINCREM ';
      strSQL := strSQL + 'FROM                    ';
      strSQL := strSQL + '  GRU_COMPRA            ';
      strSQL := strSQL + ' 	LEFT JOIN CADOPE ON OPE_CODOPE = GRU_OPERES ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Código',
                   'Descrição',
                   'Responsável',
                   'AUTOINCREM'],
                   ['GRU_DESCRI','OPE_NOMOPE','GRU_CODIGO'],
                   '',
                   'GRU_COMPRA',
                   Self.Name,
                   'Consulta de Grupos de Compra',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'GRU_CODIGO') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('GRU_CODIGO').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('GRU_CODIGO').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('GRU_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 3)
            Else
              edtCodigo.Text := fStrZero('0', 3);
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

function fPesqEnquadramentoIPI(Self     : TForm;                       {* Formulário                                  *}
                               edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                               edtDescri: TEditFocus;                  {* Edit da Descrição                           *}
                               qryTabela: TUniQuery;                   {* Query                                       *}
                               Var chrKey: Char;                       {* Key                                         *}
                               Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                               blnConSim: Boolean = True;              {* Consulta Simples ou Múltipla (multi select) *}
                               strGrupoCST: String = '*'): Boolean;    {* Grupo do CST desejado - '*' para TODOS      *}
  Var
    strSQL,
    strWhere : String;
    qryConsulta: TUniQuery;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE     ';
      strSQL := strSQL + '  EQI_CODIGO,           ';
      strSQL := strSQL + '  EQI_GRUCST,           ';
      strSQL := strSQL + '  EQI_DESCRI,           ';
      strSQL := strSQL + '  AUTOINCREM            ';
      strSQL := strSQL + 'FROM                    ';
      strSQL := strSQL + '  ENQIPI                ';

      strWhere := '';
      strWhere := strWhere + 'WHERE  ';
      strWhere := strWhere + '  TRUE ' ;
      If (strGrupoCST='I') Then
        strWhere := strWhere + '  AND EQI_GRUCST = ' + QuotedStr('Isenção');
      If (strGrupoCST='M') Then
        strWhere := strWhere + '  AND EQI_GRUCST = ' + QuotedStr('Imunidade');
      If (strGrupoCST='S') Then
        strWhere := strWhere + '  AND EQI_GRUCST = ' + QuotedStr('Suspensão');

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL, strWhere],                                    //arrSQL
                  ['Código',
                   'Grupo CST',
                   'Descrição',
                   'AUTOINCREM'],                                         //arrCampos
                   ['EQI_CODIGO','EQI_DESCRI','EQI_GRUCST'],              //arrOrdenação
                   '',                                                    //strCampoChave
                   'ENQIPI',                                              //strTabela
                   Self.Name,                                             //strNomForm
                   'Consulta de Códigos de Enquadramento de IPI',         //strTítulo
                   qryConsulta,                                           //qryAux
                   Nil,                                                   //objFrmPnl
                   blnConSim,                                             //blnSimples
                   arrSel,                                                //arrSelec
                   'EQI_CODIGO') Then                                     //strCodBusca
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('EQI_CODIGO').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('EQI_CODIGO').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('EQI_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 3)
            Else
              edtCodigo.Text := fStrZero('0', 3);
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


{*******************************}
{* CONSULTA DE GRUPO DE UNIDADE*}
{****************************RV*}
function fPesqGrupoUnidade(Self     : TForm;                       {* Formulário                                  *}
                           edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                           edtDescri: TEditFocus;                  {* Edit da Descrição                           *}
                           qryTabela: TUniQuery;                   {* Query                                       *}
                           Var chrKey: Char;                       {* Key                                         *}
                           Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                           blnConSim: Boolean = True): Boolean;    {* Consulta Simples ou Múltipla (multi select) *}
  Var
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
      strSQL := strSQL + '  GUN_CODIGO, ';
      strSQL := strSQL + '  GUN_DESCRI, ';
      strSQL := strSQL + '  AUTOINCREM  ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADGUN ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Código',
                   'Descrição',
                   'AUTOINCREM'],
                   ['GUN_DESCRI','GUN_CODIGO'],
                   '',
                   'CADGUN',
                   Self.Name,
                   'Consulta de Grupos de Unidade',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'GUN_CODIGO') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('GUN_CODIGO').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('GUN_CODIGO').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('GUN_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 3)
            Else
              edtCodigo.Text := fStrZero('0', 3);
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

{*********************************}
{* CONSULTA DE KM RODADO VEÍCULO *}
{******************************RV*}
function fPesqKmRodadoVeic(Self     : TForm;                      {* Formulário                                  *}
                           edtCodigo: TCustomEdit;                {* Edit do Código                              *}
                           edtDescri: TEditFocus;                 {* Edit da Descrição                           *}
                           qryTabela: TUniQuery;                    {* Query                                       *}
                           Var chrKey: Char;                      {* Key                                         *}
                           Var arrSel: TConsultasArray;           {* Array de Seleção                            *}
                           blnConSim: Boolean = True): Boolean;   {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
    objConsulta: TDefMascaraKmRodado;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  KMT_PLAVEI,       ';
      strSQL := strSQL + '  MAR_DESMAR,       ';
      strSQL := strSQL + '  MOD_DESMOD,       ';
      strSQL := strSQL + '  COR_DESCOR,       ';
      strSQL := strSQL + '  KMT_DTACAD,       ';
      strSQL := strSQL + '  KMT_KMTINI,       ';
      strSQL := strSQL + '  KMT_KMTFIN,       ';
      strSQL := strSQL + '  KMT_ABAVLR,       ';
      strSQL := strSQL + '  KMT_ABALIT,       ';
      strSQL := strSQL + '  MOT_NOMMOT,       ';
      strSQL := strSQL + '  KMT_TIPLAN,       ';
      strSQL := strSQL + '  KMT_MANVLR,       ';
      strSQL := strSQL + '  KMT_SEQABA,       ';
      strSQL := strSQL + '  ABA_CODFOR,       ';
      strSQL := strSQL + '  FOR_NOMFOR,       ';
      strSQL := strSQL + '  MANKMT.AUTOINCREM ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  MANKMT            ';
      strSQL := strSQL + '  LEFT JOIN CADVEI ON VEI_PLAVEI = KMT_PLAVEI ';
      strSQL := strSQL + '  LEFT JOIN CADMOT ON MOT_CODMOT = KMT_CODMOT ';
      strSQL := strSQL + '  LEFT JOIN CORVEI ON VEI_CODCOR = COR_CODCOR ';
      strSQL := strSQL + '  LEFT JOIN MARVEI ON VEI_CODMAR = MAR_CODMAR ';
      strSQL := strSQL + '  LEFT JOIN MODVEI ON VEI_CODMOD = MOD_CODMOD ';
      strSQL := strSQL + '  LEFT JOIN AUTABA ON ABA_SEQABA = KMT_SEQABA ';
      strSQL := strSQL + '  LEFT JOIN CADFOR ON FOR_CODFOR = ABA_CODFOR ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      objConsulta := TDefMascaraKmRodado.Create;
      objConsulta.pFormataDecimal('KMT_ABALIT', 3);

      If fConsulta([strSQL],
                  ['Placa',
                   'Marca',
                   'Modelo',
                   'Cor',
                   'Data',
                   'Km Inicial',
                   'Km Final',
                   'Valor Abast.',
                   'Litros Abast.',
                   'Motorista',
                   'Tipo Lanç.',
                   'Valor Manut.',
                   'Seq.',
                   'Cod.Fornecedor',
                   'Nome Fornecedor',
                   'AUTOINCREM'],
                   ['KMT_PLAVEI','MAR_DESMAR','MOD_DESMOD','ABA_CODFOR','FOR_NOMFOR'],
                   '',
                   'MANKMT',
                   Self.Name,
                   'Consulta de Manutenção de Km Rodados',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'KMT_PLAVEI',
                   objConsulta) Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('KMT_PLAVEI').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('KMT_PLAVEI').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := fRetornaDescricaoVeic(qryConsulta.FieldByName('KMT_PLAVEI').AsString);

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 7)
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

      FreeAndNil(objConsulta);

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

function fPesqCotacaoMoeda(Self     : TForm;                      {* Formulário                                  *}
                           edtCodigo: TCustomEdit;                {* Edit do Código                              *}
                           edtDescri: TEditFocus;                 {* Edit da Descrição                           *}
                           qryTabela: TUniQuery;                  {* Query                                       *}
                           Var chrKey: Char): Boolean;
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
    objConsulta: TDefConsulta;
    arrTitCol  : TColunasArray; {* Títulos das Colunas  *}
    arrSel     : TConsultasArray;

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
      objConsulta := TDefConsulta.Create;

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  MOE_DTAMOE, ';      pAddNomeColuna('Data');
      strSQL := strSQL + '  MOE_DOLCOM, ';      pAddNomeColuna('US$ - Compra');
      strSQL := strSQL + '  MOE_DOLVEN, ';      pAddNomeColuna('US$ - Venda');

      If fSetaPais = opcParaguai Then
      Begin
        strSQL := strSQL + '  MOE_REACOM, ';    pAddNomeColuna('R$ - Compra');
        strSQL := strSQL + '  MOE_REAVEN, ';    pAddNomeColuna('R$ - Venda');

        objConsulta.pFormataDecimal('MOE_REACOM', 4);
        objConsulta.pFormataDecimal('MOE_REAVEN', 4);
      End
      Else
      Begin
        strSQL := strSQL + '  MOE_GUACOM, ';    pAddNomeColuna('G$ - Compra');
        strSQL := strSQL + '  MOE_GUAVEN, ';    pAddNomeColuna('G$ - Venda');

        objConsulta.pFormataDecimal('MOE_GUACOM', 4);
        objConsulta.pFormataDecimal('MOE_GUAVEN', 4);
      End;

      strSQL := strSQL + '  MOE_PARCOM, ';      pAddNomeColuna('P$ - Compra');
      strSQL := strSQL + '  MOE_PARVEN, ';      pAddNomeColuna('P$ - Venda');
      strSQL := strSQL + '  MOE_EURCOM, ';      pAddNomeColuna('E$ - Compra');
      strSQL := strSQL + '  MOE_EURVEN, ';      pAddNomeColuna('E$ - Venda');
      strSQL := strSQL + '  MOE_CODEMP, ';      pAddNomeColuna('Cód.Emp.');
      strSQL := strSQL + '  EMP_NOMEMP, ';      pAddNomeColuna('Nome Empresa');
      strSQL := strSQL + '  CADMOE.AUTOINCREM  ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADMOE ';
      strSQL := strSQL + '  INNER JOIN CADEMP ON MOE_CODEMP = EMP_CODEMP ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      objConsulta.pFormataDecimal('MOE_DOLCOM', 4);
      objConsulta.pFormataDecimal('MOE_DOLVEN', 4);

      objConsulta.pFormataDecimal('MOE_PARCOM', 4);
      objConsulta.pFormataDecimal('MOE_PARVEN', 4);
      objConsulta.pFormataDecimal('MOE_EURCOM', 4);
      objConsulta.pFormataDecimal('MOE_EURVEN', 4);

      If fConsulta([strSQL],
                  arrTitCol,
                   ['MOE_DTAMOE','MOE_CODEMP'],
                   '',
                   'CADMOE',
                   Self.Name,
                   'Consulta de Cotação de Moedas',
                   qryConsulta,
                   Nil,
                   True,
                   arrSel,
                   'AUTOINCREM',
                   objConsulta) Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('MOE_DTAMOE').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('MOE_DTAMOE').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := fRetornaDescricaoVeic(qryConsulta.FieldByName('MOE_DTAMOE').AsString);

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

{***********************************}
{* CONSULTA DE EMITENTE DE CHEQUES *}
{********************************RV*}
function fPesqEmitCheques(Self     : TForm;                       {* Formulário                                  *}
                          edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                          edtDescri: TEditFocus;                  {* Edit da Descrição                           *}
                          qryTabela: TUniQuery;                     {* Query                                       *}
                          Var chrKey: Char;                       {* Key                                         *}
                          Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                          blnConSim: Boolean = True): Boolean;    {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
    objConsulta: TDefConsulta;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  EMI_C_G_C_,       ';
      strSQL := strSQL + '  EMI_NOMEMI,       ';
      strSQL := strSQL + '  EMI_ENDERE,       ';
      strSQL := strSQL + '  EMI_TELE01,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  CADEMI            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      objConsulta := TDefConsulta.Create;
      objConsulta.pIncluiCamposFone(['EMI_TELE01']);

      If fConsulta([strSQL],
                  ['Código',
                   'Nome',
                   'Endereço',
                   'Telefone',
                   'AUTOINCREM'],
                   ['EMI_NOMEMI','EMI_C_G_C_'],
                   '',
                   'CADEMI',
                   Self.Name,
                   'Consulta de Emitente de Cheques',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'EMI_C_G_C_',
                   objConsulta) Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('EMI_C_G_C_').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('EMI_C_G_C_').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('EMI_NOMEMI').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 18)
            Else
              edtCodigo.Text := fStrZero('0', 18);
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';

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

{***********************************}
{* CONSULTA DE GRUPO DE OPERADORES *}
{********************************RV*}
function fPesqGrupoOperador(Self     : TForm;                     {* Formulário                                  *}
                            edtCodigo: TCustomEdit;               {* Edit do Código                              *}
                            edtDescri: TEditFocus;                {* Edit da Descrição                           *}
                            qryTabela: TUniQuery;                   {* Query                                       *}
                            Var chrKey: Char;                     {* Key                                         *}
                            Var arrSel: TConsultasArray;          {* Array de Seleção                            *}
                            blnConSim: Boolean = True): Boolean;  {* Consulta Simples ou Múltipla (multi select) *}
  Var
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
      strSQL := strSQL + '  GPO_CODGPO,       ';
      strSQL := strSQL + '  GPO_DESCRI,       ';
      strSQL := strSQL + '  GPO_DTACAD,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  CADGPO            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Código',
                   'Descrição'],
                   ['GPO_DESCRI','GPO_CODGPO'],
                   '',
                   'CADGPO',
                   Self.Name,
                   'Consulta de Grupo de Operador',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'GPO_CODGPO') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('GPO_CODGPO').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('GPO_CODGPO').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('GPO_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 11)
            Else
              edtCodigo.Text := fStrZero('0', 11);
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

function fPesqCadAdendo(Self     : TForm;                    {* Formulário                                  *}
                        edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                        edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                        qryTabela: TUniQuery;                  {* Query                                       *}
                        Var chrKey: Char;                    {* Key                                         *}
                        Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                        blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}
  Var
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
      strSQL := strSQL + '  ADE_CODADE,       ';
      strSQL := strSQL + '  ADE_DESCRI,       ';
      strSQL := strSQL + '  ADE_TEXTO_,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  CADADE            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Código',
                   'Descrição'],
                   ['ADE_CODADE'],
                   '',
                   'CADADE',
                   Self.Name,
                   'Consulta de Adendos para Faturamento de Serviços',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel) Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('ADE_CODADE').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('ADE_CODADE').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := FloatToStr(qryConsulta.FieldByName('ADE_DESCRI').AsFloat);

        If (Length(arrSel) > 1) Then
        Begin

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

function fPesqLocSep(Self     : TForm;                            {* Formulário                                  *}
                     edtCodigo: TCustomEdit;                      {* Edit do Código                              *}
                     edtDescri: TEditFocus;                       {* Edit da Descrição                           *}
                     qryTabela: TUniQuery;                        {* Query                                       *}
                     Var chrKey: Char;                            {* Key                                         *}
                     Var arrSel: TConsultasArray;                 {* Array de Seleção                            *}
                     blnConSim: Boolean = True): Boolean;         {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE   ';
      strSQL := strSQL + '  CADLSE.LSE_CODIGO,  ';
      strSQL := strSQL + '  CADLSE.LSE_DESCRI,  ';
      strSQL := strSQL + '  CADLSE.AUTOINCREM   ';
      strSQL := strSQL + 'FROM                  ';
      strSQL := strSQL + '  CADLSE              ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Código',
                   'Descrição',
                   'AUTOINCREM'],
                   ['LSE_DESCRI','LSE_CODIGO'],
                   '',
                   'CADLSE',
                   Self.Name,
                   'Consulta de Localização de Separação',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'LSE_CODIGO') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('LSE_CODIGO').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('LSE_CODIGO').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('LSE_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', Length(qryConsulta.FieldByName('LSE_CODIGO').AsString))
            Else
              edtCodigo.Text := fStrZero('0', Length(qryConsulta.FieldByName('LSE_CODIGO').AsString));
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
End;

{*****************************}
{* CONSULTA DE FERIADOS      *}
{**************************RV*}
function fPesqFeriados(Self     : TForm;                          {* Formulário                                  *}
                       edtCodigo: TCustomEdit;                    {* Edit do Código                              *}
                       edtDescri: TEditFocus;                     {* Edit da Descrição                           *}
                       qryTabela: TUniQuery;                        {* Query                                       *}
                       Var chrKey: Char): Boolean;                {* Key                                         *}
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
    arrFeriados: TConsultasArray;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  FER_DTAFER,       ';
      strSQL := strSQL + '  FER_DESCRI,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  CADFER            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Data',
                   'Descrição'],
                   ['FER_DESCRI','FER_DTAFER'],
                   '',
                   'CADFER',
                   Self.Name,
                   'Consulta de Feriados',
                   qryConsulta,
                   Nil,
                   True,
                   arrFeriados,
                   'FER_DTAFER') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('FER_DTAFER').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('FER_DTAFER').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('FER_DESCRI').AsString;

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

{***************************************}
{* CONSULTA DE IRREGULARIDADES FISCAIS *}
{************************************RV*}
function fPesqIrregFiscal(Self     : TForm;                       {* Formulário                                  *}
                          edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                          edtDescri: TEditFocus;                  {* Edit da Descrição                           *}
                          qryTabela: TUniQuery;                     {* Query                                       *}
                          Var chrKey: Char): Boolean;             {* Key                                         *}
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
    arrIrregFis: TConsultasArray;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  IRR_CODIRR,       ';
      strSQL := strSQL + '  IRR_DESIRR,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  CADIRR            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Código',
                   'Descrição'],
                   ['IRR_DESIRR','IRR_CODIRR'],
                   '',
                   'CADIRR',
                   Self.Name,
                   'Consulta de Irregularidades Fiscais',
                   qryConsulta,
                   Nil,
                   True,
                   arrIrregFis,
                   'IRR_CODIRR') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('IRR_CODIRR').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('IRR_CODIRR').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('IRR_DESIRR').AsString;

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

{*****************************}
{* CONSULTA DE VERBAS        *}
{**************************RV*}
function fPesqVerbas(Self     : TForm;                            {* Formulário                                  *}
                     edtCodigo: TCustomEdit;                      {* Edit do Código                              *}
                     edtDescri: TEditFocus;                       {* Edit da Descrição                           *}
                     qryTabela: TUniQuery;                          {* Query                                       *}
                     Var chrKey: Char;                            {* Key                                         *}
                     Var arrSel: TConsultasArray;                 {* Array de Seleção                            *}
                     blnConSim: Boolean = True): Boolean;         {* Consulta Simples ou Múltipla (multi select) *}
  Var
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
      strSQL := strSQL + '  VER_CODVER,       ';
      strSQL := strSQL + '  VER_DESVER,       ';
      strSQL := strSQL + '  VER_DEBCRE,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  CADVER            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Código',
                   'Descrição',
                   'D/C',
                   'AUTOINCREM'],
                   ['VER_DESVER','VER_CODVER'],
                   '',
                   'CADVER',
                   Self.Name,
                   'Consulta de Verbas',
                   qryConsulta,
                   Nil,
                   FALSE,//blnConSim,
                   arrSel,
                   'VER_CODVER') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('VER_CODVER').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('VER_CODVER').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('VER_DESVER').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 3)
            Else
              edtCodigo.Text := fStrZero('0', 3);
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

function fPesqVerbasCliFor(Self     : TForm;                            {* Formulário                                  *}
                           edtCodigo: TCustomEdit;                      {* Edit do Código                              *}
                           qryTabela: TUniQuery;                        {* Query                                       *}
                           Var chrKey: Char;                            {* Key                                         *}
                           Var arrSel: TConsultasArray;                 {* Array de Seleção                            *}
                           blnConSim: Boolean = True): Boolean;         {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + ' SELECT CADVBA.VBA_CODVBA, ';
      strSQL := strSQL + '        CADVBA.VBA_DTALAN, ';
      strSQL := strSQL + '        FOR_NOMFOR, ';
      strSQL := strSQL + '        CLI_NOMCLI, ';
      strSQL := strSQL + '        OPE_NOMOPE, ';
      strSQL := strSQL + '        CADVBA.VBA_VALVBA, ';
      strSQL := strSQL + '        CADVBA.VBA_VALMIN, ';
      strSQL := strSQL + '        MOTVBA.VBA_DESMOT, ';
      strSQL := strSQL + '        CADVBA.AUTOINCREM ';
      strSQL := strSQL + '   FROM CADVBA ';
      strSQL := strSQL + '  INNER JOIN MOTVBA ON MOTVBA.VBA_CODMOT = CADVBA.VBA_CODMOT ';
      strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = CADVBA.VBA_CODCLI ';
      strSQL := strSQL + '  INNER JOIN CADOPE ON OPE_CODOPE = CADVBA.VBA_CODVEN ';
      strSQL := strSQL + '  INNER JOIN CADFOR ON FOR_CODFOR = CADVBA.VBA_CODFOR ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                   ['Código da Verba',
                    'Data Lancto',
                    'Fornecedor',
                    'Cliente',
                    'Vendedor',
                    'Valor da Verba',
                    'Valor Mínimo',
                    'Motivo',
                    'AUTOINCREM'],
                   ['VBA_DTALAN', 'VBA_CODVBA', 'FOR_NOMFOR', 'CLI_NOMCLI',
                    'OPE_NOMOPE', 'VBA_VALVBA', 'VBA_VALMIN', 'VBA_DESMOT'],
                   '',
                   'CADVBA',
                   Self.Name,
                   'Consulta de Verbas - Cliente/Fornecedor',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'VBA_CODVBA') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('VBA_CODVBA').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('VBA_CODVBA').AsString;
        End;

        If (Length(arrSel) > 1) Then
        Begin
          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 3)
            Else
              edtCodigo.Text := fStrZero('0', 3);
          End;
        End;

        Result := True;
      End;

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);
    Except
      On E: Exception Do
        pMensagensErro(E.Message, 'untConsultas.fPesqVerbasCliFor');
    End;
  End;
end;

{********************************}
{* CONSULTA DE CLUBE FIDELIDADE *}
{*****************************RV*}
function fPesqFidelidade(Self     : TForm;                      {* Formulário                                  *}
                         edtCodigo: TCustomEdit;                {* Edit do Código                              *}
                         qryTabela: TUniQuery;                    {* Query                                       *}
                         Var chrKey: Char;                      {* Key                                         *}
                         Var arrSel: TConsultasArray;           {* Array de Seleção                            *}
                         blnConSim: Boolean = True): Boolean;   {* Consulta Simples ou Múltipla (multi select) *}
  Var
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
      strSQL := strSQL + '  FID_CODFID,       ';
      strSQL := strSQL + '  FID_DTACAD,       ';
      strSQL := strSQL + '  FID_NUMDOC,       ';
      strSQL := strSQL + '  FID_ESPDOC,       ';
      strSQL := strSQL + '  FID_CODEMP,       ';
      strSQL := strSQL + '  FID_CODCLI,       ';
      strSQL := strSQL + '  CLI_NOMCLI,       ';
      strSQL := strSQL + '  FID_CREDEB,       ';
      strSQL := strSQL + '  FID_QTDPTO,       ';
      strSQL := strSQL + '  CLUFID.AUTOINCREM ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  CLUFID            ';
      strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = FID_CODCLI ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Código',
                   'Dt. Cad.',
                   'Documento',
                   'Esp.',
                   'Emp.',
                   'Cód. Cliente',
                   'Nome Cliente',
                   'D/C',
                   'Pontos',
                   'AUTOINCREM'],
                   ['FID_NUMDOC','CLI_NOMCLI','FID_CODCLI','FID_CODFID'],
                   '',
                   'CLUFID',
                   Self.Name,
                   'Consulta de Clube de Fidelidade',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'FID_CODFID') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('FID_CODFID').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('FID_CODFID').AsString;
        End;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 6)
            Else
              edtCodigo.Text := fStrZero('0', 6);
          End;

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

{*******************************}
{* CONSULTA DE GRUPO DE PREÇOS *}
{****************************RV*}
function fPesqGrupoPrecos(Self     : TForm;                       {* Formulário                                  *}
                          edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                          edtDescri: TEditFocus;                  {* Edit da Descrição                           *}
                          qryTabela: TUniQuery;                     {* Query                                       *}
                          Var chrKey: Char;                       {* Key                                         *}
                          Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                          blnConSim: Boolean = True): Boolean;    {* Consulta Simples ou Múltipla (multi select) *}
  Var
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
      strSQL := strSQL + '  GPR_CODIGO,       ';
      strSQL := strSQL + '  GPR_DESCRI,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  CADGPR            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Código',
                   'Descrição',
                   'AUTOINCREM'],
                   ['GPR_DESCRI','GPR_CODIGO'],
                   '',
                   'CADGPR',
                   Self.Name,
                   'Consulta de Grupo de Preços',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'GPR_CODIGO') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('GPR_CODIGO').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('GPR_CODIGO').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('GPR_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 6)
            Else
              edtCodigo.Text := fStrZero('0', 6);
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

function fPesqMotReprovacao(Self      : TForm;                       {* Formulário                                  *}
                            edtCodigo : TCustomEdit;                 {* Edit do Código                              *}
                            edtDescri : TEditFocus;                  {* Edit da Descrição                           *}
                            qryTabela : TUniQuery;                   {* Query                                       *}
                            Var chrKey: Char;                       {* Key                                         *}
                            Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                            blnConSim : Boolean = True): Boolean;    {* Consulta Simples ou Múltipla (multi select) *}
  Var
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
      strSQL := strSQL + '  MRE_CODIGO,       ';
      strSQL := strSQL + '  MRE_DESCRI,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  CADMRE            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Código',
                   'Motivo',
                   'AUTOINCREM'],
                   ['MRE_DESCRI','MRE_CODIGO'],
                   '',
                   'CADMRE',
                   Self.Name,
                   'Consulta de Motivo de Reprovação',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'MRE_CODIGO') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('MRE_CODIGO').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('MRE_CODIGO').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('MRE_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 3)
            Else
              edtCodigo.Text := fStrZero('0', 3);
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

function fPesqDefeito(Self      : TForm;                    {* Formulário                                  *}
                      edtCodigo : TCustomEdit;              {* Edit do Código                              *}
                      edtDescri : TEditFocus;               {* Edit da Descrição                           *}
                      qryTabela : TUniQuery;                {* Query                                       *}
                      Var chrKey: Char;                     {* Key                                         *}
                      Var arrSel: TConsultasArray;          {* Array de Seleção                            *}
                      blnConSim : Boolean = True;           {* Consulta Simples ou Múltipla (multi select) *}
                      objFrmPnl : TPanelCx = Nil): Boolean; {* Painel}
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
    objConsulta: TDefConsultaDefeito;
    arrColunas, arrTitColunas : Array of String;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      objConsulta := TDefConsultaDefeito.Create;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';

      If Assigned(objFrmPnl) And Assigned(objFrmPnl.sltLista) And Assigned(objFrmPnl.fncTeclaTab) Then Begin
        strSQL := strSQL + ' VENDIDO, ';

        objConsulta.pIncluiSubConsulta('VENDIDO', 'CAST(IF(LOCATE(DFE_CODIGO, :LISTA) > 0, 1, NULL) AS UNSIGNED)');
        objConsulta.pIncluiIcone('VENDIDO', 0, 0);
        objConsulta.pIncluiIcone('VENDIDO', 1, 1);

        arrTitColunas := ['TAB', 'Código', 'Defeito', 'AUTOINCREM'];

        If Assigned(objFrmPnl) Then
          TDefConsultaDefeito(objConsulta).sltDefeitos := objFrmPnl.sltLista;
      End Else Begin
        arrTitColunas := ['Código', 'Defeito', 'AUTOINCREM'];
      End;

      arrColunas := ['DFE_DESCRI', 'DFE_CODIGO'];

      strSQL := strSQL + '  DFE_CODIGO,       ';
      strSQL := strSQL + '  DFE_DESCRI,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  CADDFE            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                   arrTitColunas,
                   arrColunas,
                   '',
                   'CADDFE',
                   Self.Name,
                   'Consulta de Defeitos',
                   qryConsulta,
                   objFrmPnl,
                   blnConSim,
                   arrSel,
                   'DFE_CODIGO',
                   objConsulta,
                   False,
                   False,
                   '',
                   Nil,
                   True,
                   True,
                   True,
                   Nil,
                   Nil,
                   nil,
                   VS_Application) Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('DFE_CODIGO').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('DFE_CODIGO').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('DFE_DESCRI').AsString;

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

        If Assigned(objConsulta) Then
          FreeAndNil(objConsulta);
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

function fPesqEquipamento(Self      : TForm;                       {* Formulário                                  *}
                          edtCodigo : TCustomEdit;                 {* Edit do Código                              *}
                          edtDescri : TEditFocus;                  {* Edit da Descrição                           *}
                          qryTabela : TUniQuery;                   {* Query                                       *}
                          Var chrKey: Char;                       {* Key                                         *}
                          Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                          blnConSim : Boolean = True): Boolean;    {* Consulta Simples ou Múltipla (multi select) *}
  Var
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
      strSQL := strSQL + '  EQU_CODIGO,       ';
      strSQL := strSQL + '  EQU_DESCRI,       ';
      strSQL := strSQL + '  MAR_DESMAR,       ';
      strSQL := strSQL + '  ITE_DESITE,       ';
      strSQL := strSQL + '  EQU_VOLTAG,       ';
      strSQL := strSQL + '  EQU_AUTORI,       ';
      strSQL := strSQL + '  CADEQU.AUTOINCREM ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  CADEQU LEFT JOIN CADMAR ON EQU_CODMAR = MAR_CODMAR ';
      strSQL := strSQL + '         LEFT JOIN CADITE ON EQU_CODITE = ITE_CODITE ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Código',
                   'Equipamento',
                   'Marca',
                   'Produto',
                   'Voltagem',
                   'Assis. Autorizada',
                   'AUTOINCREM'],
                   ['EQU_DESCRI','EQU_CODIGO'],
                   '',
                   'CADEQU',
                   Self.Name,
                   'Consulta de Equipamentos',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'EQU_CODIGO') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('EQU_CODIGO').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('EQU_CODIGO').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('EQU_DESCRI').AsString;

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

{**********************}
{* CONSULTA DE MARCAS *}
{*******************DP*}
function fPesqMarcas(Self     : TForm;                    {* Formulário                                  *}
                     edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                     edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                     qryTabela: TUniQuery;                {* Query                                       *}
                     Var chrKey: Char;                    {* Key                                         *}
                     Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                     blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
    objConsulta: TDefConsulta;
    arrCampos: Array of String;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE   ';
      strSQL := strSQL + '  CADMAR.MAR_CODMAR,  ';
      strSQL := strSQL + '  CADMAR.MAR_DESMAR,  ';

      If fCfgSis('ELCUCO', varBoolean) Then
        strSQL := strSQL + '  CADMAR.MAR_FATCUS,     ';

      strSQL := strSQL + '  CADMAR.AUTOINCREM   ';
      strSQL := strSQL + 'FROM                  ';
      strSQL := strSQL + '  CADMAR              ';

      If fCfgSis('ELCUCO', varBoolean) Then
      Begin
        objConsulta := TDefConsulta.Create;
        objConsulta.pFormataDecimal('MAR_FATCUS', 6);
        SetLength(arrCampos, 4);
        arrCampos[0] := 'Código';
        arrCampos[1] := 'Descrição';
        arrCampos[2] := 'Fator Elevação de Custo';
        arrCampos[3] := 'AUTOINCREM';
      End
      Else
      Begin
        SetLength(arrCampos, 3);
        arrCampos[0] := 'Código';
        arrCampos[1] := 'Descrição';
        arrCampos[2] := 'AUTOINCREM';
      End;

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                   arrCampos,
                   ['MAR_DESMAR','MAR_CODMAR'],
                   '',
                   'CADMAR',
                   Self.Name,
                   'Consulta de Marcas',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'MAR_CODMAR',
                   IIF(fCfgSis('ELCUCO', varBoolean), objConsulta, Nil)) Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('MAR_CODMAR').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('MAR_CODMAR').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('MAR_DESMAR').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', Length(qryConsulta.FieldByName('MAR_CODMAR').AsString))
            Else
              edtCodigo.Text := fStrZero('0', Length(qryConsulta.FieldByName('MAR_CODMAR').AsString));
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';

        End;

        Result := True;

        If Not Assigned(qryTabela) Then
          FreeAndNil(qryConsulta);

        If Assigned(objConsulta) Then
          FreeAndNil(objConsulta);
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

function fPesqPos(Self     : TForm;                    {* Formulário                                  *}
                  edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                  edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                  qryTabela: TUniQuery;                {* Query                                       *}
                  Var chrKey: Char;                    {* Key                                         *}
                  Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                  blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE   ';
      strSQL := strSQL + '  CADPOS.POS_CODPOS,  ';
      strSQL := strSQL + '  CADPOS.POS_DESPOS,  ';
      strSQL := strSQL + '  CADPOS.AUTOINCREM   ';
      strSQL := strSQL + 'FROM                  ';
      strSQL := strSQL + '  CADPOS              ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Código',
                   'Descrição',
                   'AUTOINCREM'],
                   ['POS_DESPOS','POS_CODPOS'],
                   '',
                   'CADPOS',
                   Self.Name,
                   'Consulta de POS',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'POS_CODPOS') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('POS_CODPOS').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('POS_CODPOS').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('POS_DESPOS').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', Length(qryConsulta.FieldByName('POS_CODPOS').AsString))
            Else
              edtCodigo.Text := fStrZero('0', Length(qryConsulta.FieldByName('POS_CODPOS').AsString));
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';

        End;

        Result := True;
      End;

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

function fPesqAdquirente(Self     : TForm;                    {* Formulário                                  *}
                         edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                         edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                         qryTabela: TUniQuery;                {* Query                                       *}
                         Var chrKey: Char;                    {* Key                                         *}
                         Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                         blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE   ';
      strSQL := strSQL + '  CADADQ.ADQ_CODADQ,  ';
      strSQL := strSQL + '  CADADQ.ADQ_NOMADQ,  ';
      strSQL := strSQL + '  CADADQ.AUTOINCREM   ';
      strSQL := strSQL + 'FROM                  ';
      strSQL := strSQL + '  CADADQ              ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Código',
                   'Nome',
                   'AUTOINCREM'],
                   ['ADQ_NOMADQ','ADQ_CODADQ'],
                   '',
                   'CADADQ',
                   Self.Name,
                   'Consulta de Adquirente',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'ADQ_CODADQ') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('ADQ_CODADQ').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('ADQ_CODADQ').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('ADQ_NOMADQ').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', Length(qryConsulta.FieldByName('ADQ_CODADQ').AsString))
            Else
              edtCodigo.Text := fStrZero('0', Length(qryConsulta.FieldByName('ADQ_CODADQ').AsString));
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';

        End;

        Result := True;
      End;

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

function fPesqMotivoVerbas(Self     : TForm;                    {* Formulário                                  *}
                           edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                           edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                           qryTabela: TUniQuery;                {* Query                                       *}
                           Var chrKey: Char;                    {* Key                                         *}
                           Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                           blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '        VBA_CODMOT, ';
      strSQL := strSQL + '        VBA_DESMOT, ';
      strSQL := strSQL + '        AUTOINCREM ';
      strSQL := strSQL + '   FROM MOTVBA ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Código do Motivo',
                   'Motivo',
                   'AUTOINCREM'],
                   ['VBA_DESMOT','VBA_CODMOT'],
                   '',
                   'MOTVBA',
                   Self.Name,
                   'Consulta de Motivo de Verbas',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'VBA_CODMOT') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('VBA_CODMOT').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('VBA_CODMOT').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('VBA_DESMOT').AsString;

        If (Length(arrSel) > 1) Then
        Begin
          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', Length(qryConsulta.FieldByName('VBA_CODMOT').AsString))
            Else
              edtCodigo.Text := fStrZero('0', Length(qryConsulta.FieldByName('VBA_CODMOT').AsString));
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';
        End;

        Result := True;
      End;

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);
    Except
      On E: Exception Do
        pMensagensErro(E.Message, 'untConsultas.fPesqMotivoVerbas');
    End;
  End;
end;

function fPesqTabelaPreco(Self     : TForm;                    {* Formulário                                  *}
                          edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                          edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                          qryTabela: TUniQuery;                  {* Query                                       *}
                          Var chrKey: Char;                    {* Key                                         *}
                          Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                          blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE  ';
      strSQL := strSQL + '  TAB_CODTAB,        ';
      strSQL := strSQL + '  TAB_NOMTAB,        ';
      strSQL := strSQL + '  TAB_CODFOR,        ';
      strSQL := strSQL + '  FOR_NOMFOR,        ';
      strSQL := strSQL + '  TAB_ATICMP,        ';
      strSQL := strSQL + '  TAB_DTACAD,        ';
      strSQL := strSQL + '  T.AUTOINCREM       ';
      strSQL := strSQL + 'FROM                 ';
      strSQL := strSQL + '  TABPRE T           ';
      strSQL := strSQL + 'INNER JOIN CADFOR ON FOR_CODFOR = TAB_CODFOR ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Código',
                   'Nome',
                   'Fornecedor',
                   'Nome Fornecedor',
                   'Ativo compras',
                   'Cadastro'],
                   ['TAB_NOMTAB','FOR_NOMFOR','TAB_CODFOR','TAB_CODTAB'],
                   '',
                   'TABPRE',
                   Self.Name,
                   'Consulta de Tabelas de Preços',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'TAB_CODTAB') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('TAB_CODTAB').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('TAB_CODTAB').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('TAB_NOMTAB').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 6)
            Else
              edtCodigo.Text := fStrZero('0', 6);
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';

        End;

        Result := True;
      End;
      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

function fPesqTipoServico(Self     : TForm;                          {* Formulário                                  *}
                          edtCodigo: TCustomEdit;                    {* Edit do Código                              *}
                          edtDescri: TEditFocus;                     {* Edit da Descrição                           *}
                          qryTabela: TUniQuery;                        {* Query                                       *}
                          Var chrKey: Char;                          {* Key                                         *}
                          Var arrSel: TConsultasArray;               {* Array de Seleção                            *}
                          blnConSim: Boolean = True): Boolean;       {* Consulta Simples ou Múltipla (multi select) *}
  Var
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
      strSQL := strSQL + '  TPS_CODIGO,       ';
      strSQL := strSQL + '  TPS_DESCRI,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  TIPSER            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Código',
                   'Descrição',
                   'AUTOINCREM'],
                   ['TPS_DESCRI','TPS_CODIGO'],
                   '',
                   'TIPSER',
                   Self.Name,
                   'Consulta de Tipos de Serviço',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'TPS_CODIGO') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('TPS_CODIGO').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('TPS_CODIGO').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('TPS_DESCRI').AsString;

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

function fPesqParceiro(Self     : TForm;                          {* Formulário                                  *}
                       edtCodigo: TCustomEdit;                    {* Edit do Código                              *}
                       edtDescri: TEditFocus;                     {* Edit da Descrição                           *}
                       qryTabela: TUniQuery;                        {* Query                                       *}
                       Var chrKey: Char;                          {* Key                                         *}
                       Var arrSel: TConsultasArray;               {* Array de Seleção                            *}
                       blnConSim: Boolean = True): Boolean;       {* Consulta Simples ou Múltipla (multi select) *}
  Var
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
      strSQL := strSQL + '  PAR_CODPAR,       ';
      strSQL := strSQL + '  PAR_NOMPAR,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  CADPAR            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Código',
                   'Nome',
                   'AUTOINCREM'],
                   ['PAR_CODPAR','PAR_NOMPAR'],
                   '',
                   'CADPAR',
                   Self.Name,
                   'Consulta de Parceiros - Serviço',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'PAR_CODPAR') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('PAR_CODPAR').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('PAR_CODPAR').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('PAR_NOMPAR').AsString;

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

function fPesqStatusServico(Self     : TForm;                          {* Formulário                                  *}
                            edtCodigo: TCustomEdit;                    {* Edit do Código                              *}
                            edtDescri: TEditFocus;                     {* Edit da Descrição                           *}
                            qryTabela: TUniQuery;                        {* Query                                       *}
                            Var chrKey: Char;                          {* Key                                         *}
                            Var arrSel: TConsultasArray;               {* Array de Seleção                            *}
                            blnConSim: Boolean = True): Boolean;       {* Consulta Simples ou Múltipla (multi select) *}
  Var
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
      strSQL := strSQL + '  STS_CODIGO,       ';
      strSQL := strSQL + '  STS_DESCRI,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  STASER            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Código',
                   'Descrição',
                   'AUTOINCREM'],
                   ['STS_DESCRI','STS_CODIGO'],
                   '',
                   'STASER',
                   Self.Name,
                   'Consulta de Status do Serviço',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'STS_CODIGO') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('STS_CODIGO').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('STS_CODIGO').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('STS_DESCRI').AsString;

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

{*****************************}
{* CONSULTA DE SERVIÇOS      *}
{**************************RV*}
function fPesqServicos(Self     : TForm;                          {* Formulário                                  *}
                       edtCodigo: TCustomEdit;                    {* Edit do Código                              *}
                       edtDescri: TEditFocus;                     {* Edit da Descrição                           *}
                       qryTabela: TUniQuery;                      {* Query                                       *}
                       Var chrKey: Char;                          {* Key                                         *}
                       Var arrSel: TConsultasArray;               {* Array de Seleção                            *}
                       blnConSim: Boolean = True;                 {* Consulta Simples ou Múltipla (multi select) *}
                       blnAutCen: Boolean = False;                {* Se CFG_AUTCEN = "S"                         *}
                       objFrmPnl: TPanelCx = Nil;                 {* Painel exibindo a aplicação                 *}
                       blnCadSer: Boolean = False                 {* Chamou através do cadastro de serviço?      *}
                      ): Boolean;
  Var
    strSQL     : String;
    arrTitCol  : TColunasArray; {* Títulos das Colunas  *}
    qryConsulta: TUniQuery;
    arrOrd     : Array of String;
    strWhere   : String;
    blnUsaDesc : Boolean;
    objConsulta: TDefConsultaServico;

    Procedure pAddNomeColuna(strNomCol: String);
    Begin
      SetLength(arrTitCol, Succ(Length(arrTitCol)));
      arrTitCol[High(arrTitCol)] := strNomCol;
    End;
begin
  Result := False;

  blnUsaDesc := Not (fCfgSis('QTDSER', VarBoolean) Or fCfgSis('ALVLSE', VarBoolean));

  If fEntraCons(chrKey) Then
  Begin
    objConsulta := TDefConsultaServico.Create;
    Try
      chrKey := #0;

      {Req: 111535 - Foi retirado o "CAST(SER_APLICA AS CHAR(255))" para utilizar o campo SER_APLICA diretamente,
       devido a falhas na consulta por "Aplicação".}
      //objConsulta.pIncluiSubConsulta('SERAPLICA', 'CAST(SER_APLICA AS CHAR(255))');

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  SQL_NO_CACHE ';

      If Assigned(objFrmPnl) And Assigned(objFrmPnl.sltLista) And Assigned(objFrmPnl.fncTeclaTab) Then Begin
        strSQL := strSQL + ' VENDIDO, ';    pAddNomeColuna('TAB');

        objConsulta.pIncluiSubConsulta('VENDIDO', 'CAST(IF(LOCATE(SER_CODSER, :LISTA) > 0, 1, NULL) AS UNSIGNED)');
        objConsulta.pIncluiIcone('VENDIDO', 0, 0);
        objConsulta.pIncluiIcone('VENDIDO', 1, 1);

        If Assigned(objFrmPnl) Then
          TDefConsultaDefeito(objConsulta).sltDefeitos := objFrmPnl.sltLista;
      End;

      strSQL := strSQL + '  SER_CODEMP,  '; pAddNomeColuna('Cód. Empresa');
      strSQL := strSQL + '  SER_CODSER,  '; pAddNomeColuna('Código');
      strSQL := strSQL + '  SER_DESSER,  '; pAddNomeColuna('Descrição');
      strSQL := strSQL + '  GRU_DESGRU , '; pAddNomeColuna('Grupo de Serviço');

      if not fCfgSis('TRSECI', varBoolean) then
      Begin
        strSQL := strSQL + '  SER_TRIMUN,  '; pAddNomeColuna('Cód. Trib. Mun.');
        strSQL := strSQL + '  SER_CDLSSE,  '; pAddNomeColuna('Código Lista LC 116/03');
      End;

      strSQL := strSQL + '  SER_VALSER,  '; pAddNomeColuna('Valor Serviço');

      If blnUsaDesc Then
      Begin
        strSQL := strSQL + '  CONCAT(SER_DESMAX, " %") AS SER_DESMAX, ';
        pAddNomeColuna('Desconto Máximo');
      End;

      If blnAutCen Then
      begin
        strSQL := strSQL + '  SER_TERCER,  '; pAddNomeColuna('Serv. Terceirizado');
        strSQL := strSQL + '  SER_VALCUS,  '; pAddNomeColuna('Custo $');
        strSQL := strSQL + '  FOR_NOMFOR,  '; pAddNomeColuna('Fornecedor');
        strSQL := strSQL + '  CTA_DESCTA,  '; pAddNomeColuna('Plano de Contas');
        strSQL := strSQL + '  CND_DESCRI,  '; pAddNomeColuna('Cond. Pagto');

        SetLength(arrOrd, 5);

        arrOrd[0] := 'SER_DESSER';
        arrOrd[1] := 'FOR_NOMFOR';
        arrOrd[2] := 'CTA_DESCTA';
        arrOrd[3] := 'CND_DESCRI';
        arrOrd[4] := 'SER_CODSER';
      end
      else
      begin
        SetLength(arrOrd, 2);

        arrOrd[0] := 'SER_DESSER';
        arrOrd[1] := 'SER_CODSER';
      end;

      strSQL := strSQL + '  SER_APLICA, '; pAddNomeColuna('Aplicação');

      If blnCadSer Then
      Begin
        strSQL := strSQL + '  SERATIVO_, '; pAddNomeColuna('Ativo?');
        objConsulta.pIncluiSubConsulta('SERATIVO_', 'IF(IFNULL(SER_ATIVO_, "N") = "S", "Sim", "Não")');
      End;

      strSQL := strSQL + '  CADSER.AUTOINCREM ';
      strSQL := strSQL + 'FROM ';

      If Not blnAutCen Then
        strSQL := strSQL + '  CADSER '
      Else
      Begin
        strSQL := strSQL + '  CADSER LEFT JOIN CADFOR ON CADSER.SER_CODFOR = CADFOR.FOR_CODFOR ';
        strSQL := strSQL + '         LEFT JOIN CADCTA ON CADSER.SER_CODCTA = CADCTA.CTA_CODCTA ';
        strSQL := strSQL + '         LEFT JOIN CADCND ON CADSER.SER_CODCND = CADCND.CND_CODIGO ';
      End;

      strSQL := strSQL + ' LEFT JOIN GRUSER ON CADSER.SER_CODGRU = GRUSER.GRU_CODGRU ';

      strWhere := '';

      If fCfgSis('SEREMP', varBoolean) And (Not blnCadSer) Then
        strWhere := ' WHERE ((SER_CODEMP = ' + QuotedStr(VS_strCodEmp) + ') OR (SER_CODEMP IS NULL) OR (SER_CODEMP = "")) ';

      {Somente Ativos}
      If Not blnCadSer Then
      Begin
        If fEmptyStr(strWhere) Then
          strWhere := ' WHERE (SER_ATIVO_ = "S") '
        Else
          strWhere := strWhere + ' AND (SER_ATIVO_ = "S") ';
      End;

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL, strWhere],
                   arrTitCol,
                   arrOrd,
                   '',
                   'CADSER',
                   Self.Name,
                   'Consulta de Serviços',
                   qryConsulta,
                   objFrmPnl,
                   blnConSim,
                   arrSel,
                   'SER_CODSER',
                   objConsulta,
                   False,
                   False,
                   '',
                   Nil,
                   True,
                   True,
                   True,
                   Nil,
                   Nil,
                   Nil,
                   VS_Application) Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('SER_CODSER').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('SER_CODSER').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('SER_DESSER').AsString;

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

      End;
      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;

    FreeAndNil(objConsulta);
  End;
end;

{**********************************}
{* NOVA CONSULTA DE FAIXA DE PESO *}
{*******************************RV*}
function fPesqFaixaPeso(Self     : TForm;                        {* Formulário                                  *}
                         edtCodigo: TCustomEdit;                  {* Edit do Código                              *}
                         edtDescri: TEditFocus;                   {* Edit da Descrição                           *}
                         qryTabela: TUniQuery;                      {* Query                                       *}
                         Var chrKey: Char;                        {* Key                                         *}
                         Var arrSel: TConsultasArray;             {* Array de Seleção                            *}
                         blnConSim: Boolean = True): Boolean;     {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL,
    strWhere,
    strGroup   : String;
    qryConsulta: TUniQuery;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  COM_CODTAB,       ';
      strSQL := strSQL + '  COM_DESCRI,       ';
      strSQL := strSQL + '  COM_VALINI,       ';
      strSQL := strSQL + '  COM_VALFIN,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  COMPES            ';

      strWhere := '';
      strWhere := strWhere + 'WHERE TRUE          ';

      strGroup := '';
      strGroup := strGroup + 'GROUP BY COM_CODTAB ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL, strWhere, strGroup],
                  ['Código',
                   'Descrição',
                   'Valor Inicial',
                   'Valor Final',
                   'AUTOINCREM'],
                   ['COM_DESCRI','COM_CODTAB'],
                   '',
                   'COMPES',
                   Self.Name,
                   'Consulta de Faixa de Peso',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'COM_CODTAB') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('COM_CODTAB').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('COM_CODTAB').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('COM_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 6)
            Else
              edtCodigo.Text := fStrZero('0', 6);
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

{*****************************}
{* CONSULTA DE FUNCIONÁRIOS  *}
{**************************RV*}
function fPesqFuncionarios(Self     : TForm;                      {* Formulário                                  *}
                           edtCodigo: TCustomEdit;                {* Edit do Código                              *}
                           edtDescri: TEditFocus;                 {* Edit do Nome do Funcionário                 *}
                           qryTabela: TUniQuery;                  {* Query                                       *}
                           Var chrKey: Char;                      {* Key                                         *}
                           Var arrSel: TConsultasArray;           {* Array de Seleção                            *}
                           blnConSim: Boolean = True;             {* Consulta Simples ou Múltipla (multi select) *}
                           arrEmpresa: TConsultasArray = nil      {* Array da(s) empresa(s) selecionada(s)       *}
                           ;autIncrem: string = ''
                           ): Boolean;
  Var
    strSQL,
    strWhere,
    strEmpresa : String;
    qryConsulta: TUniQuery;
    objConsulta: TDefConsulta;
    intIndice  : integer;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  FUN_CODEMP,       ';
      strSQL := strSQL + '  FUN_CODFUN,       ';
      strSQL := strSQL + '  FUN_NOMFUN,       ';
      strSQL := strSQL + '  FNC_NOMFNC,       ';
      strSQL := strSQL + '  FUN_DTAADM,       ';
      strSQL := strSQL + '  FUN_SALBAS,       ';
      strSQL := strSQL + '  FUN_PISPAS,       ';
      strSQL := strSQL + '  FUN_DTADEM,       ';
      strSQL := strSQL + '  FUN_BANCO_,       ';
      strSQL := strSQL + '  FUN_AGENCI,       ';
      strSQL := strSQL + '  FUN_CONTA_,       ';
      strSQL := strSQL + '  CARPON,           ';
      strSQL := strSQL + '  REGIST,           ';
      strSQL := strSQL + '  DEMITIDO,         ';
      strSQL := strSQL + '  FUN_EMAIL_,       ';
      strSQL := strSQL + '  CADFUN.AUTOINCREM ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  CADFUN            ';
      strSQL := strSQL + 'LEFT JOIN CADFNC ON FNC_CODFNC = FUN_FUNATU ';

      strWhere := '';
      strWhere := strWhere + 'WHERE  ';
      strWhere := strWhere + '  TRUE ' ;

      if assigned(arrEmpresa) then
      begin
        strWhere := strWhere + ' AND FUN_CODEMP IN (';
        For intIndice := Low(arrEmpresa) To High(arrEmpresa) Do
        begin
          if strEmpresa <> '' then
            strEmpresa := strEmpresa + ',';
          strEmpresa := strEmpresa + arrEmpresa[intIndice].strCodigo;
        end;
        strWhere := strWhere +strEmpresa+') ';
      end;

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      objConsulta := TDefConsulta.Create;
      objConsulta.pIncluiSubConsulta('CARPON',   'IF (FUN_CARPON = "S","SIM","NÃO")');
      objConsulta.pIncluiSubConsulta('REGIST',   'IF (FUN_REGIST = "S","SIM","NÃO")');
      objConsulta.pIncluiSubConsulta('DEMITIDO', 'IF (FUN_DTADEM IS NOT NULL,"SIM","NÃO")');
      objConsulta.pIncluiCampoSimNao('CARPON');
      objConsulta.pIncluiCampoSimNao('REGIST');
      objConsulta.pIncluiCampoSimNao('DEMITIDO');

      If fConsulta([strSQL, strWhere],
                  ['Empresa',
                   'Código',
                   'Nome',
                   'Função',
                   'Dt. Admissão',
                   'Sal. Base',
                   'Pis Pasep',
                   'Dt. Demissão',
                   'Banco',
                   'Agência',
                   'Conta',
                   'Ponto OK?',
                   'Registro OK?',
                   'Demitido?',
                   'Email',
                   'AUTOINCREM'],
                   ['FUN_NOMFUN','FNC_NOMFNC','FUN_CODFUN'],
                   '',
                   'CADFUN',
                   Self.Name,
                   'Consulta de Funcionários',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'AUTOINCREM',
                   objConsulta) Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('FUN_CODFUN').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('FUN_CODFUN').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('FUN_NOMFUN').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 6)
            Else
              edtCodigo.Text := fStrZero('0', 6);
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';

        End
        else If length(arrSel) = 1 then
          autIncrem := arrSel[0].strCodigo;

        Result := True;

        If Not Assigned(qryTabela) Then
          FreeAndNil(qryConsulta);

        FreeAndNil(objConsulta);
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

{**************************************}
{* CONSULTA DE CONDIÇÕES DE PAGAMENTO *}
{***********************************RV*}
function fPesqCondicoesPgto(Self     : TForm;                     {* Formulário                                  *}
                            edtCodigo: TCustomEdit;               {* Edit do Código                              *}
                            edtDescri: TEditFocus;                {* Edit da Descrição                           *}
                            qryTabela: TUniQuery;                   {* Query                                       *}
                            Var chrKey: Char;                     {* Key                                         *}
                            Var arrSel: TConsultasArray;          {* Array de Seleção                            *}
                            blnConSim: Boolean = True;            {* Consulta Simples ou Múltipla (multi select) *}
                            blnTablet: Boolean = False;
                            opcTipCon: TTipoConsultaCondPagto = conCndSimples;
                            fltMarDoc: Double = 0;
                            fltValDoc: Double = 0;
                            strCodCli: String = '';
                            blnAtivas: Boolean = False;
                            blnFaturamento: Boolean = False;
                            blnIgnMar: Boolean = False): Boolean;
  Var
    strSQL     : String;
    strWhere   : String;
    strSQL2    : String;
    blnWhere   : Boolean;
    qryConsulta: TUniQuery;
    arrTitCol  : TColunasArray;
    qryTmp     : TUniQuery;
    blnFilCli  : Boolean;
    objConsulta: TDefConsulta;
    blnLibCnd  : Boolean;
    blnListarSomenteCondicoesQueAtendamAsFaixas: Boolean;
begin
  Result := False;
  blnWhere := False;

  blnListarSomenteCondicoesQueAtendamAsFaixas := False;

  If (fCfgSis('PFLCLI') = 'S') And
     (fCfgSis('CNDVEN') = 'F') And
     blnFaturamento            Then
  Begin
    If (fCfgSis('LIBCND') = '1')            And
       ((fltMarDoc > 0) Or (fltValDoc > 0)) Then
    Begin
      blnListarSomenteCondicoesQueAtendamAsFaixas := True;
      blnLibCnd := True
    End
    Else
      blnLibCnd := False;
  End
  Else
    blnLibCnd := True;

  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      Case opcTipCon Of
        conCndSimples: Begin
                         strSQL := '';
                         strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
                         strSQL := strSQL + '  CND_CODIGO,       ';
                         strSQL := strSQL + '  CND_DESCRI,       ';
                         strSQL := strSQL + '  CND_CNDPAG,       ';
                         strSQL := strSQL + '  CND_TIPFOR,       ';
                         strSQL := strSQL + '  SUB_TIPCND,       ';
                         strSQL := strSQL + '  CND_PRZMED,       ';
                         strSQL := strSQL + '  CND_TXJURO,       ';
                         strSQL := strSQL + '  CND_DESMGE,       ';
                         strSQL := strSQL + '  CND_DESMSU,       ';
                         strSQL := strSQL + '  CND_DESMAX,       ';
                         strSQL := strSQL + '  AUTOINCREM        ';
                         strSQL := strSQL + 'FROM                ';
                         strSQL := strSQL + '  CADCND            ';
                         {***************************************}
                         {* TÍTULO DA COLUNA E MÁSCARA DO CAMPO *}
                         {************************************RV*}
                         SetLength(arrTitCol, 10);
                         arrTitCol[00] := 'Código';
                         arrTitCol[01] := 'Descrição';
                         arrTitCol[02] := 'Condição';
                         arrTitCol[03] := 'Tipo';
                         arrTitCol[04] := 'Tipo da Condição';
                         arrTitCol[05] := 'Prazo Médio';
                         arrTitCol[06] := 'Taxa Juros';
                         arrTitCol[07] := 'Desc. Máx. Ger.';
                         arrTitCol[08] := 'Desc. Máx. Sub. Ger.';
                         arrTitCol[09] := 'Desc. Máx. Ven.';

                       End;
        conCndPerfil:  Begin
                         strSQL := '';
                         strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
                         strSQL := strSQL + '  CND_CODIGO,       ';
                         strSQL := strSQL + '  CND_DESCRI,       ';
                         strSQL := strSQL + '  CND_CNDPAG,       ';
                         strSQL := strSQL + '  CND_TIPFOR,       ';
                         strSQL := strSQL + '  CND_PRZMED,       ';
                         strSQL := strSQL + '  CND_DESPFL,       ';
                         strSQL := strSQL + '  SUB_TIPCND,       ';
                         strSQL := strSQL + '  CND_FATMIN,       ';
                         strSQL := strSQL + '  CND_FATMAX,       ';
                         strSQL := strSQL + '  CND_TXJURO,       ';
                         strSQL := strSQL + '  CND_DESMGE,       ';
                         strSQL := strSQL + '  CND_DESMSU,       ';
                         strSQL := strSQL + '  CND_DESMAX,       ';
                         strSQL := strSQL + '  SUB_PERCND,       ';
                         strSQL := strSQL + '  CND_MARMIN,       ';
                         strSQL := strSQL + '  CND_MARMAX,       ';
                         strSQL := strSQL + '  AUTOINCREM        ';
                         strSQL := strSQL + 'FROM                ';
                         strSQL := strSQL + '  CADCND            ';
                         {***************************************}
                         {* TÍTULO DA COLUNA E MÁSCARA DO CAMPO *}
                         {************************************RV*}
                         SetLength(arrTitCol, 13);
                         arrTitCol[00] := 'Código';
                         arrTitCol[01] := 'Descrição';
                         arrTitCol[02] := 'Condição';
                         arrTitCol[03] := 'Tipo';
                         arrTitCol[04] := 'Prazo Médio';
                         arrTitCol[05] := 'Perfil';
                         arrTitCol[06] := 'Tipo da Condição';
                         arrTitCol[07] := 'Vlr. Fat. Mín.';
                         arrTitCol[08] := 'Vlr. Fat. Máx.';
                         arrTitCol[09] := 'Taxa Juros';
                         arrTitCol[10] := 'Desc. Máx. Ger.';
                         arrTitCol[11] := 'Desc. Máx. Sub. Ger.';
                         arrTitCol[12] := 'Desc. Máx. Ven.';
                       End;
      End;

      objConsulta := TDefConsulta.Create;
      objConsulta.pIncluiSubConsulta('SUB_TIPCND', 'IF(CND_TIPCND = "V", "A VISTA",IF(CND_TIPCND = "P","A PRAZO",""))');

      If blnLibCnd Then
        objConsulta.pIncluiSubConsulta('SUB_PERCND', '0')
      Else
        objConsulta.pIncluiSubConsulta('SUB_PERCND', fRetornaSubQueryFaixasForaCondicao(fltMarDoc, fltValDoc, blnIgnMar));

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If ((fltMarDoc > 0) Or blnListarSomenteCondicoesQueAtendamAsFaixas) And blnLibCnd And (Not blnIgnMar) Then
      Begin
        blnWhere := True;
        strWhere := '';
        strWhere := strWhere + 'WHERE ';
        strWhere := strWhere + '  ' + AnsiReplaceStr(FloatToStr(fltMarDoc), ',', '.') + ' ';
        strWhere := strWhere + '  BETWEEN CND_MARMIN AND CND_MARMAX ';
      End;

      If ((fltValDoc > 0) Or blnListarSomenteCondicoesQueAtendamAsFaixas) And blnLibCnd Then
      Begin
        If blnWhere Then
          strWhere := strWhere + ' AND '
        Else
        Begin
          strWhere := strWhere + 'WHERE ';
          blnWhere := True;
        End;

        strWhere := strWhere + '  ' + AnsiReplaceStr(FloatToStr(fltValDoc), ',', '.') + ' ';
        strWhere := strWhere + '  BETWEEN CND_FATMIN AND CND_FATMAX ';
      End;

      If (Not fEmptyStr(strCodCli)) Then
      Begin
        strSQL2 := '';
        strSQL2 := strSQL2 + ' SELECT       ';
        strSQL2 := strSQL2 + '   CND_CODCND ';
        strSQL2 := strSQL2 + ' FROM         ';
        strSQL2 := strSQL2 + '   CLICND     ';
        strSQL2 := strSQL2 + ' WHERE ';
        strSQL2 := strSQL2 + '   CND_CODCLI = ' + QuotedStr(strCodCli);

        If fCfgSis('USATPC') = 'S' Then
        Begin
          strSQL2 := strSQL2 + ' UNION ALL    ';
          strSQL2 := strSQL2 + ' SELECT       ';
          strSQL2 := strSQL2 + '   TCN_CODCND ';
          strSQL2 := strSQL2 + ' FROM         ';
          strSQL2 := strSQL2 + '   CADCLI     ';
          strSQL2 := strSQL2 + ' JOIN TIPCND ON TCN_CODTIP = CLI_TIPCLI ';
          strSQL2 := strSQL2 + ' WHERE ';
          strSQL2 := strSQL2 + '   CLI_CODCLI = ' + QuotedStr(strCodCli);
        End;

        qryTmp := fCriaQuery;
        With qryTmp Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL2);
          Open;

          blnFilCli := (Not IsEmpty);
        End;
        FreeAndNil(qryTmp);

        If blnFilCli Then
        Begin
          If blnWhere Then
            strWhere := strWhere + ' AND '
          Else
          Begin
            strWhere := strWhere + 'WHERE ';
            blnWhere := True;
          End;

          strWhere   := strWhere + ' CND_CODIGO IN (' + strSQL2 + ')';
        End
        Else
        Begin
          If (fCfgSis('CNDPRA', varString) = '2') Then
          Begin
            If blnWhere Then
              strWhere := strWhere + ' AND FALSE '
            Else
            Begin
              strWhere := strWhere + 'WHERE FALSE ';
              blnWhere := True;
            End;
          End;
        End;
      End;

      If blnAtivas Then
      Begin
        If blnWhere Then
          strWhere := strWhere + ' AND '
        Else
        Begin
          strWhere := strWhere + 'WHERE ';
//          blnWhere := True;
        End;

        strWhere := strWhere + '  LOCATE(' + QuotedStr(VS_strCodEmp) + ', CND_EMPACE) ';
      End;

      If fConsulta([strSQL, strWhere],
                   arrTitCol,
                   ['CND_DESCRI','CND_CODIGO'],
                   '',
                   'CADCND',
                   Self.Name,
                   'Consulta de Condições de Pagamento',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'CND_CODIGO',
                   objConsulta,
                   blnTablet) Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('CND_CODIGO').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('CND_CODIGO').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('CND_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 3)
            Else
              edtCodigo.Text := fStrZero('0', 3);
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';

        End;

        Result := True;

      End;

      FreeAndNil(objConsulta);

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

{*****************************}
{* CONSULTA DE FORMA DE PGTO *}
{**************************RV*}
function fPesqFormaPgto(opcTipPgt: TTipoConsultaFormaPagto;
                        Self     : TForm;                         {* Formulário                                  *}
                        edtCodigo: TCustomEdit;                   {* Edit do Código                              *}
                        edtDescri: TEditFocus;                    {* Edit da Descrição                           *}
                        qryTabela: TUniQuery;                       {* Query                                       *}
                        Var chrKey: Char;                         {* Key                                         *}
                        Var arrSel: TConsultasArray;              {* Array de Seleção                            *}
                        blnConSim: Boolean = True;                {* Consulta Simples ou Múltipla (multi select) *}
                        blnTablet: Boolean = False): Boolean;
  Var
    qryConsulta: TUniQuery;
    strSQL,
    strWhere: String;
    arrTitCol: TColunasArray;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strWhere := '';

      Case opcTipPgt Of
        conFpgBaiAvi: Begin
                        strSQL := '';
                        strSQL := strSQL + 'SELECT        ';
                        strSQL := strSQL + '  FPG_CODIGO, ';
                        strSQL := strSQL + '  FPG_DESCRI, ';
                        strSQL := strSQL + '  FPG_CODEMP, ';
                        strSQL := strSQL + '  FPG_CONCON, ';
                        strSQL := strSQL + '  AUTOINCREM  ';
                        strSQL := strSQL + 'FROM          ';
                        strSQL := strSQL + '  CADFPG      ';

                        strWhere := strWhere + 'WHERE         ';
                        strWhere := strWhere + '  TRUE        ';
                        {*******************************************}
                        {* CASO SEJA CONFIGURADO PARA NÃO BAIXAR   *}
                        {* NÃO DEIXA ESCOLHER PARCELADO            *}
                        {****************************************MV*}
                        If (Not fCfgSis('BAIAVI', varBoolean)) Then
                        Begin
                          strWhere := strWhere + '  AND FPG_CODIGO <> "009" ';
                        End;
                        {***************************************}
                        {* TÍTULO DA COLUNA E MÁSCARA DO CAMPO *}
                        {************************************RV*}
                        SetLength(arrTitCol, 4);
                        arrTitCol[00] := 'Código';
                        arrTitCol[01] := 'Descrição';
                        arrTitCol[02] := 'Emp.';
                        arrTitCol[03] := 'Conta Contábil';
                      End;

        conFpgSimples: Begin
                         strSQL := '';
                         strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
                         strSQL := strSQL + '  FPG_CODIGO,       ';
                         strSQL := strSQL + '  FPG_DESCRI,       ';
                         strSQL := strSQL + '  AUTOINCREM        ';
                         strSQL := strSQL + 'FROM                ';
                         strSQL := strSQL + '  CADFPG            ';
                         {***************************************}
                         {* TÍTULO DA COLUNA E MÁSCARA DO CAMPO *}
                         {************************************RV*}
                         SetLength(arrTitCol, 2);
                         arrTitCol[00] := 'Código';
                         arrTitCol[01] := 'Descrição';
                       End;
      End;

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL, strWhere],
                   arrTitCol,
                   ['FPG_DESCRI','FPG_CODIGO'],
                   '',
                   'CADFPG',
                   Self.Name,
                   'Consulta de Formas de Pagamento',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'FPG_CODIGO',
                   Nil,
                   blnTablet) Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('FPG_CODIGO').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('FPG_CODIGO').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('FPG_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 3)
            Else
              edtCodigo.Text := fStrZero('0', 3);
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


{*********************************}
{* CONSULTA DE ATIVO/IMOBILIZADO *}
{******************************DP*}
function fPesqAtivoImob(Self     : TForm;                    {* Formulário                                  *}
                        edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                        edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                        qryTabela: TUniQuery;                  {* Query                                       *}
                        Var chrKey: Char;                    {* Key                                         *}
                        Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                        blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}

  Var
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
      strSQL := strSQL + '  CADIMO.IMO_CODIMO,       ';
      strSQL := strSQL + '  CADIMO.IMO_DESCRI,       ';
      strSQL := strSQL + '  CADIMO.AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  CADIMO            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Código',
                   'Descrição',
                   'AUTOINCREM'],
                   ['IMO_DESCRI','IMO_CODIMO'],
                   '',
                   'CADIMO',
                   Self.Name,
                   'Consulta de Ativo/Imobilizado',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'IMO_CODIMO') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('IMO_CODIMO').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('IMO_CODIMO').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('IMO_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 6)
            Else
              edtCodigo.Text := fStrZero('0', 6);
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

{************************}
{* CONSULTA DE DIVERSOS *}
{*********************DP*}
function fPesqDiversos(Self        : TForm;                  {* Formulário                                  *}
                       edtCodigo   : TCustomEdit;            {* Edit do Código                              *}
                       edtDescri   : TEditFocus;             {* Edit da Descrição                           *}
                       qryTabela   : TUniQuery;              {* Query                                       *}
                       Var chrKey  : Char;                   {* Key                                         *}
                       Var arrSel  : TConsultasArray;        {* Array de Seleção                            *}
                       blnConSim: Boolean = True;            {* Consulta Simples ou Múltipla (multi select) *}
                       blnVerStatus: Boolean = False;        {* Verifica Status (Ativo Sim ou Não)          *}
                       blnVerEmpAce: Boolean = False;
                       strCodCli   : String  = ''): Boolean; {* Apenas profissionais vinculados ao cliente  *}
  Const
    SQL_ATIVIDADE = '(SELECT ATI_DESATI FROM CADATI WHERE ATI_CODATI = DIV_CODATI)';
  Var
    strSQL     : String;
    strWhere   : String;
    qryConsulta: TUniQuery;
    objConsulta: TDefConsulta;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  DIV_CODDIV,       ';
      strSQL := strSQL + '  DIV_NOMDIV,       ';
      strSQL := strSQL + '  DIV_RAZSOC,       ';
      strSQL := strSQL + '  DIV_ENDERE,       ';
      strSQL := strSQL + '  DIV_FONE01,       ';
      strSQL := strSQL + '  DIV_C_G_C_,       ';
      strSQL := strSQL + '  DIV_DTACAD,       ';
      strSQL := strSQL + '  DIV_OBSERV,       ';
      strSQL := strSQL + '  ATIVIDADE,        '; // <-- "ALIAS" DE SUBCONSULTA
      strSQL := strSQL + '  AUTOINCREM,       ';
      strSQL := strSQL + '  DIV_CGCCPF        ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADDIV ';

      strWhere := 'WHERE TRUE ';

      if (blnVerStatus) Then
        strWhere := strWhere + '  AND DIV_STATUS = "A" ';

      If (blnVerEmpAce) Then
        strWhere := strWhere + '  AND LOCATE(' + QuotedStr(VS_strCodEmp) + ', DIV_EMPACE) ';

      If (Not fEmptyStr(strCodCli)) Then
      Begin
        if fCfgSis('OBDVCL', varBoolean) then
          strWhere := strWhere + '  AND DIV_CODDIV IN (SELECT DIV_CODDIV FROM CLIDIV WHERE DIV_CODCLI = ' + QuotedStr(strCodCli) + ') ';
      End;

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      objConsulta := TDefMascaraDiversos.Create;
      objConsulta.pIncluiCamposFone(['DIV_FONE01']);
      objConsulta.pIncluiSubConsulta('ATIVIDADE', SQL_ATIVIDADE);

      If fConsulta([strSQL, strWhere],
                  ['Código',
                   'Nome do Profissional',
                   'Razão Social do Profissional',
                   'Endereço',
                   'Telefone',
                   'CNPJ/CPF',
                   'Dt.Cadastro',
                   'Observações',
                   'Atividade',
                   'AUTOINCREM'],
                   ['DIV_NOMDIV','DIV_CODDIV'],
                   '',
                   'CADDIV',
                   Self.Name,
                   'Consulta de Diversos',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'DIV_CODDIV',
                   objConsulta) Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('DIV_CODDIV').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('DIV_CODDIV').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('DIV_NOMDIV').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 8)
            Else
              edtCodigo.Text := fStrZero('0', 8);
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';

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

{***********************************}
{* CONSULTA DE CONTROLE DE ENTREGA *}
{********************************LA*}
function fPesqControleEntrega(Self     : TForm;                    {* Formulário                                  *}
                              edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                              Var chrKey: Char): Boolean;
  Var
    strSQL,
    strWhere   : String;
    qryConsulta: TUniQuery;
    objConsulta: TDefConsulta;
    arrSel: TConsultasArray; {* Array de Seleção *}
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  ENT_DTAENT,       ';
      strSQL := strSQL + '  DIASEM,           ';
      strSQL := strSQL + '  ENT_DISPE1,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CONENT ';

      strWhere := '';
      strWhere := strWhere + 'WHERE ';
      strWhere := strWhere + '  ENT_DISPE1 > 0 AND ';
      strWhere := strWhere + '  ENT_CODEMP = ' + QuotedStr(VS_strCodEmp);
      strWhere := strWhere + '  AND ENT_DTAENT >= ' + QuotedStr(FormatDateTime('YYYY-MM-DD', VS_Date));

      qryConsulta := fCriaQuery(Nil);

      objConsulta := TDefConsulta.Create;
      objConsulta.pIncluiSubConsulta('DIASEM', 'CASE DAYOFWEEK(ENT_DTAENT) ' +
                                               '  WHEN 1 THEN "DOMINGO" ' +
                                               '  WHEN 2 THEN "SEGUNDA-FEIRA" ' +
                                               '  WHEN 3 THEN "TERÇA-FEIRA" ' +
                                               '  WHEN 4 THEN "QUARTA-FEIRA" ' +
                                               '  WHEN 5 THEN "QUINTA-FEIRA" ' +
                                               '  WHEN 6 THEN "SEXTA-FEIRA" ' +
                                               '  WHEN 7 THEN "SÁBADO" END');

      If fConsulta([strSQL, strWhere],
                  ['Data',
                   'Dia da Semana',
                   'Disponível'],
                   ['ENT_DTAENT'],
                   '',
                   'CONENT',
                   Self.Name,
                   'Consulta de Controle de Entrega',
                   qryConsulta,
                   Nil,
                   True,
                   arrSel,
                   'ENT_DTAENT',
                   objConsulta) Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := FormatDateTime('DD/MM/YYYY', qryConsulta.FieldByName('ENT_DTAENT').AsDateTime)
          Else
            edtCodigo.Text := FormatDateTime('DD/MM/YYYY', qryConsulta.FieldByName('ENT_DTAENT').AsDateTime);
        End;

        Result := True;

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

{*************************}
{* CONSULTA DE CONTRATOS *}
{*********************DP *}
function fPesqContratos(Self     : TForm;                       {* Formulário                                  *}
                        edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                        edtDescri: TEditFocus;                  {* Edit da Descrição                           *}
                        qryTabela: TUniQuery;                     {* Query                                       *}
                        Var chrKey: Char;                       {* Key                                         *}
                        Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                        blnConSim: Boolean = True;
                        strCodCli: String = ''): Boolean;
  Var
    qryConsulta: TUniQuery;
    strSQL,
    strWhere,
    strGroup: String;

    objConsulta: TDefConsulta;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strWhere := '';
      strGroup := '';

      objConsulta := TDefConsulta.Create;

      If Not fEmptyStr(strCodCli) Then
      Begin

        strSQL := '';
        strSQL := strSQL + 'SELECT SQL_NO_CACHE';
        strSQL := strSQL + '  CON_CODCON, ';
        strSQL := strSQL + '  CON_DESCON, ';
        strSQL := strSQL + '  CON_VALSER, ';
        strSQL := strSQL + '  AUTOINCREM  ';
        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  CADCON ';

        strWhere := '';
        strWhere := strWhere + 'WHERE ';
        strWhere := strWhere + '  CON_CODCLI =  ' + QuotedStr(strCodCli) + ' ';

        strGroup := '';
        strGroup := strGroup + 'GROUP BY CON_CODCON ';

        objConsulta.pIncluiSubConsulta('CON_VALSER', 'SUM(CON_VALSER)');
      End Else
      Begin

        strSQL := '';
        strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
        strSQL := strSQL + '  CON_CODCON,       ';
        strSQL := strSQL + '  CON_DESCON,       ';
        strSQL := strSQL + '  CON_VALSER,       ';
        strSQL := strSQL + '  AUTOINCREM        ';
        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  CADCON ';

      End;

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL, strWhere, strGroup],
                  ['Código',
                   'Descrição',
                   'Valor',
                   'AUTOINCREM'],
                   ['CON_DESCON','CON_CODCON'],
                   '',
                   'CADCON',
                   Self.Name,
                   'Consulta de Contratos',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'CON_CODCON',
                   objConsulta) Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('CON_CODCON').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('CON_CODCON').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('CON_DESCON').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 3)
            Else
              edtCodigo.Text := fStrZero('0', 3);
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';

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

{*********************************}
{* CONSULTA DE MOVTO. DE CARTÕES *}
{******************************RV*}
function fPesqMovtoCartao(Self     : TForm;                       {* Formulário                                  *}
                          edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                          qryTabela: TUniQuery;                     {* Query                                       *}
                          Var chrKey: Char;                       {* Key                                         *}
                          Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                          blnConSim: Boolean = True;              {* Consulta Simples ou Múltipla (multi select) *}
                          intOpcao: Integer = 1): Boolean;        {* Tipo - 1 = Todos 2 = Baixados 3 = Abertos   *}
  Var
    strSQL,
    strWhere,
    strPesAux  : String;
    qryConsulta: TUniQuery;
    blnAnd     : Boolean;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  MCA_NUMDUP,       ';
      strSQL := strSQL + '  MCA_PARCEL,       ';
      strSQL := strSQL + '  MCA_CODEMP,       ';
      strSQL := strSQL + '  MCA_CODCLI,       ';
      strSQL := strSQL + '  CLI_NOMCLI,       ';
      strSQL := strSQL + '  MCA_DTAVEN,       ';
      strSQL := strSQL + '  MCA_VALORI,       ';
      strSQL := strSQL + '  MCA_VALDUP,       ';
      strSQL := strSQL + '  MCA_VALSTA,       ';
      strSQL := strSQL + '  MCA_VALREC,       ';
      strSQL := strSQL + '  MCA_DTACAD,       ';
      strSQL := strSQL + '  MCA_DTAREC,       ';
      strSQL := strSQL + '  MCA_DOCUME,       ';
      strSQL := strSQL + '  MCA_NUMCCD,       ';
      strSQL := strSQL + '  MCA_NUMNSU,       ';
      strSQL := strSQL + '  MCA_HIST01,       ';
      strSQL := strSQL + '  MCA_HIST02,       ';
      strSQL := strSQL + '  MCA_CODCAR,       ';
      strSQL := strSQL + '  CAR_DESCAR,       ';
      strSQL := strSQL + '  MOVCAR.AUTOINCREM ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  MOVCAR            ';
      strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = MCA_CODCLI ';
      strSQL := strSQL + '  INNER JOIN CADCAR ON CAR_CODCAR = MCA_CODCAR ';

      strWhere := '';
      strWhere := strWhere + 'WHERE               ';

      blnAnd := (intOpcao in [2, 3]);
      If (intOpcao = 2) Then
        strWhere := strWhere + '  MCA_DTAREC IS NOT NULL '
      Else If (intOpcao = 3) Then
        strWhere := strWhere + '  MCA_DTAREC IS NULL ';

      //Filtrando apenas os cartões das empresas onde usuário possui acesso
      strWhere := strWhere + IIF(blnAnd, ' AND ', ' ') +
                             ' MCA_CODEMP IN (' + fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + ') ';

      If fCfgSis('DACPOR', varBoolean) Then
      Begin
        strPesAux := fRetStrToSQLIn(strPortadoresOperador);
        strWhere := strWhere + '  AND (MCA_PORBAI = "" OR MCA_PORBAI IS NULL ';
        strWhere := strWhere + '  OR MCA_PORBAI IN (' + strPesAux + ')) ';
        strWhere := strWhere + '  AND (MCA_PORBTX = "" OR MCA_PORBTX IS NULL ';
        strWhere := strWhere + '  OR MCA_PORBTX IN (' + strPesAux + ')) ';
        strWhere := strWhere + '  AND (MCA_PORDEB = "" OR MCA_PORDEB IS NULL ';
        strWhere := strWhere + '  OR MCA_PORDEB IN (' + strPesAux + ')) ';
      End;

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL, strWhere],
                  ['Duplicata',
                   'Parc.',
                   'Emp.',
                   'Cód. Cliente',
                   'Nome Cliente',
                   'Dt. Vencto.',
                   'Vlr. Original',
                   'Vlr. Duplicata',
                   'Vlr. sem Taxa',
                   'Vlr. Recebido',
                   'Dt. Cadastro',
                   'Dt. Receb.',
                   'Documento',
                   'Liberação',
                   'NSU',
                   'Histórico 1',
                   'Histórico 2',
                   'Código',
                   'Cartão',
                   'AUTOINCREM'],
                   ['MCA_NUMDUP','CLI_NOMCLI','MCA_CODCLI'],
                   '',
                   'MOVCAR',
                   Self.Name,
                   'Consulta de Movimento de Cartões',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'MCA_NUMDUP') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('MCA_NUMDUP').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('MCA_NUMDUP').AsString;
        End;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 6)
            Else
              edtCodigo.Text := fStrZero('0', 6);
          End;

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

{*****************************}
{* CONSULTA DE MOTORISTAS    *}
{**************************RV*}
function fPesqMotorista(Self     : TForm;                         {* Formulário                                  *}
                        edtCodigo: TCustomEdit;                   {* Edit do Código                              *}
                        edtDescri: TEditFocus;                    {* Edit da Descrição                           *}
                        qryTabela: TUniQuery;                       {* Query                                       *}
                        Var chrKey: Char;                         {* Key                                         *}
                        Var arrSel: TConsultasArray;              {* Array de Seleção                            *}
                        blnConSim: Boolean = True;                {* Consulta Simples ou Múltipla (multi select) *}
                        blnAtivos: Boolean = False): Boolean;     {* Apenas com status ativo                     *}
  Var
    strSQL     : String;
    strWhere   : String;
    qryConsulta: TUniQuery;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  MOT_CODMOT,       ';
      strSQL := strSQL + '  MOT_NOMMOT,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  CADMOT            ';

      strWhere := '';

      If blnAtivos Then
      Begin
        strWhere := strWhere + ' WHERE              ';
        strWhere := strWhere + '   MOT_STATUS = "A" ';
      End;

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL, strWhere],
                  ['Código',
                   'Nome',
                   'AUTOINCREM'],
                   ['MOT_NOMMOT','MOT_CODMOT'],
                   '',
                   'CADMOT',
                   Self.Name,
                   'Consulta de Motoristas',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'MOT_CODMOT') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('MOT_CODMOT').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('MOT_CODMOT').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('MOT_NOMMOT').AsString;

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

{*******************}
{* CONSULTA DE ECF *}
{****************DP*}
function fPesqECF(Self     : TForm;                    {* Formulário                                  *}
                  edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                  edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                  qryTabela: TUniQuery;                  {* Query                                       *}
                  Var chrKey: Char;                    {* Key                                         *}
                  Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                  blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}
  Var
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
      strSQL := strSQL + '  ECF_CODECF,       ';
      strSQL := strSQL + '  ECF_MODELO,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADECF ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Código',
                   'Descrição',
                   'AUTOINCREM'],
                   ['ECF_MODELO','ECF_CODECF'],
                   '',
                   'CADECF',
                   Self.Name,
                   'Consulta de ECFs',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'ECF_CODECF') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('ECF_CODECF').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('ECF_CODECF').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('ECF_MODELO').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 3)
            Else
              edtCodigo.Text := fStrZero('0', 3);
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

{******************************}
{* CONSULTA DE SETOR FILIZOLA *}
{***************************DP*}
function fPesqSetFlz(Self     : TForm;                    {* Formulário                                  *}
                     edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                     edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                     qryTabela: TUniQuery;                  {* Query                                       *}
                     Var chrKey: Char;                    {* Key                                         *}
                     Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                     blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}
  Var
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
      strSQL := strSQL + '  SFZ_CODSFZ,       ';
      strSQL := strSQL + '  SFZ_DESCRI,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADSFZ ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Código',
                   'Descrição',
                   'AUTOINCREM'],
                   ['SFZ_DESCRI','SFZ_CODSFZ'],
                   '',
                   'CADSFZ',
                   Self.Name,
                   'Consulta de Setores Filizola',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'SFZ_CODSFZ') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('ECF_CODECF').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('SFZ_CODSFZ').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('SFZ_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 3)
            Else
              edtCodigo.Text := fStrZero('0', 3);
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

{*****************************}
{* CONSULTA DE OCORRÊNCIAS   *}
{**************************RV*}
function fPesqOcorrencia(Self     : TForm;                        {* Formulário                                  *}
                         edtCodigo: TCustomEdit;                  {* Edit do Código                              *}
                         edtDescri: TEditFocus;                   {* Edit da Descrição                           *}
                         qryTabela: TUniQuery;                      {* Query                                       *}
                         Var chrKey: Char;                        {* Key                                         *}
                         Var arrSel: TConsultasArray;             {* Array de Seleção                            *}
                         blnConSim: Boolean = True): Boolean;     {* Consulta Simples ou Múltipla (multi select) *}
  Var
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
      strSQL := strSQL + '  OCO_CODOCO,       ';
      strSQL := strSQL + '  OCO_DESOCO,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  CADOCO            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Código',
                   'Descrição',
                   'AUTOINCREM'],
                   ['OCO_DESOCO','OCO_CODOCO'],
                   '',
                   'CADOCO',
                   Self.Name,
                   'Consulta de Ocorrências',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'OCO_CODOCO') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('OCO_CODOCO').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('OCO_CODOCO').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('OCO_DESOCO').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 3)
            Else
              edtCodigo.Text := fStrZero('0', 3);
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


{*******************************}
{* CONSULTA DE SIT. TRIBUTÁRIA *}
{****************************RV*}
function fPesqSitTributaria(Self     : TForm;                     {* Formulário                                  *}
                            edtCodigo: TCustomEdit;               {* Edit do Código                              *}
                            edtDescri: TEditFocus;                {* Edit da Descrição                           *}
                            qryTabela: TUniQuery;                   {* Query                                       *}
                            Var chrKey: Char;                     {* Key                                         *}
                            Var arrSel: TConsultasArray;          {* Array de Seleção                            *}
                            blnConSim: Boolean = True): Boolean;  {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
    objConsulta: TDefConsulta;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  TRI_CODTRI,       ';
      strSQL := strSQL + '  TRI_DESCRI,       ';
      strSQL := strSQL + '  TRI_DESC01,       ';
      strSQL := strSQL + '  TRI_DESC02,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  CADTRI            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      objConsulta := TDefConsulta.Create;
      objConsulta.pIncluiSubConsulta('TRI_DESCRI', 'CONCAT(TRI_DESC01, " ", IFNULL(TRI_DESC02, ""))');

      If fConsulta([strSQL],
                  ['Código',
                   'Descrição Completa'],
                   ['TRI_DESCRI','TRI_CODTRI'],
                   '',
                   'CADTRI',
                   Self.Name,
                   'Consulta de Situação Tributária',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'TRI_CODTRI',
                   objConsulta) Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('TRI_CODTRI').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('TRI_CODTRI').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('TRI_DESC01').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 3)
            Else
              edtCodigo.Text := fStrZero('0', 3);
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';

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

function fPesqProtocoloCancelamento(Self     : TForm;                     {* Formulário                                  *}
                                    qryTabela: TUniQuery;                 {* Query                                       *}
                                    Var chrKey: Char;                     {* Key                                         *}
                                    Var arrSel: TConsultasArray;          {* Array de Seleção                            *}
                                    blnConSim: Boolean = True;            {* Consulta Simples ou Múltipla (multi select) *}
                                    strEspSel : String = ''): Boolean;
  Var
    strSQL     : String;
    strWhere   : String;
    qryConsulta: TUniQuery;
    objConsulta: TDefConsulta;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      objConsulta := TDefConsulta.Create;
      objConsulta.pIncluiSubConsulta('FORCLI', 'CONCAT(PRO_CLIFOR, "-", IF(CLI_NOMCLI IS NULL, FOR_NOMFOR, CLI_NOMCLI))');
      objConsulta.pIncluiSubConsulta('INUTIL', 'IF(PRO_INUTIL="S", "Sim", "Não")');
      objConsulta.pIncluiSubConsulta('DESOCO', 'CONCAT(PRO_CODMOT, "-", OCO_DESOCO)');

      strSQL := '';
      strSQL := strSQL + ' SELECT PRO_NUMPRO,                            ';
      strSQL := strSQL + '        PRO_ESPSEL,                            ';
      strSQL := strSQL + '        PRO_NUMDOC,                            ';
      strSQL := strSQL + '        PRO_SERIE_,                            ';
      strSQL := strSQL + '        FORCLI,                                ';
      strSQL := strSQL + '        INUTIL,                                ';
      strSQL := strSQL + '        DESOCO,                                ';
      strSQL := strSQL + '        PRO_HISTOR,                            ';
      strSQL := strSQL + '        PRO_TIP_FC,                            ';
      strSQL := strSQL + '        PRO_CLIFOR,                            ';
      strSQL := strSQL + '        PROCRM.AUTOINCREM                      ';
      strSQL := strSQL + ' FROM PROCRM                                   ';
      strSQL := strSQL + '   LEFT JOIN CADCLI ON CLI_CODCLI = PRO_CLIFOR ';
      strSQL := strSQL + '   LEFT JOIN CADFOR ON FOR_CODFOR = PRO_CLIFOR ';
      strSQL := strSQL + '   LEFT JOIN CADOCO ON OCO_CODOCO = PRO_CODMOT ';

      strWhere := '';
      strWhere := strWhere + ' WHERE PRO_OPEBAI IS NULL ';
      strWhere := strWhere + '   AND PRO_DTABAI IS NULL ';
      If not fEmptyStr(strEspSel) Then
        strWhere := strWhere + '   AND PRO_ESPSEL = ' + QuotedStr(strEspSel);

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL, strWhere],
                  ['Nº Protocolo',
                   'Tipo',
                   'Número do Documento',
                   'Série',
                   'Cliente/Fornecedor',
                   'Inutilizar',
                   'Ocorrência',
                   'Historico'],
                   ['PRO_DTACAD', 'PRO_NUMPRO', 'PRO_NUMDOC'],
                   'AUTOINCREM',
                   'PROCRM',
                   Self.Name,
                   'Consulta de Protocolos de Cancelamento',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'AUTOINCREM',
                   objConsulta) Then
      Begin

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

{*****************************}
{* CONSULTA DE VEICULOS      *}
{**************************RV*}
function fPesqVeiculos(Self     : TForm;                          {* Formulário                                  *}
                       edtCodigo: TCustomEdit;                    {* Edit do Código                              *}
                       edtDescri: TEditFocus;                     {* Edit da Descrição                           *}
                       qryTabela: TUniQuery;                      {* Query                                       *}
                       Var chrKey: Char;                          {* Key                                         *}
                       Var arrSel: TConsultasArray;               {* Array de Seleção                            *}
                       blnConSim: Boolean = True;                 {* Consulta Simples ou Múltipla (multi select) *}
                       blnComMsk: Boolean = True;                 {* Com máscara (XXX-9999)                      *}
                       strFiltro: String = ''): Boolean;          {* Filtro para apesquisa                       *}
  Var
    strSQL     : String;
    strWhere   : String;
    qryConsulta: TUniQuery;
    objConsulta: TDefMascaraKmRodado;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  VEI_PLAVEI,       ';
      strSQL := strSQL + '  VEI_CHASSI,       ';
      strSQL := strSQL + '  MARCA_,           ';
      strSQL := strSQL + '  MODELO,           ';
      strSQL := strSQL + '  COR___,           ';
      strSQL := strSQL + '  VEI_ANOVEI,       ';
      strSQL := strSQL + '  VEI_CONDUT,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  CADVEI            ';

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

      objConsulta := TDefMascaraKmRodado.Create;

      objConsulta.pIncluiSubConsulta('MODELO', '(SELECT MOD_DESMOD FROM MODVEI WHERE MOD_CODMOD = VEI_CODMOD)');
      objConsulta.pIncluiSubConsulta('MARCA_', '(SELECT MAR_DESMAR FROM MARVEI WHERE MAR_CODMAR = VEI_CODMAR)');
      objConsulta.pIncluiSubConsulta('COR___', '(SELECT COR_DESCOR FROM CORVEI WHERE COR_CODCOR = VEI_CODCOR)');

      If fConsulta([strSQL, strWhere],
                  ['Placa',
                   'Chassis',
                   'Marca',
                   'Modelo',
                   'Cor',
                   'Ano',
                   'Condutor'],
                   ['VEI_PLAVEI','MARCA_','MODELO'],
                   '',
                   'CADVEI',
                   Self.Name,
                   'Consulta de Veículos',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'VEI_PLAVEI',
                   objConsulta) Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
          Begin
            If blnComMsk Then
              (edtCodigo As TMaskEditFocus).Text := Copy(qryConsulta.FieldByName('VEI_PLAVEI').AsString, 1, 3) + '-' + Copy(qryConsulta.FieldByName('VEI_PLAVEI').AsString, 4, 4)
            Else
              (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('VEI_PLAVEI').AsString;
          End
          Else
          Begin
            If blnComMsk Then
              edtCodigo.Text := Copy(qryConsulta.FieldByName('VEI_PLAVEI').AsString, 1, 3) + '-' + Copy(qryConsulta.FieldByName('VEI_PLAVEI').AsString, 4, 4)
            Else
              edtCodigo.Text := qryConsulta.FieldByName('VEI_PLAVEI').AsString;
          End;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := fRetornaDescricaoVeic(qryConsulta.FieldByName('VEI_PLAVEI').AsString);

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 7)
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

      FreeAndNil(objConsulta);

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

function fPesqModeloVeiculo(Self     : TForm;                             {* Formulário                                  *}
                            edtCodigo: TCustomEdit;                       {* Edit do Código                              *}
                            edtDescri: TEditFocus;                        {* Edit da Descrição                           *}
                            qryTabela: TUniQuery;                           {* Query                                       *}
                            Var chrKey: Char;                             {* Key                                         *}
                            Var arrSel: TConsultasArray;                  {* Array de Seleção                            *}
                            blnConSim: Boolean = True;                    {* Consulta Simples ou Múltipla (multi select) *}
                            strCodMar: String = ''): Boolean;             {* Marca do modelo de veículo                  *}
  Var
    strSQL     : String;
    strWhere   : String;
    qryConsulta: TUniQuery;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  MOD_CODMOD,       ';
      strSQL := strSQL + '  MOD_DESMOD,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  MODVEI            ';

      strWhere := ' WHERE TRUE ';

      If Not fEmptyStr(strCodMar) Then
        strWhere := strWhere + ' AND MOD_CODMAR = ' + QuotedStr(strCodMar);

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL, strWhere],
                  ['Código',
                   'Descrição',
                   'AUTOINCREM'],
                   ['MOD_DESMOD','MOD_CODMOD'],
                   '',
                   'MODVEI',
                   Self.Name,
                   'Consulta de Modelos de Veículos',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'MOD_CODMOD') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('MOD_CODMOD').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('MOD_CODMOD').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('MOD_DESMOD').AsString;

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

function fPesqMarcaVeiculo(Self     : TForm;                             {* Formulário                                  *}
                           edtCodigo: TCustomEdit;                       {* Edit do Código                              *}
                           edtDescri: TEditFocus;                        {* Edit da Descrição                           *}
                           qryTabela: TUniQuery;                           {* Query                                       *}
                           Var chrKey: Char;                             {* Key                                         *}
                           Var arrSel: TConsultasArray;                  {* Array de Seleção                            *}
                           blnConSim: Boolean = True): Boolean;          {* Consulta Simples ou Múltipla (multi select) *}
  Var
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
      strSQL := strSQL + '  MAR_CODMAR,       ';
      strSQL := strSQL + '  MAR_DESMAR,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  MARVEI            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Código',
                   'Descrição',
                   'AUTOINCREM'],
                   ['MAR_DESMAR','MAR_CODMAR'],
                   '',
                   'MARVEI',
                   Self.Name,
                   'Consulta de Marcas de Veículos',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'MAR_CODMAR') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('MAR_CODMAR').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('MAR_CODMAR').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('MAR_DESMAR').AsString;

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

function fPesqCorVeiculo(Self     : TForm;                             {* Formulário                                  *}
                         edtCodigo: TCustomEdit;                       {* Edit do Código                              *}
                         edtDescri: TEditFocus;                        {* Edit da Descrição                           *}
                         qryTabela: TUniQuery;                           {* Query                                       *}
                         Var chrKey: Char;                             {* Key                                         *}
                         Var arrSel: TConsultasArray;                  {* Array de Seleção                            *}
                         blnConSim: Boolean = True): Boolean;          {* Consulta Simples ou Múltipla (multi select) *}
  Var
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
      strSQL := strSQL + '  COR_CODCOR,       ';
      strSQL := strSQL + '  COR_DESCOR,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  CORVEI            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Código',
                   'Descrição',
                   'AUTOINCREM'],
                   ['COR_DESCOR','COR_CODCOR'],
                   '',
                   'CORVEI',
                   Self.Name,
                   'Consulta de Cores de Veículos',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'COR_CODCOR') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('COR_CODCOR').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('COR_CODCOR').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('COR_DESCOR').AsString;

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

{*****************************}
{* CONSULTA DE PRÓX. CÓDIGOS *}
{**************************RV*}
function fPesqProCod(Self     : TForm;                            {* Formulário                                  *}
                     edtCodigo: TCustomEdit;                      {* Edit do Código                              *}
                     qryTabela: TUniQuery;                          {* Query                                       *}
                     Var chrKey: Char): Boolean;                  {* Key                                         *}
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
    arrSel     : TConsultasArray;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  PRO_NOMARQ,       ';
      strSQL := strSQL + '  PRO_CODAUT,       ';
      strSQL := strSQL + '  PRO_CODSEQ,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  PROCOD            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Arquivo',
                   'Automático?',
                   'Próximo Código'],
                   ['PRO_NOMARQ'],
                   '',
                   'PROCOD',
                   Self.Name,
                   'Consulta de Próximos Códigos',
                   qryConsulta,
                   Nil,
                   True,
                   arrSel,
                   'PRO_NOMARQ') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('PRO_NOMARQ').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('PRO_NOMARQ').AsString;
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

{*****************************}
{* CONSULTA DE EMPRESAS      *}
{**************************RV*}
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
                      strAceCtr: String = '';                     {* Empresas que o usuário possui acesso na Baixa de Contas a Receber        *}
                      strConcil: String  = ''): Boolean;          {* Condição da Conciliação de Cartões          *}
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
                           strWhere := strWhere + ' AND ( LOCATE(EMP_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

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
                           strSQL := strSQL + '  EMP_EXIAPP,   ';
                           strSQL := strSQL + '  E.AUTOINCREM  ';
                           strSQL := strSQL + 'FROM            ';
                           strSQL := strSQL + '  CADEMP E      ';
                           strSQL := strSQL + '  LEFT JOIN CADCID C ON E.EMP_CODCID = C.CID_CODCID ';

                           SetLength(arrTitCol, 12);
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
                           arrTitCol[11] := 'Exibe APP';
                         End;
      end;

      If Not fEmptyStr(strConcil) Then
        strWhere := IIF(Not fEmptyStr(strWhere),
                        strWhere + ' AND ' + strConcil,
                        ' WHERE ' + strConcil);

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL, strWhere],
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

function fPesqRotasRegiao(Self      : TForm;                            {* Formulário                                  *}
                          edtCodigo : TCustomEdit;                      {* Edit do Código                              *}
                          edtDescri : TEditFocus;                       {* Edit da Cidade                              *}
                          qryTabela : TUniQuery;                        {* Query                                       *}
                          Var chrKey: Char;                             {* Key                                         *}
                          Var arrSel: TConsultasArray;                  {* Array de Seleção                            *}
                          blnConSim : Boolean = True): Boolean;         {* Consulta Simples ou Múltipla (multi select) *}

  Var
    strSQL,
    strWhere   : String;
    qryConsulta: TUniQuery;
    arrTitCol  : TColunasArray;                                 {* Títulos das Colunas                         *}

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
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  ROTREG.ROT_CODREG,       '; pAddNomeColuna('Cód. Região');
      strSQL := strSQL + '  CADREG.REG_DESREG,       '; pAddNomeColuna('Nome Região');
      strSQL := strSQL + '  ROTREG.ROT_INTERV,       '; pAddNomeColuna('Intervalo');
      strSQL := strSQL + '  ROTREG.ROT_HORCAR,       '; pAddNomeColuna('Horário Carga');
      strSQL := strSQL + '  ROTREG.ROT_HOREMI,       '; pAddNomeColuna('Pedido até as');
      strSQL := strSQL + '  ROTREG.ROT_VLRMIN,       '; pAddNomeColuna('Valor Mínimo Carga');
      strSQL := strSQL + '  ROTREG.ROT_CODTRA,       '; pAddNomeColuna('Cód. Transp.');
      strSQL := strSQL + '  CADTRA.TRA_NOMTRA,       '; pAddNomeColuna('Nome Transp.');
      strSQL := strSQL + '  ROTREG.ROT_CODEMP,       '; pAddNomeColuna('Cód. Empresa');
      strSQL := strSQL + '  ROTREG.AUTOINCREM ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  ROTREG            ';

      strSQL := strSQL + ' INNER JOIN CADREG ON CADREG.REG_CODREG = ROTREG.ROT_CODREG  ';
      strSQL := strSQL + ' INNER JOIN CADTRA ON CADTRA.TRA_CODTRA = ROTREG.ROT_CODTRA  ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL, strWhere],
                   arrTitCol,
                   ['REG_DESREG'],
                   '',
                   'ROTREG',
                   Self.Name,
                   'Consulta de Rotas por Região',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'ROT_CODREG') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('ROT_CODREG').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('ROT_CODREG').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('REG_DESREG').AsString;

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
      End;
      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;



function fPesqEntregasRotasRegiao(Self      : TForm;                            {* Formulário                                  *}
                                  edtCodigo : TCustomEdit;                      {* Edit do Código                              *}
                                  edtDescri : TEditFocus;                       {* Edit da Cidade                              *}
                                  qryTabela : TUniQuery;                        {* Query                                       *}
                                  Var chrKey: Char;                             {* Key                                         *}
                                  Var arrSel: TConsultasArray;                  {* Array de Seleção                            *}
                                  blnConSim : Boolean = True;                   {* Consulta Simples ou Múltipla (multi select) *}
                                  strCodCid : String = '';                      {* Cidade do endereco de entrega               *}
                                  blnFiltroPorData : Boolean = True;
                                  fltPesBru : Double = 0): Boolean;
  Var
    strSQL      : String;
    strWhere    : String;
    qryConsulta : TUniQuery;
    arrTitCol   : TColunasArray;
    objConsulta : TDefConsulta;

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
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';

      If Not fEmptyStr(strCodCid) Then
        strSQL := strSQL + '       DISTINCT     ';

      strSQL := strSQL + '       ENT_CODIGO,  '; pAddNomeColuna('Seq. Rota');
      strSQL := strSQL + '       ENT_CODREG,  '; pAddNomeColuna('Cód. Região');
      strSQL := strSQL + '       REG_DESREG,  '; pAddNomeColuna('Nome Região');
      strSQL := strSQL + '       ENT_DTAENT,  '; pAddNomeColuna('Data Saída');
      strSQL := strSQL + '       ROT_HOREMI,  '; pAddNomeColuna('Pedido Até as');
      strSQL := strSQL + '       VEICULO,     '; pAddNomeColuna('Veículo');
      strSQL := strSQL + '       VEI_CAPCAR,  '; pAddNomeColuna('Capacidade');
      strSQL := strSQL + '       PESPED,      '; pAddNomeColuna('Peso Pedido');
      strSQL := strSQL + '       PESDSP,      '; pAddNomeColuna('Peso Disponível');
      strSQL := strSQL + '       ROT_VLRMIN,  '; pAddNomeColuna('Vlr.Mín.Carga');
      strSQL := strSQL + '       ENTREG.AUTOINCREM ';
      strSQL := strSQL + '  FROM ENTREG            ';
      strSQL := strSQL + ' INNER JOIN CADREG ON REG_CODREG = ENT_CODREG ';
      strSQL := strSQL + ' INNER JOIN ROTREG ON ROT_CODREG = ENT_CODREG ';
      strSQL := strSQL + ' LEFT  JOIN ROTREV ON REV_CODIGO = ENT_ROTVEI ';
      strSQL := strSQL + ' LEFT  JOIN CADVEI ON VEI_PLAVEI = REV_PLAVEI ';
      strSQL := strSQL + ' LEFT  JOIN MODVEI ON VEI_CODMOD = MOD_CODMOD ';
      strSQL := strSQL + ' LEFT  JOIN MARVEI ON VEI_CODMAR = MAR_CODMAR ';
      strSQL := strSQL + ' LEFT  JOIN CORVEI ON VEI_CODCOR = COR_CODCOR ';

      If Not fEmptyStr(strCodCid) Then
        strSQL := strSQL + ' INNER JOIN ROTREC ON REC_CODREG = ROT_CODREG ';

      strWhere := '';
      strWhere := strWhere + 'WHERE ENT_STATUS = "A" ';

      If (blnFiltroPorData) Then
        strWhere := strWhere + ' AND ENT_DTAENT >= ' + QuotedStr(FormatDateTime('YYYY-MM-DD', VS_Date));

      If Not fEmptyStr(strCodCid) Then
        strWhere := strWhere + ' AND REC_CODCID = ' + QuotedStr(strCodCid);

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      objConsulta := TDefConsulta.Create;



      objConsulta.pIncluiSubConsulta('VEICULO', 'CONCAT( VEI_PLAVEI, "-",  IFNULL(MAR_DESMAR, " ")," ",  IFNULL(MOD_DESMOD, " ")," ", '+
                                                '                          IFNULL(COR_DESCOR, " ")," ", IFNULL(VEI_ANOVEI, " ") ) ');

      objConsulta.pIncluiSubConsulta('PESPED',  '(SELECT IFNULL(SUM(FGO_PESBRU),0) ' +
                                                ' FROM FATGOR INNER JOIN EXTGOR ON FGO_SEQFGO = FATGOR.AUTOINCREM ' +
                                                ' WHERE FGO_CODROT = ENT_CODIGO AND IFNULL(FGO_MOTBAI, "") = "") + '+
                                                AnsiReplaceStr( FormatFloat('0.00', fltPesBru),',','.') );

      objConsulta.pIncluiSubConsulta('PESDSP',  '( IFNULL(VEI_CAPCAR, 0) - '+
                                                ' ( (SELECT IFNULL(SUM(FGO_PESBRU), 0)  FROM  FATGOR '+
                                                '    INNER JOIN EXTGOR ON FGO_SEQFGO = FATGOR.AUTOINCREM '+
                                                '    WHERE FGO_CODROT = ENT_CODIGO AND IFNULL(FGO_MOTBAI, "") = "") + '+
                                                AnsiReplaceStr( FormatFloat('0.00', fltPesBru),',','.') + ' ) ) ' );

      If fConsulta([strSQL, strWhere],
                   arrTitCol,
                   ['ENT_CODIGO'],
                   '',
                   'ENTREG',
                   Self.Name,
                   'Consulta de Entregas de Rotas por Região',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'ENT_CODIGO',
                   objConsulta) Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('ENT_CODIGO').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('ENT_CODIGO').AsString;
        End;

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
      End;
      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);

      FreeAndNil(objConsulta);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;

end;

{*****************************}
{* CONSULTA DE FORNECEDORES  *}
{**************************RV*}
function fCadFor(blnCheck :Boolean = False):Boolean;
Begin
  Result := False;
  If fVerificaAcessoSistema('frmCadFornecedores') And Assigned(objCadastros) Then
  Begin
    If blnCheck Then
      Result := True
    Else
      objCadastros.pChamaCadastroFornecedor;
  End;
End;

function fPesqFornecedor(opcConFor: TTipoConsultaFornecedor;
                         Self     : TForm;                        {* Formulário                                  *}
                         edtCodigo: TCustomEdit;                  {* Edit do Código                              *}
                         edtNomEmp: TCustomEdit;                  {* Edit do Nome da Empresa                     *}
                         qryTabela: TUniQuery;                      {* Query                                       *}
                         Var chrKey: Char;                        {* Key                                         *}
                         Var arrSel: TConsultasArray;             {* Array de Seleção                            *}
                         blnConSim: Boolean = True;               {* Consulta Simples ou Múltipla (multi select) *}
                         objFrmPnl: TPanelCx = Nil;
                         strWhere : String = ''):Boolean;
  Var
    qryConsulta: TUniQuery;
    objConsulta: TDefMascaraFornecedor;
    strSQL: String;
    arrTitCol: TColunasArray;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';

      Case opcConFor Of
        conForCompleta: Begin
                          strSQL := strSQL + 'SELECT          ';
                          strSQL := strSQL + '  F.FOR_CODFOR, ';
                          strSQL := strSQL + '  F.FOR_NOMFOR, ';
                          strSQL := strSQL + '  F.FOR_NOMFAN, ';
                          strSQL := strSQL + '  F.FOR_ENDERE, ';
                          strSQL := strSQL + '  F.FOR_BAIRRO, ';
                          strSQL := strSQL + '  C.CID_NOMCID, ';
                          strSQL := strSQL + '  C.CID_ESTADO, ';
                          strSQL := strSQL + '  F.FOR_CONTAT, ';
                          strSQL := strSQL + '  F.FOR_C_G_C_, ';
                          strSQL := strSQL + '  F.FOR_I_E_S_, ';
                          strSQL := strSQL + '  F.FOR_C_E_P_, ';
                          strSQL := strSQL + '  F.FOR_FONE01, ';
                          strSQL := strSQL + '  A.ATI_DESATI, ';
                          strSQL := strSQL + '  F.AUTOINCREM, ';
                          strSQL := strSQL + '  F.FOR_CGCCPF, ';
                          strSQL := strSQL + '  F.FOR_STATUS  ';
                          strSQL := strSQL + 'FROM            ';
                          strSQL := strSQL + '  CADFOR F      ';
                          strSQL := strSQL + '  LEFT JOIN CADCID C ON F.FOR_CODCID = C.CID_CODCID ';
                          strSQL := strSQL + '  LEFT JOIN CADATI A ON F.FOR_CODATI = A.ATI_CODATI ';

                          SetLength(arrTitCol, 13);
                          arrTitCol[00] := 'Código';
                          arrTitCol[01] := 'Razão Social';
                          arrTitCol[02] := 'Nome Fantasia';
                          arrTitCol[03] := 'Endereço';
                          arrTitCol[04] := 'Bairro';
                          arrTitCol[05] := 'Cidade';
                          arrTitCol[06] := 'UF';
                          arrTitCol[07] := 'Contato';
                          arrTitCol[08] := 'CNPJ';
                          arrTitCol[09] := 'Insc. Est.';
                          arrTitCol[10] := 'CEP';
                          arrTitCol[11] := 'Telefone 1';
                          arrTitCol[12] := 'Atividade';
                        End;
        conForSimples:  Begin
                          strSQL := '';
                          strSQL := strSQL + 'SELECT FOR_CODFOR,  ';
                          strSQL := strSQL + '  F.FOR_NOMFOR,     ';
                          strSQL := strSQL + '  F.FOR_NOMFAN,     ';
                          strSQL := strSQL + '  F.FOR_C_G_C_,     ';
                          strSQL := strSQL + '  F.FOR_I_E_S_,     ';
                          strSQL := strSQL + '  F.FOR_FONE01,     ';
                          strSQL := strSQL + '  A.ATI_DESATI,     ';
                          strSQL := strSQL + '  F.AUTOINCREM,     ';
                          strSQL := strSQL + '  F.FOR_CGCCPF,     ';
                          strSQL := strSQL + '  F.FOR_STATUS      ';
                          strSQL := strSQL + 'FROM                ';
                          strSQL := strSQL + '  CADFOR F          ';
                          strSQL := strSQL + '  LEFT JOIN CADATI A ON F.FOR_CODATI = A.ATI_CODATI ';
                          {***************************************}
                          {* TÍTULO DA COLUNA E MÁSCARA DO CAMPO *}
                          {************************************RV*}
                          SetLength(arrTitCol, 07);
                          arrTitCol[00] := 'Código';
                          arrTitCol[01] := 'Razão Social';
                          arrTitCol[02] := 'Nome Fantasia';
                          arrTitCol[03] := 'CNPJ';
                          arrTitCol[04] := 'Insc. Est.';
                          arrTitCol[05] := 'Telefone 1';
                          arrTitCol[06] := 'Atividade';
                        End;
      End;

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      objConsulta := TDefMascaraFornecedor.Create;

      If fConsulta([strSQL, strWhere],
                   arrTitCol,
                   ['FOR_NOMFOR','FOR_NOMFAN','FOR_CODFOR'],
                   '',
                   'CADFOR',
                   Self.Name + IIf(opcConFor = conForSimples, '.', ''),
                   'Consulta de Fornecedores' + IIf(opcConFor = conForSimples, '.', ''),
                   qryConsulta,
                   objFrmPnl,
                   blnConSim,
                   arrSel,
                   'FOR_CODFOR',
                   objConsulta,
                   False,
                   False,
                   '',
                   Nil,
                   True,
                   True,
                   True,
                   fCadFor,
                   Nil,
                   Nil,
                   VS_Application) Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('FOR_CODFOR').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('FOR_CODFOR').AsString;
        End;

        If Assigned(edtNomEmp) Then
          edtNomEmp.Text := qryConsulta.FieldByName('FOR_NOMFOR').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 8)
            Else
              edtCodigo.Text := fStrZero('0', 8);
          End;

          If Assigned(edtNomEmp) Then
            edtNomEmp.Text := '+1';

        End;

        Result := True;
      End;

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);

      FreeAndNil(objConsulta);

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;


procedure TDefMascaraCliente.pDisplayCGCCPF(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
  Var
    intIndex: Integer;
begin
  intIndex := fIdxCampo('CLI_CGCCPF');

  If VarToStr(ARecord.Values[intIndex]) = '1' Then
    AText := FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_G_C_), AText)
  Else
    AText := FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_P_F_), AText);
end;

Constructor TDefMascaraCliente.Create;
Begin
  Inherited Create;

  blnColorirGrid := True;

  cxsInativo := TcxStyle.Create(Nil);
  cxsInativo.TextColor := clPurple;

  cxsSCPC    := TcxStyle.Create(Nil);
  cxsSCPC.TextColor := clRed;

  pIncluiIndCampos(['CLI_CGCCPF']);

  pIncluiDefMascara('CLI_C_G_C_', pDisplayCGCCPF);
  pIncluiDefMascara('CLI_CEPCOB', pDisplayCep);
  pIncluiDefMascara('CLI_CEPENT', pDisplayCep);
  pIncluiDefMascara('CLI_C_E_P_', pDisplayCep);
  pIncluiDefMascara('CLI_FONE01', pDisplayFone);
End;

function TDefMascaraCliente.fGetCellStyle(AView: TcxGridDBTableView;
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; ADataSet: TDataSet): TcxStyle;
  Var
    ARowInfo: TcxRowInfo;

  function fIdxColumn(strCampo: String): Integer;
  begin
    Result := -1;

    {********************************************************}
    {* ESSA FUNÇAO TEVE DE ALTERAR O COMPONENTE DEV-EXPRESS *}
    {* SE ESTA OCORRENDO ERRO DE TYPECAST VC DEVE VERIFICAR *}
    {* NOS COMPONENTES SE A CORREÇÃO FOI APLICADA EM SUA    *}
    {* MÁQUINA                                              *}
    {*****************************************************AF*}
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

  If blnColorirGrid And ARecord.IsData And (ARecord.Index > -1) Then
  Begin

    If IfNull(fGetValor(fIdxColumn('CLI_STATUS')), '') = 'INATIVO' Then
      Result := cxsInativo

    Else If IfNull(fGetValor(fIdxColumn('CLI_QTDPRO')), 0) > 0 Then
      Result := cxsSCPC;
  End;

end;

destructor TDefMascaraCliente.Destroy;
begin
  FreeAndNil(cxsInativo);
  FreeAndNil(cxsSCPC);
  inherited;
end;

procedure TDefMascaraFornecedor.pDisplayCGCCPF(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
  Var
    intIndex: Integer;
begin
  intIndex := fIdxCampo('FOR_CGCCPF');

  If VarToStr(ARecord.Values[intIndex]) = '1' Then
    AText := FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_G_C_), AText)
  Else
    AText := FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_P_F_), AText);

end;

Constructor TDefMascaraFornecedor.Create;
Begin
  Inherited Create;
  cxsStatusInativo := TcxStyle.Create(nil);
  cxsStatusInativo.TextColor := clPurple;
  pIncluiIndCampos(['FOR_CGCCPF']);

  pIncluiDefMascara('FOR_C_G_C_', pDisplayCGCCPF);
  pIncluiCamposCep(['FOR_C_E_P_']);
End;

destructor TDefMascaraFornecedor.destroy;
begin
  FreeAndNil(cxsStatusInativo);
end;

function TDefMascaraFornecedor.fGetCellStyle(AView: TcxGridDBTableView;
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
  ADataSet: TDataSet): TcxStyle;
  Var
    ARowInfo: TcxRowInfo;


  function fIdxColumn(strCampo: String): Integer;
  begin
    Result := -1;

    {********************************************************}
    {* ESSA FUNÇAO TEVE DE ALTERAR O COMPONENTE DEV-EXPRESS *}
    {* SE ESTA OCORRENDO ERRO DE TYPECAST VC DEVE VERIFICAR *}
    {* NOS COMPONENTES SE A CORREÇÃO FOI APLICADA EM SUA    *}
    {* MÁQUINA                                              *}
    {*****************************************************AF*}
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
  If ARecord.IsData And (ARecord.Index > -1) Then
  Begin
    If fGetValor(fIdxColumn('FOR_STATUS')) = 'I' Then
       Result := cxsStatusInativo;
  End;
end;

destructor TDefMascaraCentroCusto.Destroy;
begin
  FreeAndNil(cxsGrupos);
  inherited;
end;

function TDefMascaraCentroCusto.fGetCellStyle(AView: TcxGridDBTableView;
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
  ADataSet: TDataSet): TcxStyle;
  Var
    ARowInfo: TcxRowInfo;

  function fIdxColumn(strCampo: String): Integer;
  begin
    Result := -1;

    {********************************************************}
    {* ESSA FUNÇAO TEVE DE ALTERAR O COMPONENTE DEV-EXPRESS *}
    {* SE ESTA OCORRENDO ERRO DE TYPECAST VC DEVE VERIFICAR *}
    {* NOS COMPONENTES SE A CORREÇÃO FOI APLICADA EM SUA    *}
    {* MÁQUINA                                              *}
    {*****************************************************AF*}
    If ADataSet.FindField(strCampo) <> nil Then
      If AView.GetColumnByFieldName(strCampo) <> nil Then
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
  If ARecord.IsData And (ARecord.Index > -1) Then
  Begin
    If fIdxColumn('CTA_CODCTA') > -1 Then
      If RightStr(fGetValor(fIdxColumn('CTA_CODCTA')), 3) = '000' Then
        Result := cxsGrupos;
  End;
end;

procedure TDefMascaraCentroCusto.pDisplayPlanoContabil(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  if Assigned(fMskCon) then
    AText := FormatMaskText(fMskCon, AText);
end;

procedure TDefMascaraCentroCusto.pDisplayCodigo(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  AText := FormatMaskText('99.99.999;0;', AText)
end;

Constructor TDefMascaraCentroCusto.Create;
  Var
    strLinha,
    strGrupo: String;
Begin
  Inherited Create;

  cxsGrupos           := TcxStyle.Create(nil);
  cxsGrupos.TextColor := clRed;

  pIncluiDefMascara('CTA_CODCTA', pDisplayCodigo);
  pIncluiDefMascara('CTA_PLANCO', pDisplayPlanoContabil);

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
End;

procedure TDefMascaraKmRodado.pDisplayPlacaVeiculo(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  AText := FormatMaskText('999-9999;0;', AText)
end;

Constructor TDefMascaraKmRodado.Create;
Begin
  Inherited Create;

  pIncluiDefMascara('KMT_PLAVEI', pDisplayPlacaVeiculo);
  pIncluiDefMascara('VEI_PLAVEI', pDisplayPlacaVeiculo);

End;

procedure TDefMascaraCNAE.pDisplayCNAE(Sender: TcxCustomGridTableItem;
                                      ARecord: TcxCustomGridRecord;
                                    var AText: string);
begin
  AText := FormatMaskText('9999-9/99;0;_', AText);
end;

Constructor TDefMascaraCNAE.Create;
Begin
  Inherited Create;
  pIncluiDefMascara('CNA_CODCNA', pDisplayCNAE);
End;

{*******************************************************}
{* FUNÇÃO CRIDA PARA CHAMADA DA NOVA CONSULTA DE ITENS *}
{****************************************************JU*}
function fPesqItem(opcTipIte: TTipoConsultaItem;
                   Self     : TForm;                         {* Formulário                                  *}
                   edtCodigo: TCustomEdit;                   {* Edit do Código                              *}
                   edtDesIte: TCustomEdit;                   {* Edit da Descrição do item                   *}
                   qryTabela: TUniQuery;                     {* Query                                       *}
                   Var chrKey: Char;                         {* Key                                         *}
                   Var arrSel: TConsultasArray;              {* Array de Seleção                            *}
                   blnConSim: Boolean = True;                {* Consulta Simples ou Múltipla (multi select) *}
                   objFrmPnl: TPanelCx = Nil;                {* Painel                                      *}
                   strTitulo: string = 'Consulta de Itens';
                   strTabPre: String = '1';
                   strConPag: String = '';
                   fltTaxVpr: Double = 0;
                   blnEmpFat: Boolean = False;
                   blnExiPar: Boolean = False;
                   intOpcAtivos: Integer = 0;
                   opcCodIte: TCodigoRetornoItem = cdrCodIte;
                   strAplica: String = '';
                   blnPedCom: Boolean = False;   {* Se é pedido de compra                        *}
                   strCodCli: String = '';
                   blnMostrarPrecos: Boolean = True;
                   blnTablet: Boolean = False;
                   blnConsiderarExiLis: Boolean = True;
                   strCodCmp: String = ''; // Codigo do Comprador
                   blnDepMatPriIndustrial: Boolean = False;
                   blnDepProAcaIndustrial: Boolean = False;
                   blnDepProEmbIndustrial: Boolean = False;
                   blnDepProGraIndustrial: Boolean = False;
                   blnVeioF11: Boolean = False;
                   blnSomenteAgrotoxico: Boolean = False;
                   blnMostrarItensDeServico: Boolean = False;
                   blnExibeColunaSaldoCD: Boolean = False;
                   strEmp_CD: String = '';
                   fltDescFidelidade: Double = -1;
                   blnFaturamento: Boolean = False;
                   strCodFab: String = '';
                   blnMostraSaldo: Boolean = True;
                   strFiltros: string = '';
                   strCodEmp: String = '';
                   strEmpSaldoMatrizCD: String = '';
                   strDescri: String = '';
                   strCodBar: String = '';
                   strProdutoLocalizar: String = '';
                   blnConfirma: Boolean = True;
                   blnConEquEnt: Boolean = False;
                   blnSomenteEstrutura: Boolean = False;
                   objPnlBanner: TPanelCx = Nil;
                   objPnlPreFiltro: TPanelCx = Nil;
                   strCodCnd: String = '';
                   strNumOrc: String = '';
                   strEspOrc: String = ''): Boolean;
begin
  Result := untPesqItem.fPesqItem(opcTipIte,
                                  Self,
                                  edtCodigo,
                                  edtDesIte,
                                  qryTabela,
                                  chrKey,
                                  arrSel,
                                  blnConSim,
                                  objFrmPnl,
                                  strTitulo,
                                  strTabPre,
                                  strConPag,
                                  fltTaxVpr,
                                  blnEmpFat,
                                  blnExiPar,
                                  intOpcAtivos,
                                  opcCodIte,
                                  strAplica,
                                  blnPedCom,
                                  strCodCli,
                                  blnMostrarPrecos,
                                  blnTablet,
                                  blnConsiderarExiLis,
                                  strCodCmp,
                                  blnDepMatPriIndustrial,
                                  blnDepProAcaIndustrial,
                                  blnDepProEmbIndustrial,
                                  blnDepProGraIndustrial,
                                  blnVeioF11,
                                  blnSomenteAgrotoxico,
                                  blnMostrarItensDeServico,
                                  blnExibeColunaSaldoCD,
                                  strEmp_CD,
                                  fltDescFidelidade,
                                  blnFaturamento,
                                  strCodFab,
                                  blnMostraSaldo,
                                  strFiltros,
                                  strCodEmp,
                                  strEmpSaldoMatrizCD,
                                  strDescri,
                                  strCodBar,
                                  strProdutoLocalizar,
                                  blnConfirma,
                                  blnConEquEnt,
                                  blnSomenteEstrutura,
                                  objPnlBanner,
                                  objPnlPreFiltro,
                                  strCodCnd,
                                  strNumOrc,
                                  strEspOrc);
end;


{************************************************************}
{* FUNÇÃO CRIDA PARA CHAMADA DA NOVA CONSULTA DE PORTADORES *}
{*********************************************************JU*}
function fPesqPortador(opcTipPor: TTipoConsultaSimples;
                       Self     : TForm;
                       edtCodigo: TCustomEdit;
                       edtDesPor: TEditFocus;
                       qryTabela: TUniQuery;
                       Var chrKey: Char;
                       Var arrSel: TConsultasArray;
                       blnConSim: Boolean = True;
                       strTitulo: String = 'Consulta de Portadores';
                       strBolFat: String = '';
                       blnSalPor: Boolean = False;
                       blnImpBol: Boolean = False): Boolean;
  Var
    strSQL       : String;
    strWhere     : String;
    qryConsulta  : TUniQuery;
    arrTitCol    : TColunasArray;                                 {* Títulos das Colunas                         *}
    dfmPortadores: TDefConsultaPortadores;
    objDefConsultaPlanoContabil : TDefConsultaPlanoContabil;

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
      strSQL := strSQL + '  POR_ENTPCO, '; pAddNomeColuna('Entra na Posição Contábil/C.Receb.Análise de Resultados');
      strSQL := strSQL + '  POR_TRANSF, '; pAddNomeColuna('Utilizado para Transferências');
      strSQL := strSQL + '  POR_CONCON, '; pAddNomeColuna('Conta Contábil');
      strSQL := strSQL + '  POR_PERBAI, '; pAddNomeColuna('Permitir Baixa CTP/CTR/CHQ/CAR?');
      strSQL := strSQL + '  POR_MOVBAN, '; pAddNomeColuna('Permitir Movimento Bancário');
      strSQL := strSQL + '  POR_SALPOR, '; pAddNomeColuna('Entra no Saldo Por Portador');
      strSQL := strSQL + '  POR_PLANCO, '; pAddNomeColuna('Plano Contábil');
      strSQL := strSQL + ' AUTOINCREM ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADPOR ';

      strWhere := '';
      strWhere := strWhere + 'WHERE ';
      strWhere := strWhere + '  POR_CODPOR IS NOT NULL ';

      If Not fEmptyStr(strBolFat) Then
        strWhere := strWhere + ' AND POR_BOLFAT = ' + QuotedStr(strBolFat);

      If blnImpBol Then
        strWhere := strWhere + ' AND COALESCE(POR_IMPBOL, "S") = "S" ';

      If blnSalPor Then
        strWhere := strWhere + ' AND POR_SALPOR = "S" ';

      If opcTipPor = conParaBaixas Then
        strWhere := strWhere + ' AND POR_PERBAI = ' + QuotedStr('S') + ' AND POR_MOVBAN = ' + QuotedStr('S') + ' ';

      If opcTipPor = conTransfCx then
        strWhere := strWhere + ' AND POR_PERTRA = ' + QuotedStr('S') + ' ';

      If (fCfgSis('DACPOR', varBoolean)) And
         (Not blnConSim)                 Then
        strWhere := strWhere + '  AND LOCATE(POR_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0 ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If (fCfgSis('DACPOR', varBoolean)) And
         (blnConSim)                     Then
        dfmPortadores := TDefConsultaPortadores.Create
      Else
        dfmPortadores := Nil;

      If Not Assigned(dfmPortadores) Then
        objDefConsultaPlanoContabil := TDefConsultaPlanoContabil.Create(['POR_PLANCO']);

      if fConsulta([strSQL, strWhere],
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
                   IIF(Assigned(dfmPortadores), dfmPortadores, objDefConsultaPlanoContabil)) then
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

      If Assigned(dfmPortadores) Then
        FreeAndNil(objDefConsultaPlanoContabil);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End
end;

{*****************************}
{* CONSULTA DE UNIDADES      *}
{**************************AC*}
function fPesqUnidade(Self      : TForm;                           {* Formulário                                  *}
                      edtCodigo : TCustomEdit;                     {* Edit do Código                              *}
                      edtUnidade: TEditFocus;                      {* Edit da Cidade                              *}
                      edtSigla  : TEditFocus;                      {* Edit da Sigla da Unidade                    *}
                      qryTabela : TUniQuery;                         {* Query                                       *}
                      Var chrKey: Char;                            {* Key                                         *}
                      Var arrSel: TConsultasArray;                 {* Array de Seleção                            *}
                      blnConSim : Boolean = True;                  {* Consulta Simples ou Múltipla (multi select) *}
                      blnPesqSigla : Boolean = False;
                      blnFiltroCodEmp: Boolean = False;
                      strFiltros: string = ''): Boolean;                    { Passa o filtro no Select com o Código da Empresa *}

  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
    arrTitCol,
    arrCamKey  : TColunasArray; {* Títulos das Colunas  *}
    objConsulta: TDefConsulta;

  Procedure pAddNomeColuna(strNomCol: String);
  Begin
    SetLength(arrTitCol, Succ(Length(arrTitCol)));
    arrTitCol[High(arrTitCol)] := strNomCol;
  End;

  Procedure pAddCamposKey(strNomCol: String);
  Begin
    SetLength(arrCamKey, Succ(Length(arrCamKey)));
    arrCamKey[High(arrCamKey)] := strNomCol;
  End;


begin
  Result := False;

  If fEntraCons(chrKey) Then
  Begin
    Try
      objConsulta := TDefConsulta.Create;
      SetLength(arrTitCol, 0);
      SetLength(arrCamKey, 0);

      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';

      If Not blnPesqSigla Then
      Begin
        strSQL := strSQL + '  UNI_CODUNI,       ';  pAddNomeColuna('Código');
        strSQL := strSQL + '  UNI_DESUNI,       ';  pAddNomeColuna('Unidade');
        strSQL := strSQL + '  UNI_PESLIT,       ';  pAddNomeColuna('Peso.Litro');
        strSQL := strSQl + '  UNI_KILLIT,       ';  pAddNomeColuna('Kilo/Litro');
        objConsulta.pFormataDecimal('UNI_PESLIT', 3);


        pAddCamposKey('UNI_DESUNI');
        pAddCamposKey('UNI_CODUNI');
      End Else
      Begin
        pAddCamposKey('UNI_SIGUNI');
      End;

      strSQL := strSQL + '  UNI_SIGUNI,  ';    pAddNomeColuna('Sigla');

      If Assigned(edtCodigo) Then
        strSQL := strSQL + '  AUTOINCREM        '
      Else
        strSQL := strSQL + '  UNI_SIGUNI AS AUTOINCREM  ';

      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  CADUNI            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;



      If fConsulta([strSQL, ' WHERE TRUE ' + IIF(blnFiltroCodEmp, ' AND UNI_CODEMP = '  + VS_strCodEmp, ' ') + ' ' + strFiltros,
                            IIF(Assigned(edtSigla), ' GROUP BY UNI_SIGUNI', '')],
                   arrTitCol,
                   arrCamKey,
                   IIF(Assigned(edtSigla), 'UNI_SIGUNI', 'UNI_CODUNI'),
                   'CADUNI',
                   Self.Name,
                   'Consulta de Unidades',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   IIF(Assigned(edtSigla), 'UNI_SIGUNI', 'UNI_CODUNI'),
                   objConsulta) Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('UNI_CODUNI').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('UNI_CODUNI').AsString;
        End;

        If Assigned(edtUnidade) Then
          edtUnidade.Text := qryConsulta.FieldByName('UNI_DESUNI').AsString;

        If Assigned(edtSigla) Then
          edtSigla.Text := qryConsulta.FieldByName('UNI_SIGUNI').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 2)
            Else
              edtCodigo.Text := fStrZero('0', 2);
          End;

          If Assigned(edtUnidade) Then
            edtUnidade.Text := '+1'

          Else If Assigned(edtCodigo) Then
            edtCodigo.Text := '+1'

          Else If Assigned(edtSigla) Then
            edtSigla.Text := '+1';

        End;

        Result := True;

        If Not Assigned(qryTabela) Then
          FreeAndNil(qryConsulta);
        FreeAndNil(objConsulta);
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

function fPesqTabelaSimplesNacional(Self      : TForm;                            {* Formulário                                  *}
                                    edtCodigo : TCustomEdit;                      {* Edit do Código                              *}
                                    edtDescri : TEditFocus;                       {* Edit da Descrição                           *}
                                    qryTabela : TUniQuery;                        {* Query                                       *}
                                    Var chrKey: Char;                             {* Key                                         *}
                                    Var arrSel: TConsultasArray;                  {* Array de Seleção                            *}
                                    blnConSim : Boolean = True): Boolean;         {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL, strWhere: String;
    qryConsulta: TUniQuery;
    arrTitCol,
    arrCamKey  : TColunasArray; {* Títulos das Colunas  *}

  Procedure pAddNomeColuna(strNomCol: String);
  Begin
    SetLength(arrTitCol, Succ(Length(arrTitCol)));
    arrTitCol[High(arrTitCol)] := strNomCol;
  End;

  Procedure pAddCamposKey(strNomCol: String);
  Begin
    SetLength(arrCamKey, Succ(Length(arrCamKey)));
    arrCamKey[High(arrCamKey)] := strNomCol;
  End;

  Const
    SQL_TIPTAB = 'IF(TSN_TIPTAB = "0", "Comércio", ' +
                   'IF(TSN_TIPTAB = "1", "Indústria", ' +
                     'IF(TSN_TIPTAB = "2", "Serviço (Anexo III)", ' +
                       'IF(TSN_TIPTAB = "3", "Serviço (Anexo IV)", ' +
                         'IF(TSN_TIPTAB = "4", "Serviço (Anexo V)", ' +
                           'IF(TSN_TIPTAB = "5", "Serviço (Anexo V-A)", "Não definido"))))))';

begin
  Result := False;

  If fEntraCons(chrKey) Then
  Begin
    Try
      SetLength(arrTitCol, 0);
      SetLength(arrCamKey, 0);

      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  TSN_CODIGO,       ';           pAddNomeColuna('Código');
      strSQL := strSQL + '  TSN_DESCRI,       ';           pAddNomeColuna('Descrição');
      strSQL := strSQL + SQL_TIPTAB + ' AS TSN_TIPTAB, ';  pAddNomeColuna('Tipo Tabela');
      strSQL := strSQL + '  TSN_INIVIG,       ';           pAddNomeColuna('Início Vigência');
      strSQL := strSQl + '  TSN_CODEMP,       ';           pAddNomeColuna('Empresa');
      strSQL := strSQL + '  TSN_CODOPE,       ';           pAddNomeColuna('Operador');
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  CADTSN            ';

      pAddCamposKey('TSN_DESCRI');
      pAddCamposKey('TSN_CODIGO');

      If (Not Assigned(qryTabela)) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      strWhere := ' ';

      If fConsulta([strSQL, strWhere],
                   arrTitCol,
                   arrCamKey,
                   'TSN_CODIGO',
                   'CADTSN',
                   Self.Name,
                   'Consulta de Tabelas de Faixas do Simples Nacional',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'TSN_CODIGO') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('TSN_CODIGO').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('TSN_CODIGO').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('TSN_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 3)
            Else
              edtCodigo.Text := fStrZero('0', 3);
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
        pMensagensErro(E.Message, 'fPesqTabelaSimplesNacional');
      End;
    End;
  End;
end;

function fPesqCadastroEmbarcacoes(Self      : TForm;                            {* Formulário                                  *}
                                  edtCodigo : TCustomEdit;                      {* Edit do Código                              *}
                                  edtDescri : TEditFocus;                       {* Edit da Descrição                           *}
                                  qryTabela : TUniQuery;                        {* Query                                       *}
                                  Var chrKey: Char;                             {* Key                                         *}
                                  Var arrSel: TConsultasArray;                  {* Array de Seleção                            *}
                                  blnConSim : Boolean = True;                   {* Consulta Simples ou Múltipla (multi select) *}
                                  strCodCli : String = ''): Boolean;            {* Código do cliente *}
  Var
    strSQL, strWhere: String;
    qryConsulta: TUniQuery;
    arrTitCol,
    arrCamKey  : TColunasArray; {* Títulos das Colunas  *}

  Procedure pAddNomeColuna(strNomCol: String);
  Begin
    SetLength(arrTitCol, Succ(Length(arrTitCol)));
    arrTitCol[High(arrTitCol)] := strNomCol;
  End;

  Procedure pAddCamposKey(strNomCol: String);
  Begin
    SetLength(arrCamKey, Succ(Length(arrCamKey)));
    arrCamKey[High(arrCamKey)] := strNomCol;
  End;

  Const
    SQL_PORTE  = ' IF(G.EMB_PORTE_ = "0", "PEQUENO", IF(G.EMB_PORTE_ = "1", "MÉDIO", IF(G.EMB_PORTE_ = "2", "GRANDE", "NÃO INDORMADO"))) ';
    SQL_DRABCK = ' IF(G.EMB_DRABCK = "S", "SIM", "NÃO") ';

begin
  Result := False;

  If fEntraCons(chrKey) Then
  Begin
    Try
      SetLength(arrTitCol, 0);
      SetLength(arrCamKey, 0);

      chrKey := #0;

      strSQL := 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  G.EMB_CODEMB, ';              pAddNomeColuna('Código');
      strSQL := strSQL + '  G.EMB_NUMIMO, ';              pAddNomeColuna('Número da IMO');
      strSQL := strSQL + '  G.EMB_INSCRI, ';              pAddNomeColuna('Número da Inscrição');
      strSQL := strSQL + '  G.EMB_NOMEMB, ';              pAddNomeColuna('Nome da Embarcação');
      strSQL := strSQL + '  G.EMB_INDEMB, ';              pAddNomeColuna('Indicativo do Navio');
      strSQL := strSQL + '  G.EMB_PORTOI, ';              pAddNomeColuna('Porto de Inscrição');
      strSQL := strSQL + '  G.EMB_LOCEMB, ';              pAddNomeColuna('Local do Barco');
      strSQL := strSQL + SQL_PORTE + ' AS EMB_PORTE_, ';  pAddNomeColuna('Porte do Barco');
      strSQL := strSQL + '  G.EMB_COMPRI, ';              pAddNomeColuna('Comprimento');
      strSQL := strSQL + '  G.EMB_ARQBRU, ';              pAddNomeColuna('Arqueação Bruta');
      strSQL := strSQL + SQL_DRABCK + ' AS EMB_DRABCK, '; pAddNomeColuna('Incide Oper. Drawback');
      strSQL := strSQL + '  G.EMB_OBSERV, ';              pAddNomeColuna('Observações');
      strSQL := strSQL + '  G.EMB_OBSDBK, ';              pAddNomeColuna('Obs. Drawback');
      strSQL := strSQL + '  G.AUTOINCREM ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADEMB G ';

      If (Not fEmptyStr(strCodCli)) Then
        strSQL := strSQL + ' INNER JOIN CLIEMB D ON G.AUTOINCREM = D.EMB_CODEMB ';

      pAddCamposKey('EMB_NOMEMB');
      pAddCamposKey('EMB_CODEMB');

      If (Not Assigned(qryTabela)) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If (Not fEmptyStr(strCodCli)) Then
        strWhere := ' WHERE D.EMB_CODCLI = ' + QuotedStr(strCodCli) + ' '
      Else
        strWhere := ' ';

      If fConsulta([strSQL, strWhere],
                   arrTitCol,
                   arrCamKey,
                   'EMB_CODEMB',
                   'CADEMB',
                   Self.Name,
                   'Consulta de Embarcações',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'EMB_CODEMB') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('EMB_CODEMB').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('EMB_CODEMB').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('EMB_NOMEMB').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 6)
            Else
              edtCodigo.Text := fStrZero('0', 6);
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
        pMensagensErro(E.Message, 'fPesqCadastroEmbarcacoes');
      End;
    End;
  End;
end;

function fPesqCadastroEquipLocacao(Self      : TForm;                            {* Formulário                                  *}
                                   edtCodigo : TCustomEdit;                      {* Edit do Código                              *}
                                   edtDescri : TEditFocus;                       {* Edit da Descrição                           *}
                                   qryTabela : TUniQuery;                        {* Query                                       *}
                                   Var chrKey: Char;                             {* Key                                         *}
                                   Var arrSel: TConsultasArray;                  {* Array de Seleção                            *}
                                   blnConSim : Boolean = True): Boolean;         {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL, strWhere: String;
    qryConsulta: TUniQuery;
    arrTitCol,
    arrCamKey: TColunasArray;
    objConsulta: TDefConsulta;

  Procedure pAddNomeColuna(strNomCol: String);
  Begin
    SetLength(arrTitCol, Succ(Length(arrTitCol)));
    arrTitCol[High(arrTitCol)] := strNomCol;
  End;

  Procedure pAddCamposKey(strNomCol: String);
  Begin
    SetLength(arrCamKey, Succ(Length(arrCamKey)));
    arrCamKey[High(arrCamKey)] := strNomCol;
  End;

begin
  Result := False;

  If fEntraCons(chrKey) Then
  Begin
    Try
      SetLength(arrTitCol, 0);
      SetLength(arrCamKey, 0);

      chrKey := #0;

      strSQL := 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  EQL_CODIGO, ';              pAddNomeColuna('Código');
      strSQL := strSQL + '  EQL_DESCRI, ';              pAddNomeColuna('Descrição');
      strSQL := strSQL + '  EQL_NSERIE, ';              pAddNomeColuna('Nro Série');
      strSQL := strSQL + '  EQL_DTAAQU, ';              pAddNomeColuna('Data de Aquisição');
      strSQL := strSQL + '  EQL_VALAQU, ';              pAddNomeColuna('Valor de Aquisição');
      strSQL := strSQL + '  EQL_VALLOC, ';              pAddNomeColuna('Valor de Locação (hora)');
      strSQL := strSQL + '  EQL_GARANT, ';              pAddNomeColuna('Garantia (meses)');
      strSQL := strSQL + '  EQL_DTULMN, ';              pAddNomeColuna('Data da Última Manutenção');
      strSQL := strSQL + '  EQL_RPULMN, ';              pAddNomeColuna('Responsável pela Última Manutenção');
      strSQL := strSQL + '  EQL_MODELO, ';              pAddNomeColuna('Modelo');
      strSQL := strSQL + '  EQL_ANOFAB, ';              pAddNomeColuna('Ano de Fabricação');
      strSQL := strSQL + '  EQL_ESPECF, ';              pAddNomeColuna('Especificações');
      strSQL := strSQL + '  EQL_LOCFIS, ';              pAddNomeColuna('Localização Física');
      strSQL := strSQL + '  DESITE,     ';              pAddNomeColuna('Produto');
      strSQL := strSQL + '  EQL_DTAVEN, ';              pAddNomeColuna('Data de Venda do Equipamento');
      strSQL := strSQL + '  STATUS,     ';              pAddNomeColuna('Situação');
      strSQL := strSQL + '  CADEQL.AUTOINCREM  ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADEQL ';
      strSQL := strSQL + '     INNER JOIN CADITE ON ITE_CODITE = EQL_CODITE ';

      pAddCamposKey('EQL_DESCRI');
      pAddCamposKey('EQL_CODIGO');

      If (Not Assigned(qryTabela)) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      objConsulta := TDefConsulta.Create;
      objConsulta.pIncluiSubConsulta('DESITE', 'CONCAT(EQL_CODITE, "-", ITE_DESITE)');
      objConsulta.pIncluiSubConsulta('STATUS', 'IF(EQL_STATUS = "A", "ATIVO", "INATIVO")');
      objConsulta.pIncluiCampoSimNao('STATUS', ['ATIVO', 'INATIVO', 'TODOS']);

      strWhere := ' ';

      If fConsulta([strSQL, strWhere],
                   arrTitCol,
                   arrCamKey,
                   'EQL_CODIGO',
                   'CADEQL',
                   Self.Name,
                   'Consulta de Equipamentos para Locação',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'EQL_CODIGO',
                   objConsulta) Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('EQL_CODIGO').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('EQL_CODIGO').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('EQL_DESCRI').AsString;

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

      FreeAndNil(objConsulta);

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, 'fPesqCadastroEquipLocacao');
      End;
    End;
  End;
end;

function fPesqContratoLocEquip(Self      : TForm;           {* Formulário     *}
                               edtCodigo : TCustomEdit;     {* Edit do Código *}
                               qryTabela : TUniQuery;       {* Query          *}
                               Var chrKey: Char): Boolean;  {* Key            *}

  Var
    strSQL, strWhere: String;
    qryConsulta: TUniQuery;
    arrTitCol,
    arrCamKey: TColunasArray;
    arrSel: TConsultasArray;
    objConsulta: TDefConsulta;

  Procedure pAddNomeColuna(strNomCol: String);
  Begin
    SetLength(arrTitCol, Succ(Length(arrTitCol)));
    arrTitCol[High(arrTitCol)] := strNomCol;
  End;

  Procedure pAddCamposKey(strNomCol: String);
  Begin
    SetLength(arrCamKey, Succ(Length(arrCamKey)));
    arrCamKey[High(arrCamKey)] := strNomCol;
  End;

begin
  Result := False;

  If fEntraCons(chrKey) Then
  Begin
    Try
      SetLength(arrTitCol, 0);
      SetLength(arrCamKey, 0);

      chrKey := #0;

      strSQL := 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  EQL_NROCON, ';   pAddNomeColuna('Número do contrato');
      strSQL := strSQL + '  STATUS,     ';   pAddNomeColuna('Status');
      strSQL := strSQL + '  EQL_CODCLI, ';   pAddNomeColuna('Código do cliente');
      strSQL := strSQL + '  CLI_NOMCLI, ';   pAddNomeColuna('Nome do cliente');
      strSQL := strSQL + '  EQL_DTAINI, ';   pAddNomeColuna('Data inicial');
      strSQL := strSQL + '  EQL_HORINI, ';   pAddNomeColuna('Hora inicial');
      strSQL := strSQL + '  EQL_DTAFIN, ';   pAddNomeColuna('Data final');
      strSQL := strSQL + '  EQL_HORFIN, ';   pAddNomeColuna('Hora final');
      strSQL := strSQL + '  EQL_QTDEQU, ';   pAddNomeColuna('Quantidade de equipamentos');
      strSQL := strSQL + '  EQL_TOTCON, ';   pAddNomeColuna('Valor total do contrato');
      strSQL := strSQL + '  CONEQL.AUTOINCREM  ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CONEQL ';
      strSQL := strSQL + 'INNER JOIN CADCLI ON CLI_CODCLI = EQL_CODCLI ';

      strWhere := ' WHERE EQL_CODEMP = ' + QuotedStr(VS_strCodEmp);

      pAddCamposKey('EQL_NROCON');
      pAddCamposKey('EQL_CODCLI');
      pAddCamposKey('CLI_NOMCLI');
      pAddCamposKey('EQL_DTAINI');
      pAddCamposKey('EQL_DTAFIN');

      If (Not Assigned(qryTabela)) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      objConsulta := TDefConsulta.Create;
      objConsulta.pIncluiSubConsulta('STATUS', 'CASE EQL_STATUS WHEN "O" THEN "ORÇAMENTO" WHEN "A" THEN "ATIVO" WHEN "F" THEN "FATURADO" END');
      objConsulta.pIncluiCampoSimNao('STATUS', ['ORÇAMENTO', 'ATIVO', 'FATURADO', 'TODOS']);

      If fConsulta([strSQL, strWhere],
                   arrTitCol,
                   arrCamKey,
                   'EQL_NROCON',
                   'CONEQL',
                   Self.Name,
                   'Consulta de Contratos de Locação de Equipamentos',
                   qryConsulta,
                   Nil,
                   True,
                   arrSel,
                   'EQL_NROCON',
                   objConsulta) Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('EQL_NROCON').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('EQL_NROCON').AsString;
        End;

        Result := True;

        If Not Assigned(qryTabela) Then
          FreeAndNil(qryConsulta);
      End;

      FreeAndNil(objConsulta);

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, 'fPesqContratoLocEquip');
      End;
    End;
  End;
end;

function fPesqFreteTransportadora(Self      : TForm;                            {* Formulário                                  *}
                                  edtCodTra : TCustomEdit;                      {* Edit da Transportadora                      *}
                                  edtCodCid : TCustomEdit;                       {* Edit da Cidade                              *}
                                  qryTabela : TUniQuery;                          {* Query                                       *}
                                  Var chrKey: Char): Boolean;                   {* Key                                         *}
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
    arrTitCol: TColunasArray;                                 {* Títulos das Colunas                         *}
    arrSel: TConsultasArray;

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
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  FRE_CODTRA,       '; pAddNomeColuna('Cód. Transp.');
      strSQL := strSQL + '  TRA_NOMTRA,       '; pAddNomeColuna('Nome Transp.');
      strSQL := strSQL + '  FRE_CODCID,       '; pAddNomeColuna('Cód. Cidade');
      strSQL := strSQL + '  CID_NOMCID,       '; pAddNomeColuna('Nome Cidade');
      strSQL := strSQL + '  CID_ESTADO,       '; pAddNomeColuna('Estado');
      strSQL := strSQL + '  FRETRA.AUTOINCREM AS AUTOINCREM ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  FRETRA            ';
      strSQL := strSQL + '  JOIN CADTRA ON TRA_CODTRA = FRE_CODTRA ';
      strSQL := strSQL + '  JOIN CADCID ON CID_CODCID = FRE_CODCID ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Cód. Transp.',
                   'Nome Transp.',
                   'Cód. Cidade',
                   'Nome Cidade',
                   'Estado',
                   'AUTOINCREM'],
                   ['TRA_NOMTRA','CID_NOMCID','FRE_CODTRA'],
                   '',
                   'FRETRA',
                   Self.Name,
                   'Consulta de Frete por Transportadora / Cidade',
                   qryConsulta,
                   Nil,
                   True,
                   arrSel) Then
      Begin
        If Assigned(edtCodTra) then
        Begin
          edtCodTra.Text := qryConsulta.FieldByName('FRE_CODTRA').AsString;
          edtCodcID.Text := qryConsulta.FieldByName('FRE_CODCID').AsString;
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

function fPesqAD( Self      : TForm;                            {* Formulário        *}
                  edtCodAD  : TCustomEdit;                      {* Edit do AD        *}
                  qryTabela : TUniQuery;                          {* Query             *}
                  Var chrKey: Char;                             {* Key               *}
                  strCodCli : String;                           {* Cliente           *}
                  blnSomAbe : Boolean = False;                  {* Somente em aberto *}
                  strGarant : String = '') : Boolean;
  Var
    strSQL     : String;
    strSQLDet  : String;
    strWhere   : String;
    qryConsulta: TUniQuery;
    arrTitCol: TColunasArray;                                 {* Títulos das Colunas                         *}
    arrSel: TConsultasArray;
    arrOrd: Array of String;

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
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  DET_CODADE,       ';
      strSQL := strSQL + '  DET_CODEMP,       ';
      strSQL := strSQL + '  DET_CODMOT,       ';
      strSQL := strSQL + '  OCO_DESOCO,       ';
      strSQL := strSQL + '  DET_TIP_FC,       ';
      strSQL := strSQL + '  CLI_NOMCLI,       ';
      strSQL := strSQL + '  DET_FORCLI,       ';
      strSQL := strSQL + '  DET_GARANT,       ';
      strSQL := strSQL + '  ADEGER.AUTOINCREM ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  ADEGER            ';

      strSQL := strSQL + '  JOIN ADEDET ON DET_CODADE = GER_CODADE AND DET_CODEMP = GER_CODEMP ';

      If blnSomAbe Then
        strSQL := strSQL + ' AND GER_DOCDEV IS NULL ';

      strSQL := strSQL + '  JOIN CADOCO ON OCO_CODOCO = DET_CODMOT ';

      strSQL := strSQL + '  LEFT JOIN CADCLI ON CLI_CODCLI = DET_FORCLI ';

      strSQL := strSQL + 'GROUP BY ';
      strSQL := strSQL + '  ADEGER.AUTOINCREM ';

      strWhere := '';
      strWhere := strWhere + ' WHERE DET_TIP_FC = "C" ';

      If Not fEmptyStr(strCodCli) Then
        strWhere := strWhere + ' AND DET_FORCLI = ' + QuotedStr(strCodCli) + ' ';

      If not fEmptyStr(strGarant) Then
        strWhere := strWhere + ' AND DET_GARANT = ' + QuotedStr(strGarant) ;

      strSQLDet := strSQL;

      strSQL := 'SELECT ';
      strSQL := strSQL + '  DET_CODADE,       ';   pAddNomeColuna('Número');
      strSQL := strSQL + '  DET_CODEMP,       ';   pAddNomeColuna('Empresa');
      strSQL := strSQL + '  DET_CODMOT,       ';   pAddNomeColuna('Cód. Motivo');
      strSQL := strSQL + '  OCO_DESOCO,       ';   pAddNomeColuna('Motivo');

      If fEmptyStr(strCodCli) Then
      Begin
        strSQL := strSQL + '  DET_FORCLI, ';       pAddNomeColuna('Cód.Cliente');
        strSQL := strSQL + '  CLI_NOMCLI, ';       pAddNomeColuna('Nome do Cliente');

        SetLength(arrOrd, 5);

        arrOrd[0] := 'DET_CODADE';
        arrOrd[1] := 'OCO_DESOCO';
        arrOrd[2] := 'DET_CODMOT';
        arrOrd[3] := 'CLI_NOMCLI';
        arrOrd[4] := 'DET_FORCLI';
      End
      else
      begin

        SetLength(arrOrd, 3);

        arrOrd[0] := 'DET_CODADE';
        arrOrd[1] := 'OCO_DESOCO';
        arrOrd[2] := 'DET_CODMOT';
      end;

      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + ' FROM (' + strSQLDet + ') AS ADEDET ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL, strWhere],
                   arrTitCol,
                   arrOrd,
                   '',
                   'ADEGER',
                   Self.Name + IIF(fEmptyStr(strCodCli), '1', ''),
                   'Consulta de AD',
                   qryConsulta,
                   Nil,
                   True,
                   arrSel,
                   '') Then
      Begin
        If Assigned(edtCodAD) then
        Begin
          edtCodAD.Text := qryConsulta.FieldByName('GER_CODADE').AsString;
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

function fPesqConEquEnt(Self      : TForm;
                        edtNumDoc : TCustomEdit;
                        qryTabela : TUniQuery;
                        Var chrKey: Char;
                        Var strAutInc: String): Boolean;
  Var
    strSQL     : String;
    strWhere   : String;
    strGroup   : String;
    qryConsulta: TUniQuery;
    arrTitCol: TColunasArray;
    arrSel: TConsultasArray;

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
      strSQL := strSQL + 'SELECT DISTINCT ';
      strSQL := strSQL + '  GER_NUMDOC,       '; pAddNomeColuna('Número');
      strSQL := strSQL + '  GER_ESPDOC,       '; pAddNomeColuna('Espécie');
      strSQL := strSQL + '  GER_CODEMP,       '; pAddNomeColuna('Empresa');
      strSQL := strSQL + '  GER_SERIE_,       '; pAddNomeColuna('Série');
      strSQL := strSQL + '  GER_CODCLI,       '; pAddNomeColuna('Cód.Cliente');
      strSQL := strSQL + '  CLI_NOMCLI,       '; pAddNomeColuna('Nome Cliente');
      strSQL := strSQL + '  GER_DTAENT,       '; pAddNomeColuna('Dt.Entrada');
      strSQL := strSQL + '  MOVGER.AUTOINCREM ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  MOVGER            ';
      strSQL := strSQL + '       JOIN AUXMOV ON AUX_SEQGER = MOVGER.AUTOINCREM ';
      strSQL := strSQL + '  LEFT JOIN CADCLI ON CLI_CODCLI = GER_CODCLI ';

      strGroup := '';
      strGroup := strGroup + 'GROUP BY ';
      strGroup := strGroup + '  GER_NUMDOC, GER_ESPDOC, GER_CODEMP, GER_DTAENT ';

      strWhere := '';
      strWhere := strWhere + ' WHERE ';
      strWhere := strWhere + '   COALESCE(AUX_CONEQU, "N") = "S" AND ';
      strWhere := strWhere + '   LOCATE(GER_CLAFIS, "' + fTransform(fCfgSisL('CLACON'), 4) + '") > 0 ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL, strWhere, strGroup],
                   arrTitCol,
                   ['Número',
                   'Espécie',
                   'Empresa',
                   'AUTOINCREM'],
                   '',
                   'MOVGER',
                   Self.Name,
                   'Consulta de Nota de Entrada - Conserto de Equipamento',
                   qryConsulta,
                   Nil,
                   True,
                   arrSel,
                   '') Then
      Begin
        If Assigned(edtNumDoc) then
          edtNumDoc.Text := qryConsulta.FieldByName('GER_NUMDOC').AsString;

        strAutInc := qryConsulta.FieldByName('AUTOINCREM').AsString;

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
End;

function fPesqAgendamentoDevolucao(Self      : TForm;                            {* Formulário                                  *}
                                  edtCodAD  : TCustomEdit;                      {* Edit do AD                                  *}
                                  qryTabela : TUniQuery;                          {* Query                                       *}
                                  Var chrKey: Char;                             {* Key                                         *}
                                  strCodCli : String;                           {* Cliente                                     *}
                                  blnSemDev : Boolean = False): Boolean;        {* Sem devolucoes realizadas}
  Var
    strSQL     : String;
    strSQLDet  : String;
    strWhere   : String;
    qryConsulta: TUniQuery;
    arrTitCol: TColunasArray;                                 {* Títulos das Colunas                         *}
    arrSel: TConsultasArray;

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
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  DET_CODADE,       ';
      strSQL := strSQL + '  DET_NUMDOC,       ';
      strSQL := strSQL + '  DET_ESPDOC,       ';
      strSQL := strSQL + '  DET_CODEMP,       ';
      strSQL := strSQL + '  DET_CODMOT,       ';
      strSQL := strSQL + '  OCO_DESOCO,       ';
      strSQL := strSQL + '  DET_TIP_FC,       ';
      strSQL := strSQL + '  CLI_NOMCLI,       ';
      strSQL := strSQL + '  DET_FORCLI,       ';

      strSQL := strSQL + '  ADEDET.AUTOINCREM ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  ADEDET            ';

      strSQL := strSQL + '  JOIN ADEGER ON DET_CODADE = GER_CODADE AND DET_CODEMP = GER_CODEMP ';

      If blnSemDev Then
        strSQL := strSQL + ' AND GER_DOCDEV IS NULL ';

      strSQL := strSQL + '  JOIN CADOCO ON OCO_CODOCO = DET_CODMOT ';

      strSQL := strSQL + '  JOIN CADCLI ON CLI_CODCLI = DET_FORCLI ';

      strSQL := strSQL + 'GROUP BY ';
      strSQL := strSQL + '  DET_CODADE, DET_NUMDOC, DET_ESPDOC, DET_CODEMP, DET_FORCLI ';

      strWhere := '';
      strWhere := strWhere + ' WHERE DET_TIP_FC = "C" ';

      If Not fEmptyStr(strCodCli) Then
        strWhere := strWhere + ' AND DET_FORCLI = ' + QuotedStr(strCodCli) + ' ';

      strSQLDet := strSQL;

      strSQL := 'SELECT ';
      strSQL := strSQL + '  DET_CODADE,       ';   pAddNomeColuna('Número');
      strSQL := strSQL + '  DET_NUMDOC,       ';   pAddNomeColuna('Documento');
      strSQL := strSQL + '  DET_ESPDOC,       ';   pAddNomeColuna('Espécie');
      strSQL := strSQL + '  DET_CODEMP,       ';   pAddNomeColuna('Empresa');
      strSQL := strSQL + '  DET_CODMOT,       ';   pAddNomeColuna('Cód. Motivo');
      strSQL := strSQL + '  OCO_DESOCO,       ';   pAddNomeColuna('Motivo');

      If fEmptyStr(strCodCli) Then
      Begin
        strSQL := strSQL + '  DET_FORCLI, ';       pAddNomeColuna('Cód.Cliente');
        strSQL := strSQL + '  CLI_NOMCLI, ';       pAddNomeColuna('Nome do Cliente');
      End;

      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + ' FROM (' + strSQLDet + ') AS ADEDET ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL, strWhere],
                   arrTitCol,
                   ['DET_CODADE','DET_NUMDOC','DET_ESPDOC','OCO_DESOCO','DET_CODEMP'],
                   '',
                   'ADEDET',
                   Self.Name + IIF(fEmptyStr(strCodCli), '1', ''),
                   'Consulta de ADs',
                   qryConsulta,
                   Nil,
                   True,
                   arrSel,
                   '') Then
      Begin
        If Assigned(edtCodAD) then
        Begin
          edtCodAD.Text := qryConsulta.FieldByName('DET_CODADE').AsString;
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

{*****************************************************}
{* FUNÇÃO CRIDA PARA CHAMADA DA NOVA CONSULTA CFGREL *}
{**************************************************JU*}
function fPesqConfiguracaoRel(opcTipCfg: TTipoConsultaSimples;
                              Self     : TForm;                       {* Formulário                                  *}
                              edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                              edtDesPor: TEditFocus;                  {* Edit da Descrição do item                   *}
                              qryTabela: TUniQuery;                     {* Query                                       *}
                              Var chrKey: Char;                       {* Key                                         *}
                              Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                              strWhere : String;                      {* Where                                       *}
                              blnConSim: Boolean = True;              {* Consulta Simples ou Múltipla (multi select) *}
                              strTitulo: String = 'Configuração de Relatórios'): Boolean;
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
    arrTitCol: TColunasArray;                                 {* Títulos das Colunas                         *}

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
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   REL_NOMPRO, '; pAddNomeColuna('Nome do Programa');
      strSQL := strSQL + '   REL_DESPRO, '; pAddNomeColuna('Descrição');
      strSQL := strSQL + '   REL_NOMFIL, '; pAddNomeColuna('Nome da Fila');
      strSQL := strSQL + '   REL_IDEIMP, '; pAddNomeColuna('Tipo de Impressão');
      strSQL := strSQL + '   REL_PERGUN, '; pAddNomeColuna('Pergunta Tipo de Impressão');
      strSQL := strSQL + ' AUTOINCREM ';
      strSQL := strSQL + ' FROM CFGREL ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      if fConsulta([strSQL, strWhere],
                   arrTitCol,
                   ['REL_DESPRO','REL_NOMPRO'],
                   '',
                   'CFGREL',
                   Self.Name,
                   strTitulo,
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'REL_NOMPRO',
                   Nil) then
      begin
          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('REL_NOMPRO').AsString
            Else
              edtCodigo.Text := qryConsulta.FieldByName('REL_NOMPRO').AsString;
          End;

          If Assigned(edtDesPor) Then
            edtDesPor.Text := qryConsulta.FieldByName('REL_DESPRO').AsString;

          If (Length(arrSel) > 1) Then
          Begin

            If Assigned(edtCodigo) then
            Begin
              If (edtCodigo Is TMaskEditFocus) Then
                (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 8)
              Else
                edtCodigo.Text := fStrZero('0', 8);
            End;

            If Assigned(edtDesPor) Then
              edtDesPor.Text := '+1';

          End;

        Result := True;

        If Not Assigned(qryTabela) Then
          FreeAndNil(qryConsulta);
      end;
    except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    end;
  End;
end;

{************************************************************************}
{* FUNÇÃO CRIDA PARA CHAMADA DA NOVA CONSULTA DE COMISSÃO DE VENDEDORES *}
{*********************************************************************JU*}
function fPesqRecComissaoVen(opcTipCom: TTipoConsultaSimples;
                             Self     : TForm;                       {* Formulário                                  *}
                             edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                             edtDesRec: TEditFocus;                  {* Edit da Descrição do item                   *}
                             qryTabela: TUniQuery;                     {* Query                                       *}
                             Var chrKey: Char;                       {* Key                                         *}
                             Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                             blnConSim: Boolean = True;              {* Consulta Simples ou Múltipla (multi select) *}
                             strTitulo: String = 'Consulta Faixas de Recebimento para Comissão (Vendedor)'): Boolean;
  var
    strSQL     : String;
    strWhere   : String;
    strGroup   : String;
    qryConsulta: TUniQuery;
    objConsulta: TDefConsulta;
    arrTitCol: TColunasArray;                                 {* Títulos das Colunas                         *}
    blnRecEmp  : Boolean;

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
      objConsulta := TDefConsulta.Create;

      SetLength(arrTitCol, 0);
      blnRecEmp := fCfgSis('RECEMP', VarBoolean);
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + ' COM_CODTAB, '; pAddNomeColuna('Código');

      If blnRecEmp Then
      Begin
        strSQL := strSQL + ' COM_CODEMP, '; pAddNomeColuna('Empresa');
      End;

      strSQL := strSQL + ' COM_DESCRI, '; pAddNomeColuna('Descrição');
      strSQL := strSQL + ' TIPOPE, ';     pAddNomeColuna('Tipo Operador');
      strSQL := strSQL + ' DEP_DESCRI, '; pAddNomeColuna('Departamento');
      strSQL := strSQL + IfThen(blnRecEmp, 'RECCOM', 'COMREC') + '.AUTOINCREM ';
      strSQL := strSQL + 'FROM ';

      If blnRecEmp Then
        strSQL := strSQL + '  RECCOM '
      Else
        strSQL := strSQL + '  COMREC ';

      strSQL := strSQL + 'LEFT JOIN CADDEP ON (DEP_CODIGO = COM_CODDEP) ';

      strWhere := '';
      strWhere := strWhere + 'WHERE ';
      strWhere := strWhere + '  TRUE ';

      If blnRecEmp Then
        strWhere := strWhere + ' AND (LOCATE(COM_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0) ';

      objConsulta.pIncluiSubConsulta('TIPOPE', 'CASE WHEN (COM_TIPOPE = "T") THEN "DIGITADOR" ' +
                                               '     WHEN (COM_TIPOPE = "A") THEN "ADMINISTRATIVO" ' +
                                               '     WHEN (COM_TIPOPE = "C") THEN "COMPRAS" ' +
                                               '     WHEN (COM_TIPOPE = "m") THEN "MECÂNICO" ' +
                                               '     WHEN (COM_TIPOPE = "I") THEN "VENDEDOR INTERNO" ' +
                                               '     WHEN (COM_TIPOPE = "E") THEN "REPRESENTANTE EXTERNO LOJA" ' +
                                               '     WHEN (COM_TIPOPE = "D") THEN "REPRESENTANTE EXTERNO DISTRIBUIDOR" ' +
                                               '     WHEN (COM_TIPOPE = "S") THEN "SUB-GERENTE" ' +
                                               '     WHEN (COM_TIPOPE = "G") THEN "GERENTE" ' +
                                               '     ELSE "" END ');

      strGroup := '';
      strGroup := strGroup + ' GROUP BY COM_CODTAB ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL,strWhere,strGroup],
                   arrTitCol,
                   ['COM_DESCRI','COM_CODTAB'],
                   '',
                   IIF(blnRecEmp, 'RECCOM', 'COMREC'),
                   Self.Name,
                   strTitulo,
                   qryConsulta,
                   nil,
                   blnConSim,
                   arrSel,
                   'COM_CODTAB',
                   objConsulta) Then
      Begin
          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('COM_CODTAB').AsString
            Else
              edtCodigo.Text := qryConsulta.FieldByName('COM_CODTAB').AsString;
          End;

          If Assigned(edtDesRec) Then
            edtDesRec.Text := qryConsulta.FieldByName('COM_DESCRI').AsString;

          If (Length(arrSel) > 1) Then
          Begin

            If Assigned(edtCodigo) then
            Begin
              If (edtCodigo Is TMaskEditFocus) Then
                (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 8)
              Else
                edtCodigo.Text := fStrZero('0', 8);
            End;

            If Assigned(edtDesRec) Then
              edtDesRec.Text := '+1';

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

{**************************************************************************}
{* FUNÇÃO CRIDA PARA CHAMADA DA NOVA CONSULTA DE COMISSÃO DE PROFISSONAIS *}
{***********************************************************************JU*}
function fPesqComissaoProf(opcTipCom: TTipoConsultaSimples;
                           Self     : TForm;                       {* Formulário                                  *}
                           edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                           edtDesPro: TEditFocus;                  {* Edit da Descrição do item                   *}
                           qryTabela: TUniQuery;                     {* Query                                       *}
                           Var chrKey: Char;                       {* Key                                         *}
                           Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                           blnOpcInc: Boolean;                     {* Condição para o Where                       *}
                           strTCoPro: String;                      {* Tipo de Comissão Profissional               *}
                           blnConSim: Boolean = True;              {* Consulta Simples ou Múltipla (multi select) *}
                           strTitulo: String = 'Consulta Faixas de Recebimento para Comissão (Profissional)'): Boolean;
  var
    strSQL     : String;
    strWhere   : String;
    qryConsulta: TUniQuery;
    arrTitCol: TColunasArray;                                 {* Títulos das Colunas                         *}

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

      If fEmptyStr(strTCoPro) Then
        strTCoPro := fCfgSis('TCOPRO');

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  COM_CODCOM, '; pAddNomeColuna('Código');
      strSQL := strSQL + '  COM_DTACAD, '; pAddNomeColuna('Dta. Cadastro');
      strSQL := strSQL + '  COM_CREDEB, '; pAddNomeColuna('C/D');
      strSQL := strSQL + '  COM_NUMDOC, '; pAddNomeColuna('Documento');
      strSQL := strSQL + '  COM_ESPDOC, '; pAddNomeColuna('Espécie');
      strSQL := strSQL + '  COM_CODEMP, '; pAddNomeColuna('Empresa');
      strSQL := strSQL + '  COM_VRVEND, '; pAddNomeColuna('Vr. Venda');

      If strTCoPro = '3' Then
      begin
        strSQL := strSQL + ' COM_VRCOMI, '; pAddNomeColuna('Qtd. Pontos');
      end
      Else
      begin
        strSQL := strSQL + ' COM_VRCOMI, '; pAddNomeColuna('Vr. Comissão');
      end;

      strSQL := strSQL + ' CLI_NOMCLI, '; pAddNomeColuna('Nome Cliente');
      strSQL := strSQL + ' DIV_NOMDIV, '; pAddNomeColuna('Nome Profissional');
      strSQL := strSQL + ' COMPRO.AUTOINCREM ';
      strSQL := strSQL + ' FROM      ';
      strSQL := strSQL + ' COMPRO  ';
      strSQL := strSQL + ' LEFT JOIN CADCLI ON (CLI_CODCLI = COM_CODCLI) ';
      strSQL := strSQL + ' LEFT JOIN CADDIV ON (DIV_CODDIV = COM_CODPRO) ';

      strWhere := '';
      strWhere := strWhere + ' WHERE  ';

      If blnOpcInc Then
        strWhere := strWhere + ' COM_NUMDOC IS NOT NULL '
      ELSE
        strWhere := strWhere + ' TRUE ';

      strWhere := strWhere  + ' AND IF(IFNULL(COM_TCOPRO, "") = "", ' + QuotedStr(strTCoPro) +
                                                   ', COM_TCOPRO) = ' + QuotedStr(strTCoPro);

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL,strWhere],
                   arrTitCol,
                   ['COM_NUMDOC','DIV_NOMDIV','CLI_NOMCLI','COM_CODCOM'],
                   '',
                   'COMPRO',
                   Self.Name,
                   strTitulo,
                   qryConsulta,
                   nil,
                   blnConSim,
                   arrSel,
                   'COM_CODCOM',
                   nil) Then
      Begin
          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('COM_CODCOM').AsString
            Else
              edtCodigo.Text := qryConsulta.FieldByName('COM_CODCOM').AsString;
          End;

          If Assigned(edtDesPro) Then
            edtDesPro.Text := qryConsulta.FieldByName('COM_CODCOM').AsString;

          If (Length(arrSel) > 1) Then
          Begin

            If Assigned(edtCodigo) then
            Begin
              If (edtCodigo Is TMaskEditFocus) Then
                (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 8)
              Else
                edtCodigo.Text := fStrZero('0', 8);
            End;

            If Assigned(edtDesPro) Then
              edtDesPro.Text := '+1';

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



Function fSQLNotasEntrada(finalidadeXML: tpeFinalidadeXML; Var strWhere: String; blnOpcSQL: Boolean = False): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT         ';
  strSQL := strSQL + '  B08_NNF    , ';
  strSQL := strSQL + '  B07_SERIE  , ';
  strSQL := strSQL + '  B09_DEMI   , ';

  If blnOpcSQL Then
  Begin

   If fEhEstadoRegraZonaFranca(fCadEmp('ESTADO')) Then
     strSQL := strSQL + ' W07_VPROD - ' + fSQLDescontoNotaXML
   Else
     strSQL := strSQL + ' W07_VPROD - W10_VDESC ';

    strSQL := strSQL + ' AS TOTNOT, ';
  End Else
  Begin
    strSQL := strSQL + '  VPRODLIQ, ';
  End;

  If (finalidadeXML  in [xmlConsertoEquipamento, xmlGarantiaRecCliente]) Then
  Begin
    strSQL := strSQL + '  GER_CODCLI , ';
    strSQL := strSQL + '  CLI_NOMCLI , ';
  End Else Begin
    strSQL := strSQL + '  GER_CODFOR , ';
    strSQL := strSQL + '  FOR_NOMFOR , ';
  End;

  strSQL := strSQL + '  GERELE.AUTOINCREM, ';
  strSQL := strSQL + '  W08_VFRETE,        ';
  strSQL := strSQL + '  W15_VOUTRO,        ';
  strSQL := strSQL + '  W09_VSEG,          ';
  strSQL := strSQL + '  B09_DEMI,          ';
  strSQL := strSQL + '  PR07_CHNFE,        ';
  strSQL := strSQL + '  W09_VSEG,          ';
  strSQL := strSQL + '  W10_VDESC,         ';
  strSQL := strSQL + '  X27_QVOL,          ';
  strSQL := strSQL + '  W06A_VFCPST,          ';
  strSQL := strSQL + '  X28_ESP,           ';
  strSQL := strSQL + '  W04A_VICMSDESON,   ';
  strSQL := strSQL + fSQLDescontoNotaXML + ' AS DESCONTO, ';
  strSQL := strSQL + '  GER_CODCLI,        ';
  strSQL := strSQL + '  GER_TIP_FC,        ';
  strSQL := strSQL + '  GER_TIPXML,        ';
  strSQL := strSQL + '  GER_CONDIR,        ';
  strSQL := strSQL + '  GER_ENTDIR         ';

  strSQL := strSQL + 'FROM GERELE          ';

  If (finalidadeXML  in [xmlConsertoEquipamento, xmlGarantiaRecCliente]) Then
  Begin
    strSQL := strSQL + 'INNER JOIN CADCLI ON           ';
    strSQL := strSQL + '  CLI_CODCLI = GER_CODCLI      ';
  End
  Else
  Begin
     strSQL := strSQL + 'INNER JOIN CADFOR ON           ';
     strSQL := strSQL + '  FOR_CODFOR = GER_CODFOR      ';
  End;

  strWhere := '';
  strWhere := strWhere + 'WHERE                          ';
  strWhere := strWhere + '  GER_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' AND ';
  strWhere := strWhere + '  GER_DOCENT IS NULL ';

  If fCfgSis('USACON', varBoolean) And (Pos(fCfgSis('CONFME'), '1_3_') > 0) And (Not (finalidadeXML  in [xmlConsertoEquipamento, xmlGarantiaRecCliente])) Then
  Begin

    If not fConferenciaDepoisDaEntrada Then
      strWhere := strWhere + '  AND ((GER_DTALIB IS NOT NULL AND GER_DTACON IS NOT NULL) OR (GER_ENTDIR = "S")) '
    Else
      strWhere := strWhere + '  AND ((GER_DTALIB IS NOT NULL AND GER_DTACON IS NULL) OR (GER_ENTDIR = "S")) ';

  End;

  Result := strSQL;
End;

Procedure pCarregaCabecalhoNota(qryConsulta: TUniQuery; Var recNotEle: TRecInfoNotaEletronica);
Begin
  With recNotEle, qryConsulta Do
  Begin
    strEntDir := FieldByName('GER_ENTDIR').AsString;
    strConDir := FieldByName('GER_CONDIR').AsString;
    strAutInc := FieldByName('AUTOINCREM').AsString;
    strCodFor := FieldByName('GER_CODFOR').AsString;
    strCodCli := FieldByName('GER_CODCLI').AsString;
    strTip_FC := FieldByName('GER_TIP_FC').AsString;
    finalidadeXML := tpeFinalidadeXML(FieldByName('GER_TIPXML').AsInteger);
    strNumDoc := FieldByName('B08_NNF').AsString;
    strSerDoc := FieldByName('B07_SERIE').AsString;
    fltValFre := FieldByName('W08_VFRETE').AsFloat;
    fltValDes := FieldByName('DESCONTO').AsFloat;
    fltOutras := FieldByName('W15_VOUTRO').AsFloat;
    fltValSeg := FieldByName('W09_VSEG').AsFloat;

    fltQtdVol := FieldByName('X27_QVOL').AsFloat;
    strEspVol := FieldByName('X28_ESP').AsString;
    strModFre := FieldByName('X33_MODFRETE').AsString;

    dtaDtaDoc := FieldByName('B09_DEMI').AsDateTime;
    str_Chave := FieldByName('PR07_CHNFE').AsString;
  End;
End;


{********************************************************************************}
{* FUNÇÃO CRIDA PARA CHAMADA DA NOVA CONSULTA DE FAIXAS DE FATURAMENTO COMISSÃO *}
{*****************************************************************************JU*}
function fPesqComissaoFat(opcTipCom: TTipoConsultaSimples;
                         Self     : TForm;                       {* Formulário                                  *}
                         edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                         edtDescri: TEditFocus;                  {* Edit da Descrição do item                   *}
                         qryTabela: TUniQuery;                     {* Query                                       *}
                         Var chrKey: Char;                       {* Key                                         *}
                         Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                         blnConSim: Boolean = True;              {* Consulta Simples ou Múltipla (multi select) *}
                         strTitulo: String = 'Consulta Faixas de Faturamento para Comissão'): Boolean;
  var
    strSQL, strWhere, strGroup: String;
    qryConsulta: TUniQuery;
    arrTitCol: TColunasArray;                                 {* Títulos das Colunas                         *}

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
      strSQL := strSQL + ' COM_CODTAB, '; pAddNomeColuna('Código');
      strSQL := strSQL + ' COM_DESCRI, '; pAddNomeColuna('Descrição');
      strSQL := strSQL + ' AUTOINCREM ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  COMFAT ';

      strWhere := '';
      strWhere := strWhere + 'WHERE TRUE          ';

      strGroup := '';
      strGroup := strGroup + 'GROUP BY COM_CODTAB ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL,strWhere,strGroup],
                   arrTitCol,
                   ['COM_DESCRI','COM_CODTAB'],
                   '',
                   'COMFAT',
                   Self.Name,
                   strTitulo,
                   qryConsulta,
                   nil,
                   blnConSim,
                   arrSel,
                   'COM_CODTAB') Then
      Begin
          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('COM_CODTAB').AsString
            Else
              edtCodigo.Text := qryConsulta.FieldByName('COM_CODTAB').AsString;
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := qryConsulta.FieldByName('COM_DESCRI').AsString;

          If (Length(arrSel) > 1) Then
          Begin

            If Assigned(edtCodigo) then
            Begin
              If (edtCodigo Is TMaskEditFocus) Then
                (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 8)
              Else
                edtCodigo.Text := fStrZero('0', 8);
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

function fPesqComissaoFatVend(opcTipCom: TTipoConsultaSimples;
                              Self     : TForm;                       {* Formulário                                  *}
                              edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                              edtDescri: TEditFocus;                  {* Edit da Descrição do item                   *}
                              qryTabela: TUniQuery;                     {* Query                                       *}
                              Var chrKey: Char;                       {* Key                                         *}
                              Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                              blnConSim: Boolean = True;              {* Consulta Simples ou Múltipla (multi select) *}
                              strTitulo: String = 'Consulta Faixas de Faturamento para Comissão'): Boolean;
  var
    strSQL, strWhere, strGroup : String;
    qryConsulta: TUniQuery;
    arrTitCol: TColunasArray;                                 {* Títulos das Colunas                         *}

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
      strSQL := strSQL + ' COM_CODTAB, '; pAddNomeColuna('Código');
      strSQL := strSQL + ' COM_DESCRI, '; pAddNomeColuna('Descrição');
      strSQL := strSQL + ' AUTOINCREM ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  COMFAV ';

     strWhere := '';
      strWhere := strWhere + 'WHERE TRUE          ';

      strGroup := '';
      strGroup := strGroup + 'GROUP BY COM_CODTAB ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL,strWhere, strGroup],
                   arrTitCol,
                   ['COM_DESCRI','COM_CODTAB'],
                   '',
                   'COMFAV',
                   Self.Name,
                   strTitulo,
                   qryConsulta,
                   nil,
                   blnConSim,
                   arrSel,
                   'COM_CODTAB') Then
      Begin
          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('COM_CODTAB').AsString
            Else
              edtCodigo.Text := qryConsulta.FieldByName('COM_CODTAB').AsString;
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := qryConsulta.FieldByName('COM_DESCRI').AsString;

          If (Length(arrSel) > 1) Then
          Begin

            If Assigned(edtCodigo) then
            Begin
              If (edtCodigo Is TMaskEditFocus) Then
                (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 8)
              Else
                edtCodigo.Text := fStrZero('0', 8);
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

function fPesqConsumidores(Self      : TForm;                            {* Formulário                                  *}
                           edtCodCon : TDBEditFocus;                     {* Edit do Código                              *}
                           edtDesCon : TDBEditFocus;                     {* Edit da Descricao                           *}
                           edtCgcCpf : TEditFocus;                       {* Edit CgcCpf                                 *}
                           mskNumCgc : TMaskEditFocus;                   {* Edit NumCgc                                 *}
                           qryTabela : TUniQuery;                        {* Query                                       *}
                           Var chrKey: Char;                             {* Key                                         *}
                           Var arrSel: TConsultasArray;                  {* Array de Seleção                            *}
                           strCodCli : String  = '';                     {* Parametro Filtro Estado Consumidor          *}
                           blnConSim : Boolean = True;                   {* Consulta Simples ou Múltipla (multi select) *}
                           blnRetDoc : Boolean = False): Boolean;        {* Retorna CPF/CNPJ Para consulta Editor de Relatório*}
var
  strSQL, strWhere : String;
  qryConsulta : TUniQuery;
  objConsulta: TDefConsulta;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  CON_C_P_F_ , ';
      strSQL := strSQL + '  CON_NOMCON , ';
      strSQL := strSQL + '  CON_ENDERE , ';
      strSQL := strSQL + '  CID_NOMCID , ';
      strSQL := strSQL + '  CID_ESTADO , ';
      strSQL := strSQL + '  TIPPESSOA  , ';
      strSQL := strSQL + '  CLICON.AUTOINCREM AS "AUTOINCREM" ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CLICON, ';
      strSQL := strSQL + '  CADCID ';

      strWhere := '';
      strWhere := strWhere + 'WHERE ';
      strWhere := strWhere + '  CON_CODCID = CID_CODCID ';

      if strCodCli <> EmptyStr then
        strWhere := strWhere + ' AND CID_ESTADO = "' + fRetUFCliente(strCodCli) + '" ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      objConsulta := TDefConsulta.Create;
      objConsulta.pIncluiSubConsulta('TIPPESSOA', 'IF(CON_CGCCPF = 1,"J","F")');

      If fConsulta([strSQL, strWhere],
                  ['Cpf / Cnpj',
                   'Nome do Consumidor',
                   'Endereço',
                   'Cidade',
                   'Estado',
                   'Código do Consumidor',
                   'Tipo',
                   'AUTOINCREM'],
                   ['CON_NOMCON','CON_C_P_F_','CID_NOMCID','CID_ESTADO'],
                   '',
                   'CLICON',
                   Self.Name,
                   'Consulta de Consumidores',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   IIF(blnRetDoc, 'CON_C_P_F_','CON_NOMCON'),
                   objConsulta) Then
      Begin
{       If Assigned(edtCodCon) then
        Begin
          If (edtCodCon Is TDBEditFocus) Then
            (edtCodCon As TDBEditFocus).Text := qryConsulta.FieldByName('CON_CODCON').AsString
          Else
            edtCodCon.Text := qryConsulta.FieldByName('CON_CODCON').AsString;
        End;
}
        If Assigned(edtDesCon) Then
          edtDesCon.Text := qryConsulta.FieldByName('CON_NOMCON').AsString;

        If Assigned(edtCgcCpf) Then
          edtCgcCpf.Text := qryConsulta.FieldByName('CON_CGCCPF').AsString;

        If Assigned(mskNumCgc) Then
          mskNumCgc.Text := qryConsulta.FieldByName('CON_C_P_F_').AsString;


        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodCon) then
          Begin
            If (edtCodCon Is TDBEditFocus) Then
              (edtCodCon As TDBEditFocus).Text := fStrZero('0', 3)
            Else
              edtCodCon.Text := fStrZero('0', 3);
          End;

          If Assigned(edtDesCon) Then
            edtDesCon.Text := '+1';

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

function fPesqComissaoFatVendDepart(opcTipCom: TTipoConsultaSimples;
                                    Self     : TForm;                       {* Formulário                                  *}
                                    edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                                    edtDescri: TEditFocus;                  {* Edit da Descrição do item                   *}
                                    qryTabela: TUniQuery;                     {* Query                                       *}
                                    Var chrKey: Char;                       {* Key                                         *}
                                    Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                                    blnConSim: Boolean = True;              {* Consulta Simples ou Múltipla (multi select) *}
                                    strTitulo: String = 'Consulta Faixa de Faturamento Geral do Vendedor X Departamento'): Boolean;
  var
    strSQL, strWhere : String;
    qryConsulta: TUniQuery;
    objConsulta: TDefConsulta;
    arrTitCol: TColunasArray;                                 {* Títulos das Colunas                         *}

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

      objConsulta := TDefConsulta.Create;

      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + ' COM_CODTAB, '; pAddNomeColuna('Código');
      strSQL := strSQL + ' COM_DESCRI, '; pAddNomeColuna('Descrição');
      strSQL := strSQL + ' COM_FATINI, '; pAddNomeColuna('Faturamento Inicial');
      objConsulta.pFormataDecimal('COM_FATINI', 3);
      strSQL := strSQL + ' COM_FATFIN, '; pAddNomeColuna('Faturamento Final');
      objConsulta.pFormataDecimal('COM_FATFIN', 3);
      strSQL := strSQL + ' AUTOINCREM ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  COMDEPG ';

      strWhere := strWhere + 'WHERE ';
      strWhere := strWhere + '  TRUE ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL,strWhere],
                   arrTitCol,
                   ['COM_DESCRI','COM_CODTAB'],
                   '',
                   'COMDEPG',
                   Self.Name,
                   strTitulo,
                   qryConsulta,
                   nil,
                   blnConSim,
                   arrSel,
                   'COM_CODTAB',
                   objConsulta) Then
      Begin
          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('COM_CODTAB').AsString
            Else
              edtCodigo.Text := qryConsulta.FieldByName('COM_CODTAB').AsString;
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := qryConsulta.FieldByName('COM_DESCRI').AsString;

          If (Length(arrSel) > 1) Then
          Begin

            If Assigned(edtCodigo) then
            Begin
              If (edtCodigo Is TMaskEditFocus) Then
                (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 8)
              Else
                edtCodigo.Text := fStrZero('0', 8);
            End;

            If Assigned(edtDescri) Then
              edtDescri.Text := '+1';

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

function fPesqComissaoFatDepart(opcTipCom: TTipoConsultaSimples;
                                    Self     : TForm;                       {* Formulário                                  *}
                                    edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                                    edtDescri: TEditFocus;                  {* Edit da Descrição do item                   *}
                                    qryTabela: TUniQuery;                     {* Query                                       *}
                                    Var chrKey: Char;                       {* Key                                         *}
                                    Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                                    blnConSim: Boolean = True;              {* Consulta Simples ou Múltipla (multi select) *}
                                    strTitulo: String = 'Consulta Faixa de Desconto por Departamento'): Boolean;
  var
    strSQL, strWhere : String;
    qryConsulta: TUniQuery;
    objConsulta: TDefConsulta;
    arrTitCol: TColunasArray;                                 {* Títulos das Colunas                         *}

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

      objConsulta := TDefConsulta.Create;

      chrKey := #0;

      strSQL   := '';
      strSQL   := strSQL   + 'SELECT       ';
      strSQL   := strSQL   + ' COM_CODTAB, ';                          pAddNomeColuna('Código');
      strSQL   := strSQL   + ' COM_DESCRI, ';                          pAddNomeColuna('Descrição');
      strSQL   := strSQL   + ' DEPARTAMENTO, ';                        pAddNomeColuna('Departamento');
      strSQL   := strSQL   + ' COMDPG.AUTOINCREM  ';
      strSQL   := strSQL   + 'FROM     ';
      strSQL   := strSQL   + '  COMDPG ';
      strSQL   := strSQL   + '  INNER JOIN CADDEP ON DEP_CODIGO = COM_CODDEP ';
      strWhere := strWhere + 'WHERE    ';
      strWhere := strWhere + '  TRUE   ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      objConsulta.pIncluiSubConsulta('DEPARTAMENTO', 'CONCAT(COM_CODDEP, "-", DEP_DESCRI)');

      If fConsulta([strSQL,strWhere],
                   arrTitCol,
                   ['COM_DESCRI','DEPARTAMENTO','COM_CODTAB'],
                   '',
                   'COMDPG',
                   Self.Name,
                   strTitulo,
                   qryConsulta,
                   nil,
                   blnConSim,
                   arrSel,
                   'COM_CODTAB',
                   objConsulta) Then
      Begin
          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('COM_CODTAB').AsString
            Else
              edtCodigo.Text := qryConsulta.FieldByName('COM_CODTAB').AsString;
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := qryConsulta.FieldByName('COM_DESCRI').AsString;

          If (Length(arrSel) > 1) Then
          Begin

            If Assigned(edtCodigo) then
            Begin
              If (edtCodigo Is TMaskEditFocus) Then
                (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 8)
              Else
                edtCodigo.Text := fStrZero('0', 8);
            End;

            If Assigned(edtDescri) Then
              edtDescri.Text := '+1';

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

{********************************************************************}
{* FUNÇÃO CRIDA PARA CHAMADA DA NOVA CONSULTA DE ORDENS DE PRODUÇÃO *}
{*****************************************************************JU*}
function fPesqOrdemProd(opcTipCom: TTipoConsultaSimples;
                        Self     : TForm;                       {* Formulário                                  *}
                        edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                        edtDescri: TEditFocus;                  {* Edit da Descrição do item                   *}
                        qryTabela: TUniQuery;                     {* Query                                       *}
                        Var chrKey: Char;                       {* Key                                         *}
                        Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                        strWhere : String = '';
                        blnConSim: Boolean = True;              {* Consulta Simples ou Múltipla (multi select) *}
                        strTitulo: String = 'Consulta Ordens de Produção';
                        intOpcStatus : integer = 3): Boolean;
  var
    strSQL : String;
    qryConsulta: TUniQuery;
    arrTitCol: TColunasArray;                                 {* Títulos das Colunas                         *}

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
      if Not fEmptyStr(strWhere) then
        strWhere := strWhere + ' AND PRO_CODEMP = ' + QuotedStr(vs_StrCodEmp) + ' '
      Else
        strWhere := ' WHERE PRO_CODEMP = ' + QuotedStr(vs_StrCodEmp) + ' ';

      case intOpcStatus of
        1 : strWhere := strWhere + ' AND PRO_DTABAI IS NULL ';
        2 : strWhere := strWhere + ' AND PRO_DTABAI IS NOT NULL ';
      end;

      SetLength(arrTitCol, 0);

      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  PRO_CODPRO, '; pAddNomeColuna('Ord Pro');
      strSQL := strSQL + '  PRO_DTACAD, '; pAddNomeColuna('Data de Cadastro');
      if fCfgSis('SEQORD', varBoolean) then
      begin
        strSQL := strSQL + '  PRO_SEQUEN, ';
        pAddNomeColuna('Seq.');
      end;
      strSQL := strSQL + '  PRO_CODITE, '; pAddNomeColuna('Cód.Produto');
      strSQL := strSQL + '  ITE_DESITE, '; pAddNomeColuna('Produto');
      strSQL := strSQL + '  PRO_QTDAPR, '; pAddNomeColuna('Quantidade');
      strSQL := strSQL + '  PRO_DTAPRO, '; pAddNomeColuna('Data da Produção');
      strSQL := strSQL + '  PRO_DTABAI, '; pAddNomeColuna('Data da Baixa');
      strSQL := strSQL + '  PRO_HORBAI, '; pAddNomeColuna('Hora da Baixa');
      strSQL := strSQL + '  PRO_QTDPRO, '; pAddNomeColuna('Qtd. Produzido');
      strSQL := strSQL + '  FGO_NUMDOC, '; pAddNomeColuna('Num. Pedido');
      strSQL := strSQL + '  FGO_ESPDOC, '; pAddNomeColuna('Esp.');
      strSQL := strSQL + '  FGO_CODEMP, '; pAddNomeColuna('Emp.');
      strSQL := strSQL + '  CLI_CODCLI, '; pAddNomeColuna('Cod. Cliente');
      strSQL := strSQL + '  CLI_NOMCLI, '; pAddNomeColuna('Nome Cliente');
      strSQL := strSQL + '  PRO_OBS001, '; pAddNomeColuna('Observação 1');
      strSQL := strSQL + '  PRO_OBS002, '; pAddNomeColuna('Observação 2');
      strSQL := strSQL + '  MOVPRO.AUTOINCREM ';
      strSQL := strSQL + 'FROM      ';
      strSQL := strSQL + '  MOVPRO                 ';
      strSQL := strSQL + '  JOIN CADITE ON ITE_CODITE = PRO_CODITE ';
      strSQL := strSQL + '  LEFT JOIN FATGOR ON (FATGOR.FGO_NUMDOC = PRO_NUMPED AND FATGOR.FGO_ESPDOC = PRO_ESPPED AND FATGOR.FGO_CODEMP = PRO_EMPPED)';
      strSQL := strSQL + '  LEFT JOIN CADCLI ON CLI_CODCLI = FGO_CODCLI ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL,strWhere],
                   arrTitCol,
                   ['PRO_CODPRO','ITE_DESITE','PRO_CODITE'],
                   'AUTOINCREM',
                   'MOVPRO',
                   Self.Name,
                   strTitulo,
                   qryConsulta,
                   nil,
                   blnConSim,
                   arrSel,
                   'AUTOINCREM',
                   nil) Then
      Begin
          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('PRO_CODPRO').AsString
            Else
              edtCodigo.Text := qryConsulta.FieldByName('PRO_CODPRO').AsString;
          End;

          If (Length(arrSel) > 1) Then
          Begin

            If Assigned(edtCodigo) then
            Begin
              If (edtCodigo Is TMaskEditFocus) Then
                (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 8)
              Else
                edtCodigo.Text := fStrZero('0', 8);
            End;
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

function fPesqPromocoes(Self      : TForm;                            {* Formulário                                  *}
                        edtCodPro : TEditFocus;                       {* Edit do Código                              *}
                        edtDesPro : TEditFocus;                       {* Edit da Descricao                           *}
                        qryTabela : TUniQuery;                          {* Query                                       *}
                        Var chrKey: Char;                             {* Key                                         *}
                        Var arrSel: TConsultasArray;                  {* Array de Seleção                            *}
                        blnConSim : Boolean = True): Boolean;         {* Consulta Simples ou Múltipla (multi select) *}
var
  strSQL, strWhere : String;
  qryConsulta: TUniQuery;
  objConsulta: TDefConsulta;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  EMPRESA, ';
      strSQL := strSQL + '  PRO_CODPRO , ';
      strSQL := strSQL + '  PRO_DESPRO , ';
      strSQL := strSQL + '  PRO_DTAINI , ';
      strSQL := strSQL + '  PRO_DTAFIN , ';
      strSQL := strSQL + '  ENTFUT , ';
      strSQL := strSQL + '  PREDES , ';
      strSQL := strSQL + '  AUTOINCREM ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADPRO ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      objConsulta := TDefConsulta.Create;
      objConsulta.pIncluiSubConsulta('EMPRESA', '(SELECT GROUP_CONCAT(PE.PRO_CODEMP) FROM PROEMP PE WHERE PE.PRO_SEQGER = CADPRO.AUTOINCREM)');
      objConsulta.pIncluiSubConsulta('ENTFUT', 'IF(PRO_ENTFUT = "S", "SIM", "NÃO")');
      objConsulta.pIncluiSubConsulta('PREDES', 'IF(PRO_PREDES = "P", "PREÇO", "DESCONTO")');
      objConsulta.pIncluiCampoSimNao('ENTFUT');
      objConsulta.pIncluiCampoSimNao('PREDES', ['PREÇO', 'DESCONTO', 'TODOS']);

      If fConsulta([strSQL, strWhere],
                  ['Empresa',
                   'Código',
                   'Descrição',
                   'Data Inicial',
                   'Data Final',
                   'Permite Entrega Futura?',
                   'Promoção por',
                   'AUTOINCREM'],
                   ['PRO_DESPRO','PRO_CODPRO','PRO_DTAINI'],

                   '',
                   'CADPRO',
                   Self.Name,
                   'Consulta de Promoções',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'PRO_CODPRO',
                   objConsulta) Then
      Begin
        If Assigned(edtCodPro) then
        Begin
          If (edtCodPro Is TEditFocus) Then
            (edtCodPro As TEditFocus).Text := qryConsulta.FieldByName('PRO_CODPRO').AsString
          Else
            edtCodPro.Text := qryConsulta.FieldByName('PRO_CODPRO').AsString;
        End;

        If Assigned(edtDesPro) Then
          edtDesPro.Text := qryConsulta.FieldByName('PRO_DESPRO').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodPro) then
          Begin
            If (edtCodPro Is TEditFocus) Then
              (edtCodPro As TEditFocus).Text := fStrZero('0', Length(qryConsulta.FieldByName('PRO_CODPRO').AsString))
            Else
              edtCodPro.Text := fStrZero('0', Length(qryConsulta.FieldByName('PRO_CODPRO').AsString));
          End;

          If Assigned(edtDesPro) Then
            edtDesPro.Text := '+1';

        End;

        Result := True;
      End;

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);

      FreeAndNil(objConsulta);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;

end;

function fPesqNegociacao(Self      : TForm;                            {* Formulário                                  *}
                         edtCodNeg : TEditFocus;                       {* Edit do Código                              *}
                         edtDesNeg : TEditFocus;                       {* Edit da Descricao                           *}
                         qryTabela : TUniQuery;                          {* Query                                       *}
                         Var chrKey: Char;                             {* Key                                         *}
                         Var arrSel: TConsultasArray;                  {* Array de Seleção                            *}
                         blnConSim : Boolean = True): Boolean;         {* Consulta Simples ou Múltipla (multi select) *}
var
  strSQL, strWhere : String;
  qryConsulta: TUniQuery;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  NEG_CODNEG , ';
      strSQL := strSQL + '  NEG_DESCRI , ';
      strSQL := strSQL + '  AUTOINCREM ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADNEG ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL, strWhere],
                  ['Código',
                   'Descrição',
                   'AUTOINCREM'],
                   ['NEG_CODNEG','NEG_DESCRI'],
                   '',
                   'CADNEG',
                   Self.Name,
                   'Consulta de Negociação de Clientes',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'NEG_CODNEG',
                   Nil) Then
      Begin
        If Assigned(edtCodNeg) then
        Begin
          If (edtCodNeg Is TEditFocus) Then
            (edtCodNeg As TEditFocus).Text := qryConsulta.FieldByName('NEG_CODNEG').AsString
          Else
            edtCodNeg.Text := qryConsulta.FieldByName('NEG_CODNEG').AsString;
        End;

        If Assigned(edtDesNeg) Then
          edtDesNeg.Text := qryConsulta.FieldByName('NEG_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin
          If Assigned(edtCodNeg) then
          Begin
            If (edtCodNeg Is TEditFocus) Then
              (edtCodNeg As TEditFocus).Text := fStrZero('0', Length(qryConsulta.FieldByName('NEG_CODNEG').AsString))
            Else
              edtCodNeg.Text := fStrZero('0', Length(qryConsulta.FieldByName('NEG_CODNEG').AsString));
          End;

          If Assigned(edtDesNeg) Then
            edtDesNeg.Text := '+1';
        End;

        Result := True;
      End;

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;
  End;
end;

function fPesqPromocoesBrindes(Self      : TForm;                            {* Formulário                                  *}
                               edtCodPro : TEditFocus;                       {* Edit do Código                              *}
                               edtDesPro : TEditFocus;                       {* Edit da Descricao                           *}
                               qryTabela : TUniQuery;                        {* Query                                       *}
                               Var chrKey: Char;                             {* Key                                         *}
                               Var arrSel: TConsultasArray;                  {* Array de Seleção                            *}
                               blnConSim : Boolean = True): Boolean;         {* Consulta Simples ou Múltipla (multi select) *}
var
  strSQL, strWhere : String;
  qryConsulta: TUniQuery;
  objConsulta: TDefConsulta;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  PRO_CODPRO , ';
      strSQL := strSQL + '  PRO_DESPRO , ';
      strSQL := strSQL + '  PRO_DTAINI , ';
      strSQL := strSQL + '  PRO_DTAFIN , ';
      strSQL := strSQL + '  EMPRESA,     ';
      strSQL := strSQL + '  AUTOINCREM   ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  PROBRI_GER  ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      objConsulta := TDefConsulta.Create;
      objConsulta.pIncluiSubConsulta('EMPRESA', '(SELECT GROUP_CONCAT(PRO_CODEMP) FROM PROBRI_EMP WHERE PRO_SEQGER = AUTOINCREM)');

      If fConsulta([strSQL, strWhere],
                  ['Código',
                   'Descrição',
                   'Data Inicial',
                   'Data Final',
                   'Empresa',
                   'AUTOINCREM'],
                   ['PRO_DESPRO','PRO_CODPRO','PRO_DTAINI'],
                   '',
                   'PROBRI_GER',
                   Self.Name,
                   'Consulta de Promoção de Brindes por Produtos Vendidos',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'PRO_CODPRO',
                   objConsulta) Then
      Begin
        If Assigned(edtCodPro) then
        Begin
          If (edtCodPro Is TEditFocus) Then
            (edtCodPro As TEditFocus).Text := qryConsulta.FieldByName('PRO_CODPRO').AsString
          Else
            edtCodPro.Text := qryConsulta.FieldByName('PRO_CODPRO').AsString;
        End;

        If Assigned(edtDesPro) Then
          edtDesPro.Text := qryConsulta.FieldByName('PRO_DESPRO').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodPro) then
          Begin
            If (edtCodPro Is TEditFocus) Then
              (edtCodPro As TEditFocus).Text := fStrZero('0', Length(qryConsulta.FieldByName('PRO_CODPRO').AsString))
            Else
              edtCodPro.Text := fStrZero('0', Length(qryConsulta.FieldByName('PRO_CODPRO').AsString));
          End;

          If Assigned(edtDesPro) Then
            edtDesPro.Text := '+1';

        End;

        Result := True;
      End;

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);

      FreeAndNil(objConsulta);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;

end;

function fPesqPedidoCompraNFImport(Self      : TForm;                            {* Formulário                                  *}
                                   edtNumPed : TEditFocus;                       {* Edit do Código                              *}
                                   edtNumCtn : TEditFocus;                       {* Edit da Descricao                           *}
                                   qryTabela : TUniQuery;                          {* Query                                       *}
                                   Var chrKey: Char;                             {* Key                                         *}
                                   Var arrSel: TConsultasArray;                  {* Array de Seleção                            *}
                                   objFrmPnl : TPanelCx = Nil;                   {* Painel                                      *}
                                   blnConSim : Boolean = True): Boolean;         {* Consulta Simples ou Múltipla (multi select) *}
var
  strSQL, strWhere : String;
  qryConsulta : TUniQuery;

begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  PCG_NUMPED , ';
      strSQL := strSQL + '  PCG_NUMCTN , ';
      strSQL := strSQL + '  FOR_CODFOR , ';
      strSQL := strSQL + '  FOR_NOMFOR , ';
      strSQL := strSQL + '  PCG_DTAPED , ';
      strSQL := strSQL + '  PCG_CONPAG , ';
      strSQL := strSQL + '  PCMGER.AUTOINCREM ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  PCMGER, ';
      strSQL := strSQL + '  CADFOR ';

      strWhere := '';
      strWhere := strWhere + 'WHERE    ';
      strWhere := strWhere + '  TRUE   ';

      If fCfgSis('LIBPCM', varBoolean) Then
        strWhere := strWhere + '  AND PCG_PEDLIB IS NOT NULL ';

      //strSQL := strSQL + '  PCG_NUMCTN > 0 AND ';
      strWhere := strWhere + '  AND PCG_PEDIMP = "S"  ';
      strWhere := strWhere + '  AND (PCG_JAEMIT = 0 OR PCG_JAEMIT IS NULL) ';
      strWhere := strWhere + '  AND PCG_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';
      strWhere := strWhere + '  AND PCG_CODFOR = FOR_CODFOR ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL, strWhere],
                  ['Pedido',
                   'Container',
                   'Cód.Forne.',
                   'Fornecedor',
                   'Data Pedido',
                   'Cond. Pgto.',
                   'AUTOINCREM'],
                   ['PCG_NUMPED','FOR_NOMFOR','FOR_CODFOR'],
                   '',
                   'PCMGER',
                   Self.Name,
                   'Consulta Pedido',
                   qryConsulta,
                   objFrmPnl,
                   blnConSim,
                   arrSel,
                   'AUTOINCREM',
                   Nil,
                   False,
                   False,
                   '',
                   Nil,
                   True,
                   True,
                   True,
                   Nil,
                   Nil,
                   Nil,
                   VS_Application) Then
      Begin
        If Assigned(edtNumPed) then
        Begin
          If (edtNumPed Is TEditFocus) Then
            (edtNumPed As TEditFocus).Text := qryConsulta.FieldByName('PCG_NUMPED').AsString
          Else
            edtNumPed.Text := qryConsulta.FieldByName('PCG_NUMPED').AsString;
        End;

        If Assigned(edtNumCtn) Then
          edtNumCtn.Text := qryConsulta.FieldByName('PCG_NUMCTN').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtNumPed) then
          Begin
            If (edtNumPed Is TEditFocus) Then
              (edtNumPed As TEditFocus).Text := fStrZero('0', 3)
            Else
              edtNumPed.Text := fStrZero('0', 3);
          End;

          If Assigned(edtNumCtn) Then
            edtNumCtn.Text := '+1';

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
  end;
end;

function fPesqPedidoCompraCancelPedido(Self      : TForm;                            {* Formulário                                  *}
                                       edtNumPed : TEditFocus;                       {* Edit do Código                              *}
                                       rdgOpcoes : TRadioGroup;                      {* Radio group tipo Pedido                     *}
                                       edtCodEmp : TEditFocus;                       {* Edit da Empresa                             *}
                                       qryTabela : TUniQuery;                          {* Query                                       *}
                                       Var chrKey: Char;                             {* Key                                         *}
                                       Var arrSel: TConsultasArray;                  {* Array de Seleção                            *}
                                       blnConSim : Boolean = True): Boolean;         {* Consulta Simples ou Múltipla (multi select) *}
var
  strSQL, strWhere : String;
  qryConsulta : TUniQuery;

begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  PCG_NUMPED, ';
      strSQL := strSQL + '  PCG_ESPDOC, ';
      strSQL := strSQL + '  PCG_CODEMP, ';
      strSQL := strSQL + '  PCG_CODFOR, ';
      strSQL := strSQL + '  FOR_NOMFOR, ';
      strSQL := strSQL + '  PCG_DTAPED, ';
      strSQL := strSQL + '  PCG_CONPAG, ';
      strSQL := strSQL + '  PCG_TOTITE, ';
      strSQL := strSQL + '  PCG_TOTIPI, ';
      strSQL := strSQL + '  PCG_TOTGER, ';
      strSQL := strSQL + '  PCMGER.AUTOINCREM AS "AUTOINCREM" ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  PCMGER, ';
      strSQL := strSQL + '  CADFOR ';

      strWhere := '';
      strWhere := strWhere + 'WHERE ';

      If rdgOpcoes.ItemIndex = 0 Then
        strWhere := strWhere + '  PCG_ESPDOC = "PD" '
      Else
        strWhere := strWhere + '  PCG_ESPDOC = "OR" ';

      strWhere := strWhere + '  AND FOR_CODFOR = PCG_CODFOR ';
      strWhere := strWhere + '  AND PCG_NUMCTN = 0 ';
      strWhere := strWhere + '  AND (PCG_BAIXAD <> 1 OR PCG_BAIXAD IS NULL) ';
      strWhere := strWhere + '  AND PCG_CODEMP = ' + QuotedStr(edtCodEmp.Text)+ ' ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL, strWhere],
                  ['Pedido',
                   'Espécie',
                   'Empresa',
                   'Cód. Forn.',
                   'Fornecedor',
                   'Dta. Ped.',
                   'Cond. Pagto.',
                   'Total Itens',
                   'Total IPI',
                   'Total Pedido'],
                   ['PCG_NUMPED','PCG_DTAPED','FOR_NOMFOR','PCG_CODFOR'],

                   '',
                   'PCMGER',
                   Self.Name,
                   'Consulta Pedido para cancelar',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'PCG_NUMPED') Then
      Begin
        If Assigned(edtNumPed) then
        Begin
          If (edtNumPed Is TEditFocus) Then
            (edtNumPed As TEditFocus).Text := qryConsulta.FieldByName('PCG_NUMPED').AsString
          Else
            edtNumPed.Text := qryConsulta.FieldByName('PCG_NUMPED').AsString;
        End;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtNumPed) then
          Begin
            If (edtNumPed Is TEditFocus) Then
              (edtNumPed As TEditFocus).Text := fStrZero('0', 3)
            Else
              edtNumPed.Text := fStrZero('0', 3);
          End;

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
  end;

end;

function fPesqLoteItens(Self       : TForm;                            {* Formulário                                  *}
                        edtNumLote : TCustomEdit;                      {* Edit do Número do Lote                      *}
                        edtCodIte  : TCustomEdit;                      {* Edit do Código do Item                      *}
                        intDecUni  : Integer;                          {* Casas decimais                              *}
                        qryTabela  : TUniQuery;                        {* Query                                       *}
                        Var chrKey : Char;                             {* Key                                         *}
                        Var arrSel : TConsultasArray;                  {* Array de Seleção                            *}
                        blnConSim  : Boolean = True;                   {* Consulta Simples ou Múltipla (multi select) *}
                        strCodIte  : String = '';
                        strCodEmp  : String = '';
                        blnSoAtivos: Boolean = False;
                        blnRetNumLot: Boolean = False): Boolean;
  var
    strSQL, strWhere : String;
    qryConsulta  : TUniQuery;
    blnSomaEntFut,
    blnArmazem   : Boolean;
    strName      : String;
    intCont      : Integer;
    arrTitCol    : TColunasArray;
    objConsulta  : TDefConsulta;

  Procedure pAddNomeColuna(strTitCol: String);
  Begin
    SetLength(arrTitCol, Succ(Length(arrTitCol)));
    arrTitCol[High(arrTitCol)] := strTitCol;
  End;

begin
  If fEmptyStr(strCodEmp) Then
    strCodEmp := VS_strCodEmp;

  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      blnArmazem := (fCfgSis('CTLEST') = '2');
      objConsulta := TDefConsulta.Create;

      blnSomaEntFut := fUsaQtdPendenteEntregaFutura;

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  LOT_NUMLOT , '; pAddNomeColuna(VS_strTitLot);

      If blnArmazem Then
      Begin
        strSQL := strSQL + '  AMZ_DESCRI, '; pAddNomeColuna('Descrição do Armazém');
      End;

      strSQL := strSQL + '  LOT_LOCFIS , '; pAddNomeColuna('Loc. Física');

      If fCfgSis('CADLOC', VarBoolean) Then
      Begin
        strSQL := strSQL + '   LOC_DESCRI , '; pAddNomeColuna('Descrição Loc. Física');
      End;

      strSQL := strSQL + '  LOT_CODITE , '; pAddNomeColuna('Cód.Item');
      strSQL := strSQL + '  ITE_DESITE , '; pAddNomeColuna('Descrição do Item');
      strSQL := strSQL + '  ITE_REFERE , '; pAddNomeColuna('Referência do Item');
      strSQL := strSQL + '  UNI_SIGUNI , '; pAddNomeColuna('Unidade');

      strSQL := strSQL + '  LOT_DTAFAB , '; pAddNomeColuna('Fabricação');
      strSQL := strSQL + '  LOT_DTAVAL , '; pAddNomeColuna('Validade');
      strSQL := strSQL + '  LOT_SALBAL , '; pAddNomeColuna('Saldo Balanço');
      strSQL := strSQL + '  LOT_SALDOS , '; pAddNomeColuna('Saldo Atual');

      If (not blnSomaEntFut) Then
        objConsulta.pIncluiSubConsulta('LOT_SALDOS', 'ROUND(LOT_SALDOS, 3)')
      Else
        objConsulta.pIncluiSubConsulta('LOT_SALDOS', 'ROUND( LOT_SALDOS + IFNULL(QTDPEN, 0), 3)');

      If fUsaRotinaWMS Then
      Begin
        strSQL := strSQL + '  LOT_ML_BAL , '; pAddNomeColuna('Saldo Balanço (ML/GR)');
        strSQL := strSQL + '  LOT_SAL_ML , '; pAddNomeColuna('Saldo Atual (ML/GR)');
      End;

      strSQL := strSQL + '  LOT_PRECUS , '; pAddNomeColuna('Preço de Custo');

      for intCont := 1 to Length(VS_strTabVen) do
      begin
        if (VS_strTabVen[intCont] = 'S') then
          strSQL := strSQL + '  LOT_PREVE' + IntToStr(intCont) + ' , '; pAddNomeColuna('Preço de Venda - ' + IntToStr(intCont));
      end;

      strSQL := strSQL + '  LOT_BROKER , '; pAddNomeColuna('Lote Broker');
      objConsulta.pIncluiSubConsulta('STATUS', 'IF(LOT_STATUS = "S", "ATIVO", "INATIVO") ');
      objConsulta.pIncluiCampoSimNao('STATUS', ['ATIVO', 'INATIVO', 'TODOS']);
      strSQL := strSQL + '  STATUS, '; pAddNomeColuna('Status');
      strSQL := strSQL + '  L.AUTOINCREM ';
      strSQL := strSQL + 'FROM      ';
      strSQL := strSQL + '  CADLOT L ';
      strSQL := strSQL + 'INNER JOIN CADITE ON ITE_CODITE = LOT_CODITE ';
      strSQL := strSQL + 'LEFT  JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';

      If blnArmazem Then
        strSQL := strSQL + 'INNER JOIN CADAMZ ON AMZ_CODAMZ = LOT_NUMLOT AND AMZ_CODEMP = LOT_CODEMP ';

      If fCfgSis('CADLOC', VarBoolean) Then
        strSQL := strSQL + ' LEFT JOIN CADLOC ON LOC_CODLOC = LOT_LOCFIS AND LOC_CODEMP = LOT_CODEMP ';

      If blnSomaEntFut Then
      Begin
        fCriaMemoryTableEntregaFutura(VS_MemoryTableEntFut, strCodEmp, '', '', False, False, True, '', True);
        strSQL := strSQL + 'LEFT JOIN ' + VS_MemoryTableEntFut + ' AS DETFUT ';
        strSQL := strSQL + '     ON DETFUT.DET_CODITE = LOT_CODITE ';
        strSQL := strSQL + '    AND DETFUT.DET_NUMLOT = LOT_NUMLOT ';
      End;

      strWhere := '';

      strWhere := strWhere + 'WHERE     ';

      strWhere := strWhere + '  LOT_CODEMP = ' + QuotedStr(strCodEmp);

      If blnSoAtivos Then
        strWhere := strWhere + ' AND LOT_STATUS = "S" ';

      If Not fEmptyStr(strCodIte) Then
        strWhere := strWhere + ' AND LOT_CODITE = ' + QuotedStr(strCodIte)
      Else
        If Assigned(edtCodIte) And (Not fEmptyStr(edtCodIte.Text)) Then
          strWhere := strWhere + ' AND LOT_CODITE = ' + QuotedStr(edtCodIte.Text);

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      strName := 'fPesqLoteItens';
      If Assigned(Self) Then
        strName := Self.Name;

      If fConsulta([strSQL, strWhere],
                   arrTitCol,
                   ['LOT_NUMLOT','LOT_LOCFIS','ITE_DESITE','LOT_CODITE'],
                   '',
                   'CADLOT',
                   strName,
                   'Consulta de ' + VS_strTitLts + ' dos Itens',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   IIF(blnRetNumLot, 'LOT_NUMLOT','AUTOINCREM'),
                   objConsulta) Then
      Begin
        If Assigned(edtNumLote) then
        Begin
          If (edtNumLote Is TEditFocus) Then
            (edtNumLote As TEditFocus).Text := qryConsulta.FieldByName('LOT_NUMLOT').AsString
          Else
            edtNumLote.Text := qryConsulta.FieldByName('LOT_NUMLOT').AsString;
        End;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtNumLote) then
          Begin
            If (edtNumLote Is TEditFocus) Then
             // (edtNumLote As TEditFocus).Text := fStrZero('0', 3)
              (edtNumLote As TEditFocus).Text := '+1'
            Else
             // edtNumLote.Text := fStrZero('0', 3);
              edtNumLote.Text := '+1';
          End;

          (*
          If Assigned(edtCodIte) then
          Begin
            If (edtCodIte Is TEditFocus) Then
              (edtCodIte As TEditFocus).Text := fStrZero('0', 5)
            Else
              edtCodIte.Text := fStrZero('0', 5);
          End;
          *)

        End Else
        Begin
          If Assigned(edtCodIte) then
          Begin
            If (edtCodIte Is TEditFocus) Then
              (edtCodIte As TEditFocus).Text := qryConsulta.FieldByName('LOT_CODITE').AsString
            Else
              edtCodIte.Text := qryConsulta.FieldByName('LOT_CODITE').AsString;
          End;
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
  end;

end;


{************************************}
{* CONSULTA DE TIPOS DE ATENDIMENTO *}
{*********************************MM*}
function fPesqTipoAtendimento(Self     : TForm;                    {* Formulário                                  *}
                              edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                              edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                              qryTabela: TUniQuery;                  {* Query                                       *}
                              Var chrKey: Char;                    {* Key                                         *}
                              Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                              blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}
  Var
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
      strSQL := strSQL + '  TPA_CODIGO,       ';
      strSQL := strSQL + '  TPA_DESCRI,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  CADTPA            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Código',
                   'Descrição',
                   'AUTOINCREM'],
                   ['TPA_DESCRI','TPA_CODIGO'],
                   '',
                   'CADTPA',
                   Self.Name,
                   'Consulta de Tipos de Atendimento',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'TPA_CODIGO') Then
      Begin

        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('TPA_CODIGO').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('TPA_CODIGO').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('TPA_DESCRI').AsString;

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

{*****************************}
{* CONSULTA DE AJUDANTES     *}
{**************************IV*}

{ TDefConsulaItem }

constructor TDefConsulaItem.Create;
begin
  Inherited Create;
  blnColorirGrid := False;

  blnSitPro   := fCfgSis('SITPRO', varBoolean);
  cdsLegendas := TLegendasItem.Create(Nil);
end;

destructor TDefConsulaItem.Destroy;
begin
  FreeAndNil(cdsLegendas);
  Inherited Destroy;
end;

function TDefConsulaItem.fGetCellStyle(AView: TcxGridDBTableView;
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; ADataSet: TDataSet): TcxStyle;
  Var
    ARowInfo: TcxRowInfo;

  function fIdxColumn(strCampo: String): Integer;
  begin
    Result := -1;

    {********************************************************}
    {* ESSA FUNÇAO TEVE DE ALTERAR O COMPONENTE DEV-EXPRESS *}
    {* SE ESTA OCORRENDO ERRO DE TYPECAST VC DEVE VERIFICAR *}
    {* NOS COMPONENTES SE A CORREÇÃO FOI APLICADA EM SUA    *}
    {* MÁQUINA                                              *}
    {*****************************************************AF*}
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

  If blnColorirGrid And ARecord.IsData And (ARecord.Index > -1) Then
  Begin

    If IfNull(fGetValor(fIdxColumn('ITEITEATI')), '') = 'INATIVO' Then
      Result := cdsLegendas.fRetStyle(ARRDESC_SITUACAO_ITEM[sitInativo])

    Else If IfNull(fGetValor(fIdxColumn('ITEATICOM')), '') = 'INATIVO' Then
      Result := cdsLegendas.fRetStyle(ARRDESC_SITUACAO_ITEM[sitInativoCompra])

    Else If IfNull(fGetValor(fIdxColumn('ESTRUT')), 0) > 0 Then
      Result := cdsLegendas.fRetStyle(ARRDESC_SITUACAO_ITEM[sitEstrutura])

    Else If IfNull(fGetValor(fIdxColumn('BOCACAIXA')), '') = 'SIM' Then
      Result := cdsLegendas.fRetStyle(ARRDESC_SITUACAO_ITEM[sitBocaCaixa])

    Else If (IfNull(fGetValor(fIdxColumn('EMPROMOC')), '') = 'SIM') Then
      Result := cdsLegendas.fRetStyle(ARRDESC_SITUACAO_ITEM[sitPromocao])

    Else If blnSitPro And (IfNull(fGetValor(fIdxColumn('SIT_DESCRI')), 0) > 0) Then
      Result := cdsLegendas.fRetStyle(fGetValor(fIdxColumn('SIT_DESCRI')));

  End;
end;

{*********************************}
{* CONSULTA DE PEDIDOS DE COMPRA *}
{******************************JU*}
function fPesqPedidoCompra(Self       : TForm;                           {* Formulário                                 *}
                           edtCodPed  : TCustomEdit;                     {* Edit do Código                             *}
                           qryTabela  : TUniQuery;                         {* Query                                      *}
                           Var chrKey : Char;                            {* Key                                        *}
                           Var arrSel : TConsultasArray;                 {* Array de Seleção                           *}
                           Var strDoc : String;                          {* Espécie de Documento                       *}
                           strCodEmp  : String;                          {* Código da Empresa                          *}
                           intIndice  : Integer;                         {* Pedido ou Orçamento                        *}
                           blnConSim  : Boolean = True;                  {* ConsultaSimples ou Múltipla (multi select) *}
                           objFrmPnl  : TPanelCx = Nil;                  {* Painel                                      *}
                           strLitGal  : String = '3.600';
                           strTitulo  : String = 'Consulta de Pedidos de Compra';
                           blnLotPre  : Boolean = False): Boolean;
  var
    strSQL     : String;
    strWhere   : String;
    strCodPes  : String;
    arrTitCol  : TColunasArray;                                           {* Títulos das Colunas                         *}
    objConsulta: TDefConsultaPedidoCompra;
    qryConsulta: TUniQuery;

    Procedure pAddNomeColuna(strNomCol: String);
    Begin
      SetLength(arrTitCol, Succ(Length(arrTitCol)));
      arrTitCol[High(arrTitCol)] := strNomCol;
    End;

Begin
  Result := False;

  If fEntraCons(chrKey) Then
  Begin
    chrKey := #0;

    objConsulta := TDefConsultaPedidoCompra.Create;

    strSQL := '';

    strSQL := ' SELECT * FROM (';

    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  PCG_NUMPED, ';      pAddNomeColuna('Pedido');
    strSQL := strSQL + '  PCG_CODEMP, ';      pAddNomeColuna('Emp.Ori.');

    strSQL := strSQL + '  IF(PCG_EMPDES IS NULL, "   ", PCG_EMPDES) AS PCG_EMPDES, ';      pAddNomeColuna('Emp.Dest.');

    strSQL := strSQL + '  PCG_ESPDOC, ';      pAddNomeColuna('Espécie');
    strSQL := strSQL + '  PCG_CODFOR, ';      pAddNomeColuna('Cód. Forn.');
    strSQL := strSQL + '  FOR_NOMFOR, ';      pAddNomeColuna('Fornecedor');
    strSQL := strSQL + '  PCG_DTAPED, ';      pAddNomeColuna('Dta. Ped.');
    strSQL := strSQL + '  PCG_DTAENT, ';      pAddNomeColuna('Dta. Entrega');
    strSQL := strSQL + '  PCG_CONPAG, ';      pAddNomeColuna('Cond. Pagto.');

    strSQL := strSQL + '  IF(SUM(PCD_QTDBAI) <= 0, "NÃO RECEB.", "RECEB. PARC.") AS PCG_STATUS, ';      pAddNomeColuna('Status');

    strSQL := strSQL + '  PCG_TOTITE, ';      pAddNomeColuna('Total Itens');
    strSQL := strSQL + '  PCG_TOTIPI, ';      pAddNomeColuna('Total IPI');
    strSQL := strSQL + '  PCG_TOTSUB, ';      pAddNomeColuna('Total SUB');

    strSQL := strSQL + '  IF(PCG_VALFRE IS NULL OR PCG_VALFRE = "", 0.00, PCG_VALFRE) AS PCG_TOTFRE, ';      pAddNomeColuna('Total Frete');

    strSQL := strSQL + '  PCG_TOTGER, ';      pAddNomeColuna('Total Pedido');

    strSQL := strSQL + ' CONCAT(PCG_NUMCOT, "-", PCG_EMPCOT) AS PCG_NUMCOT, ';      pAddNomeColuna('Cotação de Origem');

    If SameText(fCfgSis('LITGAL'), 'L') Then
    Begin
      strSQL := strSQL +          '  SUM((IF(PCD_QTDITE - PCD_QTDBAI > 0, PCD_QTDITE - PCD_QTDBAI, 0) * ' +
          '      (SELECT UNI_PESLIT ' +
          '       FROM CADUNI '       +
          '       WHERE UNI_CODUNI = PCD_CODUNI LIMIT 1))) AS PCG_LITRAG, ';    pAddNomeColuna('Litros/Kilos');
    End Else
    Begin
      strSQL := strSQL +  '  SUM((IF(PCD_QTDITE - PCD_QTDBAI > 0, PCD_QTDITE - PCD_QTDBAI, 0) * ' +
          '      (SELECT UNI_PESLIT /' + strLitGal +
          '       FROM CADUNI ' +
          '       WHERE UNI_CODUNI = PCD_CODUNI LIMIT 1))) AS PCG_LITRAG, ';    pAddNomeColuna('Galonagem');
    End;

    strSQL := strSQL + '  SUM(IF(PCD_QTDITE - PCD_QTDBAI > 0, PCD_QTDITE - PCD_QTDBAI, 0) * IFNULL(ITE_PESOIT, 0)) AS PESBRU, ';          pAddNomeColuna('Peso Bruto');

    strSQL := strSQL + '  PCG_DOCORI, ';      pAddNomeColuna('Doc. Orig.');
    strSQL := strSQL + '  FOR_NOMFAN, ';      pAddNomeColuna('Fornecedor (Fantasia)');

    strSQL := strSQL + ' CONCAT(PCG_CODCMP, "-", B.OPE_NOMOPE) AS PCG_NOMCOM, ';      pAddNomeColuna('Nome do Comprador');

    strSQL := strSQL + '  PCG_DTAMAI, ';      pAddNomeColuna('Data Envio Email');
    strSQL := strSQL + '  PCG_HORMAI, ';      pAddNomeColuna('Hora Envio Email');

    strSQL := strSQL + '  CONCAT(PCG_OPEMAI, "-", A.OPE_NOMOPE) AS PCG_NOPEMA, ';      pAddNomeColuna('Operador que enviou Email');

    strSQL := strSQL + '  PCG_NOMMAI, ';      pAddNomeColuna('Nome Destinatário Email');
    strSQL := strSQL + '  PCG_DESMAI, ';      pAddNomeColuna('Endereço Destinatário Email');

    (**************************************************************)
    (* COLUNAS QUE NAO VAO APARECER DEVEM FICAR DAQUI PARA BAIXO  *)
    (**************************************************************)
    strSQL := strSQL + '  PCMGER.AUTOINCREM, ';
    strSQL := strSQL + '  PCG_DIACOM, ';
    strSQL := strSQL + '  PCG_DIANVA, ';
    strSQL := strSQL + '  PCG_DIANVB, ';
    strSQL := strSQL + '  PCG_DIANVC  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  PCMGER ';
    strSQL := strSQL + '  JOIN CADFOR ON FOR_CODFOR = PCG_CODFOR ';
    strSQL := strSQL + '  JOIN PCMDET ON PCG_NUMPED = PCD_NUMPED ';
    strSQL := strSQL + '  AND PCG_ESPDOC = PCD_ESPDOC ';
    strSQL := strSQL + '  AND PCG_CODEMP = PCD_CODEMP ';

    strSQL := strSQL + '  JOIN CADITE ON ITE_CODITE = PCD_CODITE ';

    strSQL := strSQL + '  LEFT JOIN CADOPE A ON A.OPE_CODOPE = PCG_OPEMAI ';
    strSQL := strSQL + '  LEFT JOIN CADOPE B ON B.OPE_CODOPE = PCG_CODCMP ';

    strSQL := strSQL + 'WHERE  ';
    strSQL := strSQL + '  TRUE ';

    If intIndice = 0 Then
    Begin
      strSQL := strSQL + '  AND PCG_ESPDOC = "PD" ';
      strDoc := 'PD';

      If fCfgSis('USACON', varBoolean) Then
        strSQL := strSQL + '  AND PCG_DTALIB IS NULL ';
    End
    Else
    Begin
      strSQL := strSQL + '  AND PCG_ESPDOC = "OR" ';
      strDoc := 'OR';
    End;

    strSQL := strSQL + '  AND PCG_NUMCTN = 0 ';
   
    strSQL := strSQL + '  AND (PCG_BAIXAD = FALSE OR PCG_BAIXAD IS NULL) ';

    If Not fEmptyStr(strCodEmp) Then
      strSQL := strSQL + '  AND PCG_CODEMP  = ' + QuotedStr(strCodEmp) + ' ';

    If blnLotPre Then
    Begin
      // SE NÃO HÁ ITENS BAIXADOS
      strSQL := strSQL + '  AND (SELECT COUNT(*) FROM PCMDET ';
      strSQL := strSQL + '       WHERE ';
      strSQL := strSQL + '         PCD_NUMPED = PCG_NUMPED AND ';
      strSQL := strSQL + '         PCD_CODEMP = PCG_CODEMP AND ';
      strSQL := strSQL + '         PCD_ESPDOC = PCG_ESPDOC AND ';
      strSQL := strSQL + '         PCD_NUMCTN = 0 AND ';
      strSQL := strSQL + '         PCD_BAIXAD <> 0   ';
      strSQL := strSQL + '       ) = 0 ';

      // SE NÃO HÁ ITENS PARA ATUALIZAR PREÇOS
      strSQL := strSQL + '  AND (SELECT COUNT(*) FROM PCMDET ';
      strSQL := strSQL + '       WHERE ';
      strSQL := strSQL + '         PCD_NUMPED = PCG_NUMPED AND ';
      strSQL := strSQL + '         PCD_CODEMP = PCG_CODEMP AND ';
      strSQL := strSQL + '         PCD_ESPDOC = PCG_ESPDOC AND ';
      strSQL := strSQL + '         PCD_NUMCTN = 0 AND ';
      strSQL := strSQL + '         PCD_BAIXAD = 0 AND ';
      strSQL := strSQL + '         IFNULL(PCD_PREATU, "N") = "N" ';
      strSQL := strSQL + '       ) > 0 ';
    End;

    strSQL := strSQL + '  GROUP BY PCG_NUMPED, PCG_ESPDOC, PCG_CODEMP ';

    strSQL := strSQL + ' ) AS TABPED ';

    strWhere := strWhere + ' WHERE  ';
    strWhere := strWhere + '   TRUE ';

    strCodPes := 'AUTOINCREM';

    If Not Assigned(qryTabela) Then
      qryConsulta := fCriaQuery(Nil)
    Else
      qryConsulta := qryTabela;

    If fConsulta([strSQL,strWhere],
                 arrTitCol,
                 ['PCG_NUMPED','FOR_NOMFOR','PCG_CODFOR'],
                 'AUTOINCREM',
                 'PCMGER',
                 Self.Name,
                 strTitulo,
                 qryConsulta,
                 objFrmPnl,
                 blnConSim,
                 arrSel,
                 strCodPes,
                 objConsulta,
                 False,
                 False,
                 '',
                 Nil,
                 True,
                 True,
                 True,
                 Nil,
                 Nil,
                 Nil,
                 VS_Application) Then
    Begin
      If Assigned(edtCodPed) then
      Begin
        If (edtCodPed Is TMaskEditFocus) Then
          (edtCodPed As TMaskEditFocus).Text := qryConsulta.FieldByName('PCG_NUMPED').AsString {qryConsulta.FieldByName(strCodPes).AsString}
        Else
          edtCodPed.Text := qryConsulta.FieldByName('PCG_NUMPED').AsString{qryConsulta.FieldByName(strCodPes).AsString};
      End;

      If (Length(arrSel) > 1) Then
      Begin

        If Assigned(edtCodPed) then
        Begin
          If (edtCodPed Is TMaskEditFocus) Then
            (edtCodPed As TMaskEditFocus).Text := fStrZero('0', 12)
          Else
            edtCodPed.Text := fStrZero('0', 12);
        End;

      End;

      Result := True;

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);

    End;

    FreeAndNil(objConsulta);

  End;

End;

{*************************}
{* CONSULTA DE CAMPANHAS *}
{**********************JU*}
function fPesqCampanha(Self       : TForm;                                {* Formulário                                  *}
                       edtCodCam  : TCustomEdit;                          {* Edit do Codigo                              *}
                       edtDesCam  : TEditFocus;                           {* Edit da Descrição                           *}
                       qryConCam  : TUniQuery;                              {* Query                                       *}
                       Var chrKey : Char;                                 {* Key                                         *}
                       Var arrSel : TConsultasArray;                      {* Array de Seleção                            *}
                       blnConSim  : Boolean = True;                       {* Consulta Simples ou Múltipla (multi select) *}
                       strTitulo  : String = 'Consulta de Campanhas';
                       blnRetCod  : Boolean = False): Boolean;
  Var
    arrTitCol  : TColunasArray;                                           {* Títulos das Colunas                         *}
    strSQL     : String;
    qryConsulta: TUniQuery;

    Procedure pAddNomeColuna(strNomCol: String);
    Begin
      SetLength(arrTitCol, Succ(Length(arrTitCol)));
      arrTitCol[High(arrTitCol)] := strNomCol;
    End;

Begin
  Result := False;

  If fEntraCons(chrKey) Then
  Begin

    chrKey := #0;

    Try

      strSQL := '';
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   CMG_CODCMG, '; pAddNomeColuna('Código');
      strSQL := strSQL + '   CMG_DESCMG, '; pAddNomeColuna('Descrição');
      strSQL := strSQL + '   CMG_DTAINI, '; pAddNomeColuna('Data Inicial');
      strSQL := strSQL + '   CMG_DTAFIN, '; pAddNomeColuna('Data Final');
      strSQL := strSQL + '   CMG_ATIVA_, '; pAddNomeColuna('Ativa');
      strSQL := strSQL + '   AUTOINCREM  ';
      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + '   CAMGER ';

      If Not Assigned(qryConCam) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryConCam;

      If fConsulta([strSQL],
                   arrTitCol,
                   ['CMG_DESCMG','CMG_CODCMG'],
                   'AUTOINCREM',
                   'CAMGER',
                   Self.Name,
                   strTitulo,
                   qryConsulta,
                   nil,
                   blnConSim,
                   arrSel,
                   IIF(blnRetCod,'CMG_CODCMG','AUTOINCREM'),
                   nil) Then
      Begin
        If Assigned(edtCodCam) then
        Begin
          If (edtCodCam Is TMaskEditFocus) Then
            (edtCodCam As TMaskEditFocus).Text := qryConsulta.FieldByName('CMG_CODCMG').AsString
          Else
            edtCodCam.Text := qryConsulta.FieldByName('CMG_CODCMG').AsString;
        End;

        If Assigned(edtDesCam) Then
          edtDesCam.Text := qryConsulta.FieldByName('CMG_DESCMG').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodCam) then
          Begin
            If (edtCodCam Is TMaskEditFocus) Then
              (edtCodCam As TMaskEditFocus).Text := fStrZero('0', 8)
            Else
              edtCodCam.Text := fStrZero('0', 8);
          End;

          If Assigned(edtDesCam) Then
            edtDesCam.Text := '+1';

        End;

        Result := True;

        If Not Assigned(qryConCam) Then
          FreeAndNil(qryConsulta);
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;

  End;

End;

{************************}
{* CONSULTA DE ENTREGAS *}
{*********************JU*}
function fPesqEntrga(Self : TForm;                                        {* Formulário                                  *}
                     edtNumEnt : TCustomEdit;                             {* Edit do Número de entrega                   *}
                     qryConEnt : TUniQuery;                                 {* Query                                       *}
                     Var chrKey: Char;                                    {* Key                                         *}
                     Var arrSel: TConsultasArray;                         {* Array de Seleção                            *}
                     blnConSimp: Boolean = True;                          {* Consulta Simples ou Múltipla (multi select) *}
                     strTitulo : String = 'Consulta de Entregas'): Boolean;
  Var
    arrTitCol  : TColunasArray;                                           {* Títulos das Colunas                         *}
    strSQL     : String;
    strWhere   : String;
    qryConsulta: TUniQuery;

    Procedure pAddNomeColuna(strNomCol: String);
    Begin
      SetLength(arrTitCol, Succ(Length(arrTitCol)));
      arrTitCol[High(arrTitCol)] := strNomCol;
    End;

Begin
  Result := False;

  If fEntraCons(chrKey) Then
  Begin

    chrKey := #0;

    Try

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  ENG_PROENT, ';       pAddNomeColuna('Num.Entrega');
      strSQL := strSQL + '  ENG_CODENT, ';       pAddNomeColuna('Código Entregador');
      strSQL := strSQL + '  MOT_NOMMOT, ';       pAddNomeColuna('Nome Entregador');
      strSQL := strSQL + '  ENG_DTACAD, ';       pAddNomeColuna('Data de Cadastro');
      strSQL := strSQL + '  ENG_HRACAD, ';       pAddNomeColuna('Hora de Cadastro');
      strSQL := strSQL + '  ENG_PLAVEI, ';       pAddNomeColuna('Veículo');
      strSQL := strSQL + '  COMENG.AUTOINCREM ';
      strSQL := strSQL + 'FROM      ';
      strSQL := strSQL + '  COMENG, ';
      strSQL := strSQL + '  CADMOT  ';

      strWhere := '';
      strWhere := strWhere + 'WHERE     ';
      strWhere := strWhere + '  MOT_CODMOT = ENG_CODENT ';

      If Not Assigned(qryConEnt) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryConEnt;

      If fConsulta([strSQL, strWhere],
                   arrTitCol,
                   ['ENG_PROENT','MOT_NOMMOT','ENG_CODENT'],
                   'AUTOINCREM',
                   'COMENG',
                   Self.Name,
                   strTitulo,
                   qryConsulta,
                   nil,
                   blnConSimp,
                   arrSel,
                   'AUTOINCREM',
                   nil) Then
      Begin
        If Assigned(edtNumEnt) then
        Begin
          If (edtNumEnt Is TMaskEditFocus) Then
            (edtNumEnt As TMaskEditFocus).Text := qryConsulta.FieldByName('ENG_PROENT').AsString
          Else
            edtNumEnt.Text := qryConsulta.FieldByName('ENG_PROENT').AsString;
        End;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtNumEnt) then
          Begin
            If (edtNumEnt Is TMaskEditFocus) Then
              (edtNumEnt As TMaskEditFocus).Text := fStrZero('0', 8)
            Else
              edtNumEnt.Text := fStrZero('0', 8);
          End;

        End;

        Result := True;

        If Not Assigned(qryConEnt) Then
          FreeAndNil(qryConsulta);
      End;
    Except

      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;

    End;

  End;

End;

function fPesqRequisicao(Self      : TForm;                                   {* Formulário                                  *}
                         edtNumReq : TCustomEdit;                             {* Edit do Número de Requisicao                *}
                         qryConReq : TUniQuery;                               {* Query                                       *}
                         Var chrKey: Char;                                    {* Key                                         *}
                         Var arrSel: TConsultasArray;                         {* Array de Seleção                            *}
                         strCodEmp : String;                                  {* Codigo da Empresa                           *}
                         blnConSim : Boolean = True;                          {* Consulta Simples ou Múltipla (multi select) *}
                         strTitulo : String = 'Consulta de Requisições de Envio de Materiais'): Boolean;
  Var
    arrTitCol  : TColunasArray;                                           {* Títulos das Colunas                         *}
    strSQL     : String;
    strWhere   : String;
    qryConsulta: TUniQuery;

    Procedure pAddNomeColuna(strNomCol: String);
    Begin
      SetLength(arrTitCol, Succ(Length(arrTitCol)));
      arrTitCol[High(arrTitCol)] := strNomCol;
    End;

Begin
  Result := False;

  If fEntraCons(chrKey) Then
  Begin

    chrKey := #0;

    Try

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  GER_NUMDOC, ';  pAddNomeColuna('Nro.Requisição');
      strSQL := strSQL + '  GER_DTAENT, ';  pAddNomeColuna('Data Entrada');
      strSQL := strSQL + '  GER_TOTPRO, ';  pAddNomeColuna('Valor Total');
      strSQL := strSQL + '  GER_CLAFIS, ';  pAddNomeColuna('Class.Fiscal');
      strSQL := strSQL + '  GER_MEN001, ';  pAddNomeColuna('Mensagem');
      strSQL := strSQL + '  AUTOINCREM ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  MOVGER ';

      strWhere := '';
      strWhere := strWhere + 'WHERE ';
      strWhere := strWhere + 'GER_ESPDOC = "RQ" AND GER_CODEMP = ' + QuotedStr(strCodEmp);

      If Not Assigned(qryConReq) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryConReq;

      If fConsulta([strSQL, strWhere],
                   arrTitCol,
                   ['GER_NUMDOC','GER_DTAENT'],
                   'AUTOINCREM',
                   'MOVGER',
                   Self.Name,
                   strTitulo,
                   qryConsulta,
                   nil,
                   blnConSim,
                   arrSel,
                   'AUTOINCREM',
                   nil) Then
      Begin
        If Assigned(edtNumReq) then
        Begin
          If (edtNumReq Is TMaskEditFocus) Then
            (edtNumReq As TMaskEditFocus).Text := qryConsulta.FieldByName('GER_NUMDOC').AsString
          Else
            edtNumReq.Text := qryConsulta.FieldByName('GER_NUMDOC').AsString;
        End;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtNumReq) then
          Begin
            If (edtNumReq Is TMaskEditFocus) Then
              (edtNumReq As TMaskEditFocus).Text := fStrZero('0', 12)
            Else
              edtNumReq.Text := fStrZero('0', 12);
          End;

        End;

        Result := True;

        If Not Assigned(qryConReq) Then
          FreeAndNil(qryConsulta);
      End;

    Except

      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;

    End

  End;

End;

function fPesqNFCompra(Self      : TForm;                                   {* Formulário                                  *}
                       edtNumDoc : TCustomEdit;                             {* Edit do Número de Requisicao                *}
                       qryConDoc : TUniQuery;                               {* Query                                       *}
                       Var chrKey: Char;                                    {* Key                                         *}
                       Var arrSel: TConsultasArray;                         {* Array de Seleção                            *}
                       strCodEmp : String;                                  {* Codigo da Empresa                           *}
                       Var dtaNFComp: TDatetime;                            {* Data da NF                                  *}
                       blnConSim : Boolean = True;                          {* Consulta Simples ou Múltipla (multi select) *}
                       objFrmPnl : TPanelCx = Nil;                          {* Painel                                      *}
                       strTitulo : String = 'Consulta de NF de Compra';
                       strCodCli : String = ''): Boolean;
  Var
    arrTitCol  : TColunasArray;                                             {* Títulos das Colunas                         *}
    strSQL     : String;
    qryConsulta: TUniQuery;

    Procedure pAddNomeColuna(strNomCol: String);
    Begin
      SetLength(arrTitCol, Succ(Length(arrTitCol)));
      arrTitCol[High(arrTitCol)] := strNomCol;
    End;

    Function fSQLDocs(strTabela, strCodCli: String; blnAddColuna: Boolean = False): String;
    Begin
      Result := '';
      Result := Result + 'SELECT ';
      Result := Result + '  GER_NUMDOC, '; If blnAddColuna Then pAddNomeColuna('Nro. Documento');
      Result := Result + '  GER_DTAENT, '; If blnAddColuna Then pAddNomeColuna('Data Entrada');
      Result := Result + '  GER_TOTPRO, '; If blnAddColuna Then pAddNomeColuna('Valor Total');
      Result := Result + '  CLI_NOMCLI, '; If blnAddColuna Then pAddNomeColuna('Cliente');
      Result := Result + '  G.AUTOINCREM ';
      Result := Result + 'FROM ';
      Result := Result + '  ' + strTabela + ' G INNER JOIN CADCLI C ON G.GER_CODCLI = C.CLI_CODCLI ';
      Result := Result + 'WHERE ';
      Result := Result + '  G.GER_ESPDOC IN ("NF","IF") ';

      If Not fEmptyStr(strCodCli) Then
        Result := Result + '  AND G.GER_CODCLI = ' + QuotedStr(strCodCli);
    End;

Begin
  Result := False;

  If fEntraCons(chrKey) Then
  Begin

    chrKey := #0;

    Try

      strSQL := '';
      strSQL := 'SELECT * FROM ( ';
      strSQL := strSQL + fSQLDocs('MOVGER', strCodCli, True) +
                         ' UNION ALL ' +
                         fSQLDocs('NOTGER', strCodCli) + ') AS GER ';

      If Not Assigned(qryConDoc) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryConDoc;

      If fConsulta([strSQL],
                   arrTitCol,
                   ['GER_NUMDOC','GER_DTAENT'],
                   'AUTOINCREM',
                   'MOVGER',
                   Self.Name,
                   strTitulo,
                   qryConsulta,
                   objFrmPnl,
                   blnConSim,
                   arrSel,
                   'AUTOINCREM',
                   nil,
                   False,
                   False,
                   '',
                   Nil,
                   True,
                   True,
                   True,
                   Nil,
                   Nil,
                   Nil,
                   VS_Application) Then
      Begin
        If Assigned(edtNumDoc) then
        Begin
          If (edtNumDoc Is TMaskEditFocus) Then
            (edtNumDoc As TMaskEditFocus).Text := qryConsulta.FieldByName('GER_NUMDOC').AsString
          Else
            edtNumDoc.Text := qryConsulta.FieldByName('GER_NUMDOC').AsString;
        End;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtNumDoc) then
          Begin
            If (edtNumDoc Is TMaskEditFocus) Then
              (edtNumDoc As TMaskEditFocus).Text := fStrZero('0', 12)
            Else
              edtNumDoc.Text := fStrZero('0', 12);
          End;

        End;

        If (qryConsulta.FieldByName('GER_DTAENT').AsDateTime > 0) Then
          dtaNFComp := qryConsulta.FieldByName('GER_DTAENT').AsDateTime
        Else
          dtaNFComp := 0;

        Result := True;

        If Not Assigned(qryConDoc) Then
          FreeAndNil(qryConsulta);
      End;

    Except

      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;

    End

  End;

End;

function fPesqNFEntrada(Self      : TForm;                                   {* Formulário                                  *}
                        edtNumDoc : TCustomEdit;                             {* Edit do Número de Requisicao                *}
                        qryConDoc : TUniQuery;                               {* Query                                       *}
                        Var chrKey: Char;                                    {* Key                                         *}
                        Var arrSel: TConsultasArray;                         {* Array de Seleção                            *}
                        blnConSim : Boolean = True;                          {* Consulta Simples ou Múltipla (multi select) *}
                        objFrmPnl : TPanelCx = Nil;                          {* Painel                                      *}
                        strTitulo : String = 'Consulta de NF de Entrada'): Boolean;
  Var
    arrTitCol  : TColunasArray;                                             {* Títulos das Colunas                         *}
    strSQL, strWhere: String;
    qryConsulta: TUniQuery;

    Procedure pAddNomeColuna(strNomCol: String);
    Begin
      SetLength(arrTitCol, Succ(Length(arrTitCol)));
      arrTitCol[High(arrTitCol)] := strNomCol;
    End;

Begin
  Result := False;

  If fEntraCons(chrKey) Then
  Begin

    chrKey := #0;

    Try
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  GER_NUMDOC, '; pAddNomeColuna('Nro. Documento');
      strSQL := strSQL + '  GER_ESPDOC, '; pAddNomeColuna('Espécie Documento');
      strSQL := strSQL + '  GER_CODEMP, '; pAddNomeColuna('Código empresa');
      strSQL := strSQL + '  GER_SERIE_, '; pAddNomeColuna('Série');
      strSQL := strSQL + '  GER_DTAENT, '; pAddNomeColuna('Data Entrada');
      strSQL := strSQL + '  GER_TOTPRO, '; pAddNomeColuna('Valor Total');
      strSQL := strSQL + '  CLI_NOMCLI, '; pAddNomeColuna('Cliente');
      strSQL := strSQL + '  G.AUTOINCREM ';
      strSQL := strSQL + 'FROM MOVGER G ';
      strSQL := strSQL + 'INNER JOIN CADCLI C ';
      strSQL := strSQL + '  ON G.GER_CODCLI = C.CLI_CODCLI ';
      strWhere := 'WHERE LEFT(GER_CLAFIS, 1) < 5 ';


      If Not Assigned(qryConDoc) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryConDoc;

      If fConsulta([strSQL, strWhere],
                   arrTitCol,
                   ['GER_NUMDOC','GER_DTAENT'],
                   'AUTOINCREM',
                   'MOVGER',
                   Self.Name,
                   strTitulo,
                   qryConsulta,
                   objFrmPnl,
                   blnConSim,
                   arrSel,
                   'AUTOINCREM',
                   nil,
                   False,
                   False,
                   '',
                   Nil,
                   True,
                   True,
                   True,
                   Nil,
                   Nil,
                   Nil,
                   VS_Application) Then
      Begin
        If Assigned(edtNumDoc) then
        Begin
          If (edtNumDoc Is TMaskEditFocus) Then
            (edtNumDoc As TMaskEditFocus).Text := qryConsulta.FieldByName('GER_NUMDOC').AsString
          Else
            edtNumDoc.Text := qryConsulta.FieldByName('GER_NUMDOC').AsString;
        End;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtNumDoc) then
          Begin
            If (edtNumDoc Is TMaskEditFocus) Then
              (edtNumDoc As TMaskEditFocus).Text := fStrZero('0', 12)
            Else
              edtNumDoc.Text := fStrZero('0', 12);
          End;

        End;

        Result := True;

        If Not Assigned(qryConDoc) Then
          FreeAndNil(qryConsulta);
      End;

    Except

      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;

    End

  End;
End;

{*********************************}
{* CONSULTA DE AJUSTE DE ESTOQUE *}
{******************************JU*}
{***********************************}
{* COSULTA DE CLASSIFICAÇÃO DE IPI *}
{********************************JU*}
function fPesqClaIPI(Self      : TForm;                                   {* Formulário                                  *}
                     edtClaIPI : TCustomEdit;                             {* Edit do Número de Ajuste                    *}
                     qryConIPI : TUniQuery;                               {* Query                                       *}
                     Var chrKey: Char;                                    {* Key                                         *}
                     Var arrSel: TConsultasArray;                         {* Array de Seleção                            *}
                     blnConSim : Boolean = True;                          {* Consulta Simples ou Múltipla (multi select) *}
                     strTitulo : String  = 'Consulta de Classificação de IPI'): Boolean;
  Var
    arrTitCol  : TColunasArray;                                           {* Títulos das Colunas                         *}
    strSQL     : String;
    strWhere   : String;
    strGroup   : String;
    qryConsulta: TUniQuery;

    Procedure pAddNomeColuna(strNomCol: String);
    Begin
      SetLength(arrTitCol, Succ(Length(arrTitCol)));
      arrTitCol[High(arrTitCol)] := strNomCol;
    End;

Begin
  Result := False;

  If fEntraCons(chrKey) Then
  Begin

    chrKey := #0;

    Try

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  ITE_CLAIPI, '; pAddNomeColuna('Classificação de IPI');
      strSQL := strSQL + '  ITE_CLAIPI AS AUTOINCREM ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADITE ';

      strWhere := strWhere + 'WHERE  ';
      strWhere := strWhere + '  ITE_CLAIPI <> "" AND ';
      strWhere := strWhere + '  ITE_CLAIPI IS NOT NULL ';

      strGroup := strGroup + 'GROUP BY  ';
      strGroup := strGroup + '  ITE_CLAIPI ';

      If Not Assigned(qryConIPI) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryConIPI;

      If fConsulta([strSQL, strWhere, strGroup],
                   arrTitCol,
                   ['ITE_CLAIPI'],
                   'ITE_CLAIPI',
                   'CADITE',
                   Self.Name,
                   strTitulo,
                   qryConsulta,
                   nil,
                   blnConSim,
                   arrSel,
                   'ITE_CLAIPI',
                   nil) Then
      Begin
        If Assigned(edtClaIPI) then
        Begin
          If (edtClaIPI Is TMaskEditFocus) Then
            (edtClaIPI As TMaskEditFocus).Text := qryConsulta.FieldByName('ITE_CLAIPI').AsString
          Else
            edtClaIPI.Text := qryConsulta.FieldByName('ITE_CLAIPI').AsString;
        End;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtClaIPI) then
          Begin
            If (edtClaIPI Is TMaskEditFocus) Then
              (edtClaIPI As TMaskEditFocus).Text := fStrZero('0', 8)
            Else
              edtClaIPI.Text := '+1';
          End;

        End;

        Result := True;

        If Not Assigned(qryConIPI) Then
          FreeAndNil(qryConsulta);
      End;

    Except

      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;

    End;

  End;

End;

{****************************}
{* COSULTA DE CONFIGURAÇÕES *}
{*************************JU*}
function fPesqCfgSis(Self      : TForm;                                   {* Formulário                                  *}
                     edtCodCfg : TCustomEdit;                             {* Edit do Codigo                              *}
                     edtDesCfg : TEditFocus;                              {* Edit da Descrição                           *}
                     qryConCfg : TUniQuery;                                 {* Query                                       *}
                     Var chrKey: Char;                                    {* Key                                         *}
                     Var arrSel: TConsultasArray;                         {* Array de Seleção                            *}
                     blnConSim : Boolean = True;                          {* Consulta Simples ou Múltipla (multi select) *}
                     strTitulo : String  = 'Consulta de Configurações'): Boolean;
  Var
    arrTitCol  : TColunasArray;                                           {* Títulos das Colunas                         *}
    strSQL     : String;
    strWhere   : String;
    qryConsulta: TUniQuery;
    objConsulta: TDefConsulta;

    Procedure pAddNomeColuna(strNomCol: String);
    Begin
      SetLength(arrTitCol, Succ(Length(arrTitCol)));
      arrTitCol[High(arrTitCol)] := strNomCol;
    End;

Begin
  Result := False;

  If fEntraCons(chrKey) Then
  Begin

    chrKey := #0;

    Try
      objConsulta := TDefConsulta.Create;

      strSQL := '';
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '    CODIGO, ';    pAddNomeColuna('Código');
      strSQL := strSQL + '   SIS_DESCRI, '; pAddNomeColuna('Descrição');
      strSQL := strSQL + '   AUTOINCREM ';
      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + '   CFGSIS ';

      strWhere := strWhere + 'WHERE ';
      strWhere := strWhere + '  SIS_CODEMP = ' + QuotedStr(VS_strCodEmp);

      objConsulta.pIncluiSubConsulta('AUTOINCREM', 'SIS_CODCFG');
      objConsulta.pIncluiSubConsulta('CODIGO', 'RIGHT(SIS_CODCFG,6)');

      If Not Assigned(qryConCfg) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryConCfg;

      If fConsulta([strSQL, strWhere],
                   arrTitCol,
                   ['SIS_DESCRI','CODIGO'],
                   'CODIGO',
                   'CFGSIS',
                   Self.Name,
                   strTitulo,
                   qryConsulta,
                   nil,
                   blnConSim,
                   arrSel,
                   'CODIGO',
                   objConsulta,
                   False,
                   False,
                   'SIS_CODCFG') Then
      Begin

        Result := True;

        If Not Assigned(qryConCfg) Then
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

End;

function fPesqCfgTin(Self      : TForm;                                   {* Formulário                                  *}
                     edtCodCfg : TCustomEdit;                             {* Edit do Codigo                              *}
                     edtDesCfg : TEditFocus;                              {* Edit da Descrição                           *}
                     qryConCfg : TUniQuery;                                 {* Query                                       *}
                     Var chrKey: Char;                                    {* Key                                         *}
                     Var arrSel: TConsultasArray;                         {* Array de Seleção                            *}
                     blnConSim : Boolean = True;                          {* Consulta Simples ou Múltipla (multi select) *}
                     strTitulo : String  = 'Consulta de Configurações da Tinta de Máquina'): Boolean;
  Var
    arrTitCol  : TColunasArray;                                           {* Títulos das Colunas                         *}
    strSQL     : String;
    strWhere   : String;
    qryConsulta: TUniQuery;
    objConsulta: TDefConsulta;

    Procedure pAddNomeColuna(strNomCol: String);
    Begin
      SetLength(arrTitCol, Succ(Length(arrTitCol)));
      arrTitCol[High(arrTitCol)] := strNomCol;
    End;

Begin
  Result := False;

  If fEntraCons(chrKey) Then
  Begin

    chrKey := #0;

    Try

      objConsulta := TDefConsulta.Create;

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  CODIGO, ';     pAddNomeColuna('Código');
      strSQL := strSQL + '  CFG_IDEPRO, '; pAddNomeColuna('ID');
      strSQL := strSQL + '  CFG_DESCRI, '; pAddNomeColuna('Descrição');
      strSQL := strSQL + '  AUTOINCREM ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CFGTIN ';

      strWhere := strWhere + 'WHERE ';
      strWhere := strWhere + '  CFG_CODEMP = ' + QuotedStr(VS_strCodEmp);
      strWhere := strWhere + '  AND CFG_GRUCFG = "CONFIGURACOES" ';

      objConsulta.pIncluiSubConsulta('AUTOINCREM', 'CFG_CODCFG');
      objConsulta.pIncluiSubConsulta('CODIGO', 'RIGHT(CFG_CODCFG,6)');

      If Not Assigned(qryConCfg) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryConCfg;

      If fConsulta([strSQL, strWhere],
                   arrTitCol,
                   ['CFG_DESCRI','CODIGO'],
                   'CODIGO',
                   'CFGTIN',
                   Self.Name,
                   strTitulo,
                   qryConsulta,
                   nil,
                   blnConSim,
                   arrSel,
                   'CODIGO',
                   objConsulta,
                   False,
                   False,
                   'CFG_CODCFG') Then
      Begin

        Result := True;

        If Not Assigned(qryConCfg) Then
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

End;


{*********************************}
{* CONSULTA DE ORDENS DE SERVIÇO *}
{******************************JU*}
function fPesqOrdServ(Self      : TForm;                                  {* Formulário                                  *}
                      edtNumOrd : TCustomEdit;                            {* Edit do Número da Ordem de Serviço          *}
                      qryConOrd : TUniQuery;                              {* Query                                       *}
                      Var chrKey: Char;                                   {* Key                                         *}
                      Var arrSel: TConsultasArray;                        {* Array de Seleção                            *}
                      Var dtaNFOS: TDatetime;                             {* Data da OS                                  *}
                      strStatus : String;                                 {* Status                                      *}
                      strFone   : String;                                 {* Fone                                        *}
                      blnConSim : Boolean = True;                         {* Consulta Simples ou Múltipla (multi select) *}
                      strTitulo : String  = 'Consulta de Ordens de Serviço';
                      intOpcoes : Integer = 3;                            {* 1 = Ordens Abertas, 2 = Ordens Baixadas, 3 = Todas, 4 = Ordens COM STATUS 'APROVADA' OU 'EM MANUTENÇÃO', 5 = Ordens COM STATUS APROVADA / EM MANUTENÇÃO / REALIZADA / REPROVADA *}
                      strSubSta : String = '';                            {* Sub Status                                  *}
                      strSituac : String = '';                            {* Situação                                    *}
                      objFrmPnl : TPanelCx = Nil;                         {* Painel                                      *}
                      strCodCli : String = '';                            {* Cliente                                     *}
                      strNum_OS : String = '';                            {* Não considerar essa O.S.                    *}
                      blnConsOutrasSaidas: Boolean = False): Boolean;     {* Consulta realizada para emissão de outras saídas *}
  Var
    arrTitCol  : TColunasArray;                                           {* Títulos das Colunas                         *}
    strSQL     : String;
    strWhere   : String;
    qryConsulta: TUniQuery;
    objConsulta: TDefConsultaOs;

    Procedure pAddNomeColuna(strNomCol: String);
    Begin
      SetLength(arrTitCol, Succ(Length(arrTitCol)));
      arrTitCol[High(arrTitCol)] := strNomCol;
    End;

Begin
  Result := False;

  If fEntraCons(chrKey) Then
  Begin

    chrKey := #0;

    Try

      objConsulta := TDefConsultaOs.Create;
      objConsulta.pIncluiSubConsulta('FATURA', '(SELECT SQL_NO_CACHE GROUP_CONCAT(DISTINCT CONCAT(FDO_NUMFAT,"-",FDO_TIPFAT)) FROM FATDOR WHERE FDO_NUMDOC = EQU_NUMPED AND FDO_ESPDOC = EQU_TIPPED AND FDO_CODEMP = EQU_CODEMP AND FDO_JAFATU = 1 LIMIT 1)');
      objConsulta.pIncluiSubConsulta('NOMCLI', 'IF(IFNULL(EQU_NOMCON, "") <> "", EQU_NOMCON, CLI_NOMCLI)');
      objConsulta.pIncluiSubConsulta('C_G_C_', 'IF(IFNULL(EQU_NOMCON, "") <> "", EQU_CGCCON, CLI_C_G_C_)');
      objConsulta.pIncluiSubConsulta('CLITEL', 'IF(' + strFone + ' IS NULL, "", CONCAT("(", CONCAT_WS(") ",LEFT(' + strFone + ',2), CONCAT(LEFT(RIGHT(' + strFone + ',9),5),"-",RIGHT(' + strFone + ',4))))) ');
      objConsulta.pIncluiSubConsulta('STATUS_', strStatus);
      objConsulta.pIncluiSubConsulta('SUBSTA_', strSubsta);
      objConsulta.pIncluiSubConsulta('SITUAC_', strSituac);
      objConsulta.pIncluiSubConsulta('DTENTR', 'DATE_ADD(EQU_DTAENT, INTERVAL ' + fCfgSis('PRCOEQ', varString) + ' DAY)');

      If (fCfgSis('TIPEXP', varString) = '4') Then
      Begin
        objConsulta.pIncluiSubConsulta('DTLBEX', 'IF(EQU_STATUS = "A", G.FGO_DTLBEX, "")');
        objConsulta.pIncluiSubConsulta('HRLBEX', 'IF(EQU_STATUS = "A", G.FGO_HRLBEX, "")');
      End;

      objConsulta.pIncluiSubConsulta('NUMCMP', fGetSQLNumCmp('F'));
      objConsulta.pIncluiSubConsulta('DOCENT', '(SELECT IF(IFNULL(MER_TIPOPE, "") = "E", CONCAT(MER_NUMDOC, "/", MER_SERIE_, "-", MER_ESPDOC, "-", MER_EMPGER), "") FROM MEQMER WHERE MER_AUTEQU = EQUGER.AUTOINCREM AND IFNULL(MER_TIPOPE, "") = "E")');
      objConsulta.pIncluiSubConsulta('DOCSAI', '(SELECT IF(IFNULL(MER_TIPOPE, "") = "S", CONCAT(MER_NUMDOC, "/", MER_SERIE_, "-", MER_ESPDOC, "-", MER_EMPGER), "") FROM MEQMER WHERE MER_AUTEQU = EQUGER.AUTOINCREM AND IFNULL(MER_TIPOPE, "") = "S")');
      objConsulta.pIncluiSubConsulta('EQUIP_', '(SELECT EQU_DESCRI FROM CADEQU WHERE EQU_CODIGO = EQU_CODEQU)');

      if fCfgSis('ULCFCE', varBoolean) then
        objConsulta.pIncluiSubConsulta('EQU_LOCFIS', '(SELECT LEQ_DESCRI FROM CADLEQ WHERE LEQ_CODLOC = EQUGER.EQU_LOCFIS AND LEQ_CODEMP = EQUGER.EQU_CODEMP)', 'Localização Física');

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  EQU_NUMOSE, ';            pAddNomeColuna('Número');
      strSQL := strSQL + '  EQU_CODEMP, ';            pAddNomeColuna('Empresa');
      strSQL := strSQL + '  EQU_DTAENT, ';            pAddNomeColuna('Data');
      strSQL := strSQL + '  EQUIP_,     ';            pAddNomeColuna('Equipamento');
      strSQL := strSQL + '  EQU_DESCRI, ';            pAddNomeColuna('Observações');
      strSQL := strSQL + '  MAR_DESMAR, ';            pAddNomeColuna('Marca Equipamento');
      strSQL := strSQL + '  NOMCLI, ';                pAddNomeColuna('Cliente');

      strSQL := strSQL + '  C_G_C_, ';                pAddNomeColuna('CNPJ/CPF Cliente');
      strSQL := strSQL + '  CID_NOMCID, ';            pAddNomeColuna('Cidade Cliente');
      strSQL := strSQL + '  CID_ESTADO, ';            pAddNomeColuna('UF Cliente');

      strSQL := strSQL + '  CLITEL, ';                pAddNomeColuna('Telefone');
      strSQL := strSQL + '  STATUS_, ';               pAddNomeColuna('Status');
      strSQL := strSQL + '  SUBSTA_, ';               pAddNomeColuna('Situação');
      strSQL := strSQL + '  SITUAC_, ';               pAddNomeColuna('Complemento');

      If (fCfgSis('TIPEXP', varString) = '4') Then
      Begin
        strSQL := strSQL + '  DTLBEX, ';              pAddNomeColuna('Data Expedição');
        strSQL := strSQL + '  HRLBEX, ';              pAddNomeColuna('Hora Expedição');
      End;

      strSQL := strSQL + '  EQU_VLRCON, ';            pAddNomeColuna('Valor');
      strSQL := strSQL + '  EQU_NUMPED, ';            pAddNomeColuna('Pedido');
      strSQL := strSQL + '  FATURA, ';                pAddNomeColuna('Docs.Faturam.');
      strSQL := strSQL + '  NUMCMP, ';                pAddNomeColuna('Número Pedido de Compra Item');
      strSQL := strSQL + '  DOCENT, ';                pAddNomeColuna('Nota de Entrada do Conserto');
      strSQL := strSQL + '  DOCSAI, ';                pAddNomeColuna('Nota de Saída do Conserto');
      strSQL := strSQL + '  EQU_NSERIE, ';            pAddNomeColuna('Nº Série');
      strSQL := strSQL + '  OPE_NOMOPE, ';            pAddNomeColuna('Vendedor');

      if (not fCfgSis('ULCFCE', varBoolean)) then
        strSQL := strSQL + '  EQU_LOCFIS, ';            pAddNomeColuna('Localização Física');

      strSQL := strSQL + '  IF(IFNULL(EQU_NOMCON, "") <> "", EQU_CGCCPF, CLI_CGCCPF) AS CGCCPF, ';
      strSQL := strSQL + '  DTENTR, ';
      strSQL := strSQL + '  EQU_CODCLI, ';
      strSQL := strSQL + '  EQUGER.AUTOINCREM ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  EQUGER ';
      strSQL := strSQL + '        JOIN CADCLI ON (CLI_CODCLI=EQU_CODCLI) ';
      strSQL := strSQL + '  LEFT  JOIN FATGOR F ON (F.FGO_NUMDOC = EQU_NUMPED) ';
      strSQL := strSQL + '                     AND (F.FGO_ESPDOC = EQU_TIPPED) ';
      strSQL := strSQL + '                     AND (F.FGO_CODEMP = EQU_CODEMP) ';
      strSQL := strSQL + '  LEFT  JOIN EXTGOR G ON (F.AUTOINCREM = G.FGO_SEQFGO) ';
      strSQL := strSQL + '  LEFT  JOIN CADMAR M ON (M.MAR_CODMAR = (SELECT EQU_CODMAR FROM CADEQU WHERE EQU_CODIGO = EQU_CODEQU) ) ';
      strSQL := strSQL + '  LEFT JOIN CADCID ON CID_CODCID = CLI_CODCID ';
      strSQL := strSQL + '  LEFT JOIN CADOPE ON EQU_CODVEN = OPE_CODOPE ';

      If (blnConsOutrasSaidas) Then Begin
        strSQL := strSQL + '  LEFT JOIN MEQMER ENT ON ENT.MER_AUTEQU = EQUGER.AUTOINCREM AND ENT.MER_TIPOPE = "E" ';
        strSQL := strSQL + '  LEFT JOIN MEQMER SAI ON SAI.MER_AUTEQU = EQUGER.AUTOINCREM AND SAI.MER_TIPOPE = "S" ';
      End;

      strWhere := '';
      if not fCfgSis('MAOSEM', varBoolean) Then
        strWhere := 'WHERE EQU_CODEMP = ' + QuotedStr(VS_strCodEmp) + '  '
      else
        strWhere := 'WHERE TRUE ';

      If Not fEmptyStr(strCodCli) Then
        strWhere := strWhere + ' AND (EQU_CODCLI = ' + QuotedStr(strCodCli) + ') ';

      If Not fEmptyStr(strNum_OS) Then
        strWhere := strWhere + ' AND (EQU_NUMOSE <> ' + QuotedStr(strNum_OS) + ') ';

      If intOpcoes = 1 Then
        strWhere := strWhere + ' AND (NOT (((EQU_STATUS = "R") AND (IF(EQU_SUBSTA = "", "N", IFNULL(EQU_SUBSTA, "N")) IN ("C", "N", "G"))) OR (EQU_STATUS = "N"))) '
      Else If intOpcoes = 2 Then
        strWhere := strWhere + ' AND (((EQU_STATUS = "R") AND (IF(EQU_SUBSTA = "", "N", IFNULL(EQU_SUBSTA, "N")) IN ("C", "N", "G"))) OR (EQU_STATUS = "N")) '
      Else If intOpcoes = 4 Then
        strWhere := strWhere + ' AND (EQU_STATUS IN ("A", "M")) '
      Else If intOpcoes = 5 Then
        strWhere := strWhere + ' AND (EQU_STATUS IN ("A", "M", "R", "N")) ';

      If (blnConsOutrasSaidas) Then Begin
        strWhere := strWhere + ' AND IFNULL(ENT.AUTOINCREM, "") <> "" '; //POSSUI UMA NOTA DE ENTRADA VINCULADA
        strWhere := strWhere + ' AND IFNULL(SAI.AUTOINCREM, "") = "" ';  //NÃO POSSUI UMA NOTA DE SAÍDA VINCULADA
      End;

      If Not Assigned(qryConOrd) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryConOrd;

      If fConsulta([strSQL, strWhere],
                   arrTitCol,
                   ['EQU_NUMOSE','EQU_DESCRI','MAR_DESMAR'],
                   'AUTOINCREM',
                   'EQUGER',
                   Self.Name,
                   strTitulo,
                   qryConsulta,
                   objFrmPnl,
                   blnConSim,
                   arrSel,
                   'AUTOINCREM',
                   objConsulta,
                   False,
                   False,
                   '',
                   Nil,
                   True,
                   True,
                   True,
                   Nil,
                   Nil,
                   Nil,
                   VS_Application) Then
      Begin
        If Assigned(edtNumOrd) then
        Begin
          If (edtNumOrd Is TMaskEditFocus) Then
            (edtNumOrd As TMaskEditFocus).Text := qryConsulta.FieldByName('EQU_NUMOSE').AsString
          Else
            edtNumOrd.Text := qryConsulta.FieldByName('EQU_NUMOSE').AsString;
        End;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtNumOrd) then
          Begin
            If (edtNumOrd Is TMaskEditFocus) Then
              (edtNumOrd As TMaskEditFocus).Text := fStrZero('0', 8)
            Else
              edtNumOrd.Text := fStrZero('0', 8);
          End;

        End;

        If (qryConsulta.FieldByName('EQU_DTAENT').AsDateTime > 0) Then
          dtaNFOS := qryConsulta.FieldByName('EQU_DTAENT').AsDateTime
        Else
          dtaNFOS := 0;

        Result := True;

        If Not Assigned(qryConOrd) Then
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

End;

function fPesqCtaResultado(Self : TForm;                                  {* Formulário                                  *}
                           edtCodCta : TCustomEdit;                       {* Edit do Codigo                              *}
                           edtDesCta : TEditFocus;                        {* Edit da Descrição                           *}
                           qryConCta : TUniQuery;                           {* Query                                       *}
                           Var chrKey: Char;                              {* Key                                         *}
                           Var arrSel: TConsultasArray;                   {* Array de Seleção                            *}
                           blnConSim : Boolean = True;                    {* Consulta Simples ou Múltipla (multi select) *}
                           blnCodCre : Boolean = False;
                           strTitulo : String  = 'Consulta de Contas Resultado'): Boolean;

  Var
    arrTitCol  : TColunasArray;                                           {* Títulos das Colunas                         *}
    strSQL     : String;
    qryConsulta: TUniQuery;

    Procedure pAddNomeColuna(strNomCol: String);
    Begin
      SetLength(arrTitCol, Succ(Length(arrTitCol)));
      arrTitCol[High(arrTitCol)] := strNomCol;
    End;
Begin
  Result := False;

  If fEntraCons(chrKey) Then
  Begin

    chrKey := #0;

    Try

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  CRE_CODCRE, ';  pAddNomeColuna('Código');
      strSQL := strSQL + '  CRE_DESCRE, ';  pAddNomeColuna('Descrição');
      strSQL := strSQL + '  AUTOINCREM  ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CTAGER ';

      If Not Assigned(qryConCta) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryConCta;

      If fConsulta([strSQL],
                   arrTitCol,
                   ['CRE_DESCRE','CRE_CODCRE'],
                   'AUTOINCREM',
                   'CTAGER',
                   Self.Name,
                   strTitulo,
                   qryConsulta,
                   nil,
                   blnConSim,
                   arrSel,
                   IIF(blnCodCre,'CRE_CODCRE','AUTOINCREM'),
                   nil) Then
      Begin
        If Assigned(edtCodCta) then
        Begin
          If (edtCodCta Is TMaskEditFocus) Then
            (edtCodCta As TMaskEditFocus).Text := qryConsulta.FieldByName('CRE_CODCRE').AsString
          Else
            edtCodCta.Text := qryConsulta.FieldByName('CRE_CODCRE').AsString;
        End;

        If Assigned(edtDesCta) Then
          edtDesCta.Text := qryConsulta.FieldByName('CRE_DESCRE').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodCta) then
          Begin
            If (edtCodCta Is TMaskEditFocus) Then
              (edtCodCta As TMaskEditFocus).Text := fStrZero('0', 8)
            Else
              edtCodCta.Text := fStrZero('0', 8);
          End;

          If Assigned(edtDesCta) Then
            edtDesCta.Text := '+1';

        End;

        Result := True;

        If Not Assigned(qryConCta) Then
          FreeAndNil(qryConsulta);
      End;

    Except

      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;

    End;

  End;

End;

{****************************}
{* CONSULTA DE ENDEREÇO CEP *}
{*************************JU*}

function fPesqCEP(Self      : TForm;                                      {* Formulário                                  *}
                  edtCEP    : TCustomEdit;                                {* Edit do CEP                                 *}
                  qryConCEP : TUniQuery;                                    {* Query                                       *}
                  Var chrKey: Char;                                       {* Key                                         *}
                  Var arrSel: TConsultasArray;                            {* Array de Seleção                            *}
                  strId_uf  : String;                                     {* Estado                                      *}
                  strId_cid : String;                                     {* Cidade                                      *}
                  strNomCid : String;                                     {* Nome da Cidade                              *}
                  blnConSim : Boolean = True;                             {* Consulta Simples ou Múltipla (multi select) *}
                  strTitulo : String  = 'Consulta de Endereços'):Boolean;
  Var
    arrTitCol  : TColunasArray;                                           {* Títulos das Colunas                         *}
    strSQL     : String;
    strWhere   : String;
    qryConsulta: TUniQuery;
    objConsulta: TDefConsulta;
    arrOrd     : Array of String;
    blnSeccionamento : Boolean;

    Procedure pAddNomeColuna(strNomCol: String);
    Begin
      SetLength(arrTitCol, Succ(Length(arrTitCol)));
      arrTitCol[High(arrTitCol)] := strNomCol;
    End;

Begin
  Result := False;

  If fEntraCons(chrKey) Then
  Begin

    blnSeccionamento := fCampoExiste('endereco', 'seccionamento', True);

    chrKey := #0;

    Try

      objConsulta := TDefConsulta.Create;
      objConsulta.pIncluiCamposCep(['CEP_']);
      objConsulta.pIncluiSubConsulta('AUTOINCREM', 'endereco.id_endereco');
      objConsulta.pIncluiSubConsulta('ENDERECO_', 'endereco.nome');
      objConsulta.pIncluiSubConsulta('CEP_', 'endereco.cep');
      objConsulta.pIncluiSubConsulta('BAIRRO_', 'bairro.nome');
      If blnSeccionamento Then
        objConsulta.pIncluiSubConsulta('SECCIONAMENTO_', 'endereco.seccionamento');

      strSQL := '';
      strSQL := strSQL + 'SELECT ';

      strSQL := strSQL + '  id_endereco,'; pAddNomeColuna('Código');

      SetLength(arrOrd, 2);

      If fEmptyStr(strId_uf) Then
      Begin
        objConsulta.pIncluiSubConsulta('UF_', 'endereco.id_uf');
        strSQL := strSQL + '  UF_, '; pAddNomeColuna('Estado');

        SetLength(arrOrd, Length(arrOrd) + 1);
        arrOrd[0] := 'UF_';
      End;

      If (fEmptyStr(strId_cid) And fEmptyStr(strNomCid)) Then
      Begin
        objConsulta.pIncluiSubConsulta('CIDADE_', 'cidade.nome');
        strSQL := strSQL + '  CIDADE_, '; pAddNomeColuna('Cidade');

        if Length(arrOrd) = 2 then
        begin
          SetLength(arrOrd, Length(arrOrd) + 1);
          arrOrd[0] := 'CIDADE_';
        end
        else if Length(arrOrd) = 3 then
        begin
          SetLength(arrOrd, Length(arrOrd) + 1);
          arrOrd[0] := 'CIDADE_';
          arrOrd[1] := 'UF_';
        end
      End;

      if Length(arrOrd) = 2 then
      begin
        arrOrd[0] := 'BAIRRO_';
        arrOrd[1] := 'CEP_';
      end
      else if Length(arrOrd) = 3 then
      begin
        arrOrd[1] := 'BAIRRO_';
        arrOrd[2] := 'CEP_';
      end
      else if Length(arrOrd) = 4 then
      begin
        arrOrd[2] := 'BAIRRO_';
        arrOrd[3] := 'CEP_';
      end;

      strSQL := strSQL + '  ENDERECO_, ';   pAddNomeColuna('Endereço');
      strSQL := strSQL + '  CEP_, ';        pAddNomeColuna('CEP');
      strSQL := strSQL + '  BAIRRO_, ';     pAddNomeColuna('Bairro');
      if blnSeccionamento Then
        strSQL := strSQL + '  SECCIONAMENTO_, '; pAddNomeColuna('Seccionamento');
      strSQL := strSQL + '  AUTOINCREM '; ;
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  endereco ';
      strSQL := strSQL + 'INNER JOIN bairro ON endereco.id_bairro = bairro.id_bairro ';
      strSQL := strSQL + 'INNER JOIN cidade ON endereco.id_cidade = cidade.id_cidade ';

      strWhere := '';
      strWhere := strWhere + ' WHERE TRUE ';

      If Not fEmptyStr(strId_uf) Then
        strWhere := strWhere + '  AND endereco.id_uf = ' + QuotedStr(strId_uf) + ' ';

      If Not fEmptyStr(strId_cid) Then
        strWhere := strWhere + '  AND endereco.id_cidade = ' + QuotedStr(strId_cid) + ' ';

      If Not fEmptyStr(strNomCid) Then
        strWhere := strWhere + '  AND cidade.nome = ' + QuotedStr(strNomCid) + ' ';

      If Not Assigned(qryConCEP) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryConCEP;

      If fConsulta([strSQL, strWhere],
                   arrTitCol,
                   arrOrd,
                   'cep_',
                   'endereco',
                   Self.Name,
                   strTitulo,
                   qryConsulta,
                   nil,
                   blnConSim,
                   arrSel,
                   'cep_',
                   objConsulta,
                   False,
                   False,
                   'cep') Then
      Begin
        If Assigned(edtCEP) then
        Begin
          If (edtCEP Is TMaskEditFocus) Then
            (edtCEP As TMaskEditFocus).Text := qryConsulta.FieldByName('CEP').AsString
          Else
            edtCEP.Text := qryConsulta.FieldByName('CEP').AsString;
        End;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCEP) then
          Begin
            If (edtCEP Is TMaskEditFocus) Then
              (edtCEP As TMaskEditFocus).Text := fStrZero('0', 8)
            Else
              edtCEP.Text := fStrZero('0', 8);
          End;

        End;

        Result := True;

        If Not Assigned(qryConCEP) Then
          FreeAndNil(qryConsulta);
      End

      Else Result := False;

      FreeAndNil(objConsulta);

    Except

      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;

    End;

  End;

End;

{**********************************}
{* COSULTA DE CHEQUES DEPOSITADPS *}
{*******************************JU*}
function fPesqCheqDep(Self      : TForm;                                  {* Formulário                                  *}
                      qryCheque : TUniQuery;                                {* Query                                       *}
                      strTabChq : String;                                 {* Tabela de Cheques                           *}
                      blnCanDev : Boolean;                                {* Cancelamento Devolução                      *}
                      Var chrKey: Char;                                   {* Key                                         *}
                      Var arrSel: TConsultasArray;                        {* Array de Seleção                            *}
                      blnConSim : Boolean = True;                         {* Consulta Simples ou Mútipla (multi select)  *}
                      strTitulo : String = 'Consulta de Cheques Depositados'):Boolean;
  Var
    arrTitCol  : TColunasArray;                                           {* Títulos das Colunas                         *}
    strSQL     : String;
    strWhere   : String;
    qryConsulta: TUniQuery;

    Procedure pAddNomeColuna(strNomCol: String);
    Begin
      SetLength(arrTitCol, Succ(Length(arrTitCol)));
      arrTitCol[High(arrTitCol)] := strNomCol;
    End;
Begin
  Result := False;

  If fEntraCons(chrKey) Then
  Begin

    chrKey := #0;

    Try

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  CHQ_CODBCO, ';  pAddNomeColuna('Banco');
      strSQL := strSQL + '  BCO_NOMBCO, ';  pAddNomeColuna('Nome Banco');
      strSQL := strSQL + '  CHQ_NUMAGE, ';  pAddNomeColuna('Agência');
      strSQL := strSQL + '  CHQ_CONCOR, ';  pAddNomeColuna('Cta. Corrente');
      strSQL := strSQL + '  CHQ_NUMCHQ, ';  pAddNomeColuna('Nro. Cheque');
      strSQL := strSQL + '  CHQ_CODCLI, ';  pAddNomeColuna('Cód. Cliente');
      strSQL := strSQL + '  CLI_NOMCLI, ';  pAddNomeColuna('Nome Cliente');
      strSQL := strSQL + '  CHQ_NOMEMI, ';  pAddNomeColuna('Emitente');
      strSQL := strSQL + '  CHQ_DTACAD, ';  pAddNomeColuna('Data Cadastro');
      strSQL := strSQL + '  CHQ_DTAVEN, ';  pAddNomeColuna('Vencimento');
      strSQL := strSQL + '  CHQ_DTADEP, ';  pAddNomeColuna('Data Deposito');
      strSQL := strSQL + '  CHQ_DTADP2, ';  pAddNomeColuna('Data Deposito 2');
      strSQL := strSQL + '  CHQ_VALCHQ, ';  pAddNomeColuna('Valor');
      strSQL := strSQL + '  CHQ_C_G_C_, ';  pAddNomeColuna('CNPJ');
      strSQL := strSQL + '  Q.AUTOINCREM ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + strTabChq + ' Q, ';
      strSQL := strSQL + '  CADCLI C, ';
      strSQL := strSQL + '  CADBCO B ';

      strWhere := strWhere + 'WHERE ';
      strWhere := strWhere + '  Q.CHQ_CODBCO = B.BCO_CODBCO AND ';
      strWhere := strWhere + '  Q.CHQ_CODCLI = C.CLI_CODCLI ';

      if Self.Name = 'frmCancDepChequePreMod2' then
        strWhere := strWhere + ' AND CHQ_DTAREP IS NULL ';

       If blnCanDev Then
        strWhere := strWhere + '  AND (((CHQ_DTADV2 IS NOT NULL) OR ((CHQ_DTADEV IS NOT NULL) AND (CHQ_DTADP2 IS NULL)))) '
      Else
        strWhere := strWhere + '  AND ((CHQ_DTADV2 IS NULL) AND (NOT ((CHQ_DTADEP IS NULL) OR ((CHQ_DTADP2 IS NULL) AND (CHQ_DTADEV IS NOT NULL))))) ';

      If fCfgSis('DACPOR', varBoolean) Then
      Begin
        strWhere := strWhere + '  AND (IFNULL(CHQ_CODPOR, "") = "" ';
        strWhere := strWhere + '  OR LOCATE(CHQ_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
        strWhere := strWhere + '  AND (IFNULL(CHQ_PORCUS, "") = "" ';
        strWhere := strWhere + '  OR LOCATE(CHQ_PORCUS, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
        strWhere := strWhere + '  AND (IFNULL(CHQ_PORDEB, "") = "" ';
        strWhere := strWhere + '  OR LOCATE(CHQ_PORDEB, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
        strWhere := strWhere + '  AND (IFNULL(CHQ_PORCHQ, "") = "" ';
        strWhere := strWhere + '  OR LOCATE(CHQ_PORCHQ, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
      End;

      If Not Assigned(qryCheque) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryCheque;

      If fConsulta([strSQL, strWhere],
                   arrTitCol,
                   ['CHQ_NUMCHQ','BCO_NOMBCO','CHQ_CODBCO','CHQ_NUMAGE','CLI_NOMCLI','CHQ_NOMEMI'],
                   'AUTOINCREM',
                   strTabChq,
                   Self.Name,
                   strTitulo,
                   qryConsulta,
                   nil,
                   blnConSim,
                   arrSel,
                   'AUTOINCREM',
                   nil) Then
      Begin

        Result := True;

        If Not Assigned(qryCheque) Then
          FreeAndNil(qryConsulta);

      End;

    Except

      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;

    End;

  End;

End;

{*************************}
{* CONSULTA DE ROMANEIOS *}
{**********************JU*}
function fPesqRomaneio(Self      : TForm;                                  {* Formulário                                  *}
                       edtNumRom : TCustomEdit;                            {* Edit do Número do Romaneio                  *}
                       qryConRom : TUniQuery;                                {* Query                                       *}
                       Var chrKey: Char;                                   {* Key                                         *}
                       Var arrSel: TConsultasArray;                        {* Array de Seleção                            *}
                       strCadRec : String;                                 {* CADREC ou CADRCXX                           *}
                       blnConSim : Boolean = True;                         {* Consulta Simples ou Múltipla (multi select) *}
                       blnFatRom : Boolean = False;                        {* Se a Chamada é do FatRomaneio ou não        *}
                       strTitulo : String  = 'Consulta de Romaneios'): Boolean;
  Var
    arrTitCol  : TColunasArray;                                           {* Títulos das Colunas                         *}
    strSQL     : String;
    strWhere   : String;
    strGroup   : String;
    strWhereUni: String;
    strGroupUni: String;
    qryConsulta: TUniQuery;
    objConsulta: TDefConsulta;

    Procedure pAddNomeColuna(strNomCol: String);
    Begin
      SetLength(arrTitCol, Succ(Length(arrTitCol)));
      arrTitCol[High(arrTitCol)] := strNomCol;
    End;

Begin
  Result := False;

  If fEntraCons(chrKey) Then
  Begin

    chrKey := #0;

    Try

      objConsulta := TDefConsulta.Create;
      objConsulta.pIncluiSubConsulta('CLIENTE', 'IF( GER_NOMCON IS NULL, CLI_NOMCLI, GER_NOMCON)');
      objConsulta.pIncluiSubConsulta('CIDADE',  'CONCAT(CID_NOMCID, "-", CID_ESTADO)');
      objConsulta.pIncluiSubConsulta('VALOR',   'SUM(GER_VLRCON)');
      objConsulta.pIncluiSubConsulta('STATUS',  'IF(IFNULL(GER_STATUS,"P") = "P", "PENDENTE PARA ATIVAÇÃO", "ATIVADO")');
      objConsulta.pIncluiSubConsulta('BAIXADO', 'IF(IFNULL(GER_DTABAI,0) <> 0, "SIM", "NÃO")');

      strSQL := '';
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '  GER_NUMROM, ';  pAddNomeColuna('Romaneio');
      strSQL := strSQL + '  GER_DTAENT, ';  pAddNomeColuna('Data Romaneio');
      strSQL := strSQL + '  GER_NUMDOC, ';  pAddNomeColuna('Documento');
      strSQL := strSQL + '  GER_ESPDOC, ';  pAddNomeColuna('Especie');
      strSQL := strSQL + '  GER_CODEMP, ';  pAddNomeColuna('Empresa');
      strSQL := strSQL + '  CLIENTE, ';     pAddNomeColuna('Cliente');
      strSQL := strSQL + '  CIDADE, ';      pAddNomeColuna('Cidade');
      strSQL := strSQL + '  GER_CODVEN, ';  pAddNomeColuna('Vendedor');
      strSQL := strSQL + '  VALOR, ';       pAddNomeColuna('Valor');
      strSQL := strSQL + '  STATUS, ';      pAddNomeColuna('Status');
      strSQL := strSQL + '  BAIXADO, ';     pAddNomeColuna('Baixado');
      strSQL := strSQL + '  ROMGERX.AUTOINCREM ';

      If Not blnFatRom Then
      Begin
        strSQL := strSQL + ' FROM ';
        strSQL := strSQL + '  ROMGERX, ';
        strSQL := strSQL + '  CADCLI, ';
        strSQL := strSQL + '  CADCID, ';
        strSQL := strSQL + '  ' + strCadRec + ' ';
      End
      Else
      Begin
        strSQL := strSQL + ' FROM ROMGERX ';
        strSQL := strSQL + ' LEFT JOIN CADCLI ON GER_CODCLI = CLI_CODCLI ';
        strSQL := strSQL + ' LEFT JOIN CADCID ON IF( GER_CIDCON IS NULL, CLI_CODCID, GER_CIDCON) = CID_CODCID ';
      End;

      strGroup := strGroup + 'GROUP BY ';
      strGroup := strGroup + '  GER_NUMDOC, GER_ESPDOC, GER_CODEMP, GER_NUMROM ';

      If Not blnFatRom Then
      Begin
        If strCadRec = 'CADRCXX' then
        Begin
          strWhere := strWhere + ' WHERE ';
          strWhere := strWhere + '  GER_CODCLI = CLI_CODCLI AND ';
          strWhere := strWhere + '  IF( GER_CIDCON IS NULL, CLI_CODCID, GER_CIDCON) = CID_CODCID ';
          strWhere := strWhere + '  AND GER_NUMROM = RCX_NUMROM ';
          strWhere := strWhere + '  AND GER_EMPROM = ' + QuotedStr(VS_strCodEmp) + ' ';
          strWhere := strWhere + '  AND RCX_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';

          strWhereUni := '';
          strGroupUni := '';
        End
        Else
        Begin
          strWhere := strWhere + ' WHERE ';
          strWhere := strWhere + '  GER_EMPROM = ' + VS_strCodEmp + ' AND ';
          strWhere := strWhere + '  GER_CODCLI = CLI_CODCLI AND ';
          strWhere := strWhere + '  IF( GER_CIDCON IS NULL, CLI_CODCID, GER_CIDCON) = CID_CODCID ';
          strWhere := strWhere + '  AND CTR_NUMDUP = GER_NUMDOC ';
          strWhere := strWhere + '  AND CTR_DTAREC IS NULL ';

          strWhereUni := '';
          strGroupUni := '';
        End;
      End
      Else
      Begin
        strWhere := strWhere + 'WHERE ';
        strWhere := strWhere + '  GER_EMPROM = ' + QuotedStr(VS_strCodEmp) + ' ';
      End;

      If Not fEmptyStr(edtNumRom.Text) then
        strWhere := strWhere + '  AND GER_NUMROM = "' + edtNumRom.Text + '"';

      If Not Assigned(qryConRom) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryConRom;

      If fConsulta([strSQL, strWhere, strGroup, '', strWhereUni, strGroupUni],
                   arrTitCol,
                   ['GER_NUMROM','GER_DTAENT','CLIENTE'],
                   'AUTOINCREM',
                   'ROMGERX',
                   Self.Name,
                   strTitulo,
                   qryConsulta,
                   nil,
                   blnConSim,
                   arrSel,
                   'AUTOINCREM',
                   objConsulta) Then
      Begin
        If Assigned(edtNumRom) then
        Begin
          If (edtNumRom Is TMaskEditFocus) Then
            (edtNumRom As TMaskEditFocus).Text := qryConsulta.FieldByName('GER_NUMROM').AsString
          Else
            edtNumRom.Text := qryConsulta.FieldByName('GER_NUMROM').AsString;
        End;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtNumRom) then
          Begin
            If (edtNumRom Is TMaskEditFocus) Then
              (edtNumRom As TMaskEditFocus).Text := fStrZero('0', 8)
            Else
              edtNumRom.Text := fStrZero('0', 8);
          End;

        End;

        Result := True;
      End;

      If Not Assigned(qryConRom) Then
        FreeAndNil(qryConsulta);

      FreeAndNil(objConsulta);
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[untConsultas.fPesqRomaneio]');
    End;
  End;
End;

{******************************}
{* CONSULTA DE CONTAS A PAGAR *}
{***************************JU*}
function fPesqCtaPagar(Self      : TForm;                                  {* Formulário                                  *}
                       edtCodCtp : TCustomEdit;                            {* Edit do Número do Romaneio                  *}
                       qryConCtp : TUniQuery;                                {* Query                                       *}
                       Var chrKey: Char;                                   {* Key                                         *}
                       Var arrSel: TConsultasArray;                        {* Array de Seleção                            *}
                       intOpcao  : Integer;                                {* Abertos, Baixados ou Todos                  *}
                       blnConSim : Boolean = True;                         {* Consulta Simples ou Múltipla (multi select) *}
                       strTitulo : String  = 'Consulta Contas Pagar'): Boolean;
  Var
    arrTitCol  : TColunasArray;                                           {* Títulos das Colunas                         *}
    strSQL     : String;
    strWhere   : String;
    qryConsulta: TUniQuery;
    objConsulta: TDefConsulta;

    Procedure pAddNomeColuna(strNomCol: String);
    Begin
      SetLength(arrTitCol, Succ(Length(arrTitCol)));
      arrTitCol[High(arrTitCol)] := strNomCol;
    End;

Begin
  Result := False;

  If fEntraCons(chrKey) Then
  Begin

    chrKey := #0;

    Try

      objConsulta := TDefConsulta.Create;
      objConsulta.pIncluiSubConsulta('CTP_JURSUJ', 'IFNULL(CTP_JURSUJ,0)');
      objConsulta.pIncluiSubConsulta('CTP_VENDOR', 'IFNULL(CTP_VENDOR,0)');
      objConsulta.pIncluiSubConsulta('CTP_DESSUJ', 'IFNULL(CTP_DESSUJ,0)');
      objConsulta.pIncluiSubConsulta('CTP_USACHQ', 'IFNULL(CTP_USACHQ,"N")');
      objConsulta.pIncluiSubConsulta('CTP_DEPOSI', 'IFNULL(CTP_DEPOSI,"N")');
      objConsulta.pIncluiSubConsulta('CTP_HIST01', 'CAST(IFNULL(REPLACE(CTP_HIST01, "<<csq>>" , " "), " ") AS CHAR(255))');
      // objConsulta.pIncluiSubConsulta('CTP_HIST01', 'CAST(CTP_HIST01 AS CHAR(100))');
      objConsulta.pIncluiSubConsulta('EVENTO',     'EVE_DESEVE');
      objConsulta.pIncluiSubConsulta('PORTADOR','CTP_CODPOR');


      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  CTP_NUMDUP, ';  pAddNomeColuna('Duplicata');
      strSQL := strSQL + '  CTP_PARCEL, ';  pAddNomeColuna('Parcela');
      strSQL := strSQL + '  CTP_CODEMP, ';  pAddNomeColuna('Empresa');
      strSQL := strSQL + '  CTP_SEQBAI, ';  pAddNomeColuna('Seq. Baixa');
      strSQL := strSQL + '  CTP_SERIE_, ';  pAddNomeColuna('Serie');
      strSQL := strSQL + '  FOR_NOMFOR, ';  pAddNomeColuna('Fornecedor');
      strSQL := strSQL + '  FOR_C_G_C_, ';  pAddNomeColuna('CPF/CNPJ');
      strSQL := strSQL + '  FOR_NOMFAN, ';  pAddNomeColuna('Nome Fantasia');
      strSQL := strSQL + '  CTP_DTACAD, ';  pAddNomeColuna('Data de Cadastro');
//
      strSQL := strSQL + '  FIS_DTADOC, ';  pAddNomeColuna('Data do Documento');
//
      strSQL := strSQL + '  CTP_CODFOR, ';  pAddNomeColuna('Cód. Fornecedor');
      strSQL := strSQL + '  CTP_DTAVEN, ';  pAddNomeColuna('Vencimento');
      strSQL := strSQL + '  CTP_VALDUP, ';  pAddNomeColuna('Valor Duplicata');
      strSQL := strSQL + '  CTP_VALORI, ';  pAddNomeColuna('Valor Original');
      strSQL := strSQL + '  CTP_JURSUJ, ';  pAddNomeColuna('Juros');
      If fCfgSis('CTPVND', varBoolean) Then
      Begin
        strSQL := strSQL + '  CTP_VENDOR, ';
        pAddNomeColuna('Vendor');
      End;
      strSQL := strSQL + '  CTP_DESSUJ, ';  pAddNomeColuna('Desconto');
      strSQL := strSQL + '  CTP_CODCTA, ';  pAddNomeColuna('Pl. Contas');
      strSQL := strSQL + '  CTP_VEIOBO, ';  pAddNomeColuna('Veio Boleto?');
      strSQL := strSQL + '  CTP_VEIONF, ';  pAddNomeColuna('Veio Nota Fiscal?');
      strSQL := strSQL + '  CTP_USACHQ, ';  pAddNomeColuna('Cheque?');
      strSQL := strSQL + '  CTP_PREVIS, ';  pAddNomeColuna('Previsão?');
      strSQL := strSQL + '  CTP_DEPOSI, ';  pAddNomeColuna('Depósito?');
      strSQL := strSQL + '  CTP_HIST01, ';  pAddNomeColuna('Histórico 1');
      strSQL := strSQL + '  CTP_HIST02, ';  pAddNomeColuna('Histórico 2');
      strSQL := strSQL + '  CTP_CODVEL, ';  pAddNomeColuna('Documento Antigo');
      strSQL := strSQL + '  CTP_CODVEN, ';  pAddNomeColuna('Operador');
      strSQL := strSQL + '  CTP_OPEBAI, ';  pAddNomeColuna('Operador Baixa');
      strSQL := strSQL + '  CTP_CODEVE, ';  pAddNomeColuna('Código Centro de Custo');
      strSQL := strSQL + '  EVENTO,     ';  pAddNomeColuna('Centro de Custo');
      strSQL := strSQL + '  CTP_CODPOR, ';  pAddNomeColuna('Portador');
      strSQL := strSQL + '  FOR_CGCCPF, ';
      strSQL := strSQL + '  CADPAG.AUTOINCREM ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADPAG ';
      strSQL := strSQL + '  JOIN CADFOR ON CTP_CODFOR = FOR_CODFOR ';
      {**************************** **************************************}
      {* VISUALIZA APENAS CENTRO DE CUSTOS DO TIPO P-PAGAR OU G-GERAL    *}
      {****************************************************************CH*}
      strSQL := strSQL + '  LEFT JOIN CADEVE ON CTP_CODEVE = EVE_CODEVE '+
                           '  AND EVE_TIPEVE IN (''P'',''G'') ';

      strSQL := strSQL + '  LEFT JOIN CADFIS ON CADPAG.CTP_NUMDOC = CADFIS.FIS_NUMDOC '+
                         '             AND CADPAG.CTP_CODEMP = CADFIS.FIS_CODEMP '+
                         '             AND CADPAG.CTP_CODFOR = CADFIS.FIS_FORCLI '+
                         '             AND CADPAG.CTP_DTACAD = CADFIS.FIS_DTAENT '+
                         '             AND CADPAG.CTP_SERIE_ = CADFIS.FIS_SERIE_ '+
                         '             AND CADFIS.FIS_ESPDOC = ''NF'' '+
                         '             AND CADFIS.FIS_ENTSAI = ''E''  ';

      strWhere := strWhere + 'WHERE ';
      strWhere := strWhere + '  TRUE ';

      If intOpcao = 2 Then
      Begin
        strWhere := strWhere + '  AND CTP_DTAPAG IS NOT NULL ';
      End
      Else
      If intOpcao = 3 Then
      Begin
        strWhere := strWhere + '  AND CTP_DTAPAG IS NULL ';
      End;

      {**********************************************************************}
      {* VISUALIZA APENAS DUPLICATAS DE EMPRESAS QUE O USUÁRIO TENHA ACESSO *}
      {*******************************************************************JU*}
      strWhere := strWhere + '  AND CTP_CODEMP IN (' + fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + ') ';
      {***********************************************************************}
      {* MESMA LÓGICA DA EMPRESA PARA O PORTADOR QUANDO UTILIZAR ACONFIRAÇÃO *}
      {********************************************************************JU*}
      If fCfgSis('DACPOR', varBoolean) Then
      Begin
        strWhere := strWhere + '  AND (IFNULL(CTP_CODPOR, "") = "" ';
        strWhere := strWhere + '  OR CTP_CODPOR IN (' + IIF(strPortadoresOperador.IsEmpty, '""',  fStringSQLLocateToStringSQLIN(strPortadoresOperador)) + ')) ';
        strWhere := strWhere + '  AND (IFNULL(CTP_PORBAI, "") = "" ';
        strWhere := strWhere + '  OR CTP_PORBAI IN (' + IIF(strPortadoresOperador.IsEmpty, '""',  fStringSQLLocateToStringSQLIN(strPortadoresOperador)) + ')) ';
      End;

      If Not Assigned(qryConCtp) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryConCtp;

      If fConsulta([strSQL, strWhere],
                   arrTitCol,
                   ['CTP_NUMDUP','FOR_NOMFOR','FOR_NOMFAN','CTP_CODFOR'],
                   'AUTOINCREM',
                   'CADPAG',
                   Self.Name,
                   strTitulo,
                   qryConsulta,
                   nil,
                   blnConSim,
                   arrSel,
                   'AUTOINCREM',
                   objConsulta) Then
      Begin
        If Assigned(edtCodCtp) then
        Begin
          If (edtCodCtp Is TMaskEditFocus) Then
            (edtCodCtp As TMaskEditFocus).Text := qryConsulta.FieldByName('CTP_NUMDUP').AsString
          Else
            edtCodCtp.Text := qryConsulta.FieldByName('CTP_NUMDUP').AsString;
        End;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodCtp) then
          Begin
            If (edtCodCtp Is TMaskEditFocus) Then
              (edtCodCtp As TMaskEditFocus).Text := fStrZero('0', 12)
            Else
              edtCodCtp.Text := fStrZero('0', 12);
          End;

        End;

        Result := True;

        If Not Assigned(qryConCtp) Then
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

End;

function fSqlfPesqIteDev(strNomTab, strOpcDoc, strIteSer, strSerTer: String; blnUsaSer: Boolean): TConsIteDev;

  Procedure pAddNomeColuna(strNomCol: String);
  Begin
    With Result Do
    Begin
      SetLength(arrTitCol, Succ(Length(arrTitCol)));
      arrTitCol[High(arrTitCol)] := strNomCol;
    End;
  End;

Begin

  With Result Do
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT DISTINCT ';
    strSQL := strSQL + '  DET_NUMDOC, ';   pAddNomeColuna('Documento');
    strSQL := strSQL + '  DET_ESPDOC, ';   pAddNomeColuna('Espécie');
    strSQL := strSQL + '  DET_CODEMP, ';   pAddNomeColuna('Empresa');

    If Pos(strOpcDoc,'DV_PR') > 0 Then
    Begin
      strSQL := strSQL + '  DET_VENDED, '; pAddNomeColuna('Vendedor');
      strSQL := strSQL + '  ITE_CODBAR, '; pAddNomeColuna('Cód. Barra');
    End
    Else
    Begin
      strSQL := strSQL + '  DET_VENDED, '; pAddNomeColuna('Comprador');
    End;

    strSQL := strSQL + '  DET_DTAENT, '; pAddNomeColuna('Data Entrada');
    strSQL := strSQL + '  DET_CODGRU, '; pAddNomeColuna('Grupo');
    strSQL := strSQL + '  DET_CODITE, '; pAddNomeColuna('Cód. Item');
    strSQL := strSQL + '  DET_DESCRI, '; pAddNomeColuna('Descrição');
    strSQL := strSQL + '  DET_REFERE, '; pAddNomeColuna('Referência');
    strSQL := strSQL + '  UNI_SIGUNI, '; pAddNomeColuna('Unidade');
    strSQL := strSQL + '  MAR_DESMAR, '; pAddNomeColuna('Marca');
    strSQL := strSQL + '  DET_NUMLOT, '; pAddNomeColuna(VS_strTitLot);
    strSQL := strSQL + '  FIS_NUMCOO, '; pAddNomeColuna('Num. COO');
    strSQL := strSQL + '  AUX_VENPRE, '; pAddNomeColuna('Venda Presencial?');
    strSQL := strSQL + '  DET_SEQCOM, '; pAddNomeColuna('Sequencial Combo');

    //Req. 116337
    strSQL := strSQL + '  ITE_CODFAB, '; pAddNomeColuna('Cód. Fabrica');
    strSQL := strSQL + '  ITE_APLICA, '; pAddNomeColuna('Aplicação');
    strSQL := strSQL + '  ITE_BARRAS, '; pAddNomeColuna('Cód. Barra do Item');
    strSQL := strSQL + '  ITE_BAREMB, '; pAddNomeColuna('Cód. Barra Embalagem');
    strSQL := strSQL + '  ITE_DESFAB, '; pAddNomeColuna('Des. Fábrica');
    strSQL := strSQL + '  ITE_CODFOR, '; pAddNomeColuna('Cód. Fornecedor');
    strSQL := strSQL + '  ITE_DTAALT, '; pAddNomeColuna('Última Alteração');
    strSQL := strSQL + '  ITE_EMBALA, '; pAddNomeColuna('Embalagem de Compra');
    strSQL := strSQL + '  ITE_CLAIPI, '; pAddNomeColuna('Cód. NCM');
    strSQL := strSQL + '  IF(ITE_ITEATI = "S", "ATIVO", "INATIVO"), '; pAddNomeColuna('Status');
    strSQL := strSQL + '  IF(ITE_ATICOM = "S", "ATIVO", "INATIVO"), '; pAddNomeColuna('Ativo p/Compra');
    strSQL := strSQL + '  ITE_DIAFOR, '; pAddNomeColuna('Dias para entrega do Fornecedor');
    strSQL := strSQL + '  ITE_CDCEST, '; pAddNomeColuna('Classificação CEST');
    strSQL := strSQL + '  ITE_TMPGAR, '; pAddNomeColuna('Tempo de Garantia');
    strSQL := strSQL + '  ITE_DESSIM, '; pAddNomeColuna('Descrição Simplificada');
    strSQL := strSQL + '  ITE_PESQUI, '; pAddNomeColuna('Descrição Livre');
    strSQL := strSQL + '  ITE_MLTCOM, '; pAddNomeColuna('Múlt. Compra');
    strSQL := strSQL + '  ITE_MLTVEN, '; pAddNomeColuna('Múlt. Venda');
    strSQL := strSQL + '  ITE_PESOIT, '; pAddNomeColuna('Pes. Bruto');
    strSQL := strSQL + '  ITE_PESLIQ, '; pAddNomeColuna('Pes. Líquido');

    if fCfgSis('NUMSER', varBoolean) then
    begin
      strSQL := strSQL + '(SELECT GROUP_CONCAT(S.SER_NUMSER) FROM DETSER S WHERE S.SER_SEQGER = DET_AUTOIN) AS NUMSER, '; pAddNomeColuna('Número de Série');
    end;

    //Fim

    strSQL := strSQL + '  DET_QTDITE, ';
    strSQL := strSQL + '  DET_QTDPEC, ';
    strSQL := strSQL + '  DET_COMPEC, ';
    strSQL := strSQL + '  DET_LARPEC, ';
    strSQL := strSQL + '  DET_ESPPEC, ';
    strSQL := strSQL + '  DET_APAREL, ';
    strSQL := strSQL + '  DET_PERAPA, ';
    strSQL := strSQL + '  DET_BENEFI, ';
    strSQL := strSQL + '  DET_PERBEN, ';
    strSQL := strSQL + '  DET_VAL_RT, ';
    strSQL := strSQL + '  DET_UNITAR, ';
    strSQL := strSQL + '  DET_UNIORI, ';
    strSQL := strSQL + '  DET_UNIVIS, ';
    strSQL := strSQL + '  DET_TOTITE, ';
    strSQL := strSQL + '  DET_TOTCUS, ';
    strSQL := strSQL + '  DET_TOTCU2, ';
    strSQL := strSQL + '  DET_PRECU2, ';
    strSQL := strSQL + '  DET_PRECUS, ';
    strSQL := strSQL + '  DET_IDEPRO, ';
    strSQL := strSQL + '  DET_EMPACA, ';
    strSQL := strSQL + '  DET_CODACA, ';
    strSQL := strSQL + '  DET_SEQGER, ';
    strSQL := strSQL + '  DET_TABELA, ';
    strSQL := strSQL + '  DET_ITEEMB, ';
    strSQL := strSQL + '  DET_TIPEMB, ';
    strSQL := strSQL + '  DET_QTDEMB, ';
    strSQL := strSQL + '  DET_CODVEN, ';
    strSQL := strSQL + '  DET_CLAFIS, ';
    strSQL := strSQL + '  DET_AUTOIN, ';
    strSQL := strSQL + ' ' + strNomTab + '.AUTOINCREM ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + strNomTab + ' ';
    strSQL := strSQL + '  JOIN CADMAR ON DET_CODMAR = MAR_CODMAR ';
    strSQL := strSQL + '  JOIN CADUNI ON DET_UNIDAD = UNI_CODUNI ';

    // lista código de barra  **RL**
    strSQL := strSQL + 'INNER JOIN CADITE ON ITE_CODITE = DET_CODITE';

    strSQL := strSQL + ' LEFT JOIN CADFIS ON ';
    strSQL := strSQL + '  FIS_NUMDOC = DET_NUMDOC AND ';
    strSQL := strSQL + '  FIS_ESPDOC = DET_ESPDOC AND ';
    strSQL := strSQL + '  FIS_CODEMP = DET_CODEMP AND ';
    strSQL := strSQL + '  FIS_TIP_FC = DET_TIP_FC AND ';
    strSQL := strSQL + '  IFNULL(FIS_SERIE_, "") = IFNULL(DET_SERIE_, "") ';

    strWhere := strWhere + 'WHERE ';

    strWhere := strWhere + '  DET_NOTESP <> "S"       AND ';
    strWhere := strWhere + '  DET_ESPDOC <> "DV"      AND ';
    //strWhere := strWhere + '  DET_CODMAR = MAR_CODMAR AND ';
    strWhere := strWhere + ' ((LOCATE(DET_CLAFIS, ' + QuotedStr(VS_strClaDev) + ') <= 0) '+IIF(strOpcDoc='OF','OR (AUX_OPCDOC = "FE")','')+') AND ';
    //strWhere := strWhere + '  DET_UNIDAD = UNI_CODUNI AND ';

    If Pos(strOpcDoc,'DV_PR') > 0 Then
      strWhere := strWhere + '  DET_TIP_FC = "C" '
    Else
      strWhere := strWhere + '  DET_TIP_FC = "F" ';

    If blnUsaSer Then
    Begin
      strWhere := strWhere + '  AND DET_CODITE <> ' + QuotedStr(strIteSer) + ' ';
      strWhere := strWhere + '  AND DET_CODITE <> ' + QuotedStr(strSerTer) + ' ';
    End;
  End;

  Result.strSQLAndWhere := Result.strSQL + Result.strWhere;
End;

function fSqlfPesqIteDevEsp(strNomTab, strOpcDoc, strIteSer, strSerTer: String; blnUsaSer: Boolean): TConsIteDev;

  Procedure pAddNomeColuna(strNomCol: String);
  Begin
    With Result Do
    Begin
      SetLength(arrTitCol, Succ(Length(arrTitCol)));
      arrTitCol[High(arrTitCol)] := strNomCol;
    End;
  End;

Begin

  With Result Do
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  DET_CODITE, ';   pAddNomeColuna('Cód. Item');
    strSQL := strSQL + '  DET_DESCRI, ';   pAddNomeColuna('Descrição');
    strSQL := strSQL + '  DET_REFERE, ';   pAddNomeColuna('Referência');
    strSQL := strSQL + '  ITE_CODBAR, ';   pAddNomeColuna('Cód. Barra');
    strSQL := strSQL + '  UNI_SIGUNI, ';   pAddNomeColuna('Unidade');
    strSQL := strSQL + '  MAR_DESMAR, ';   pAddNomeColuna('Marca');
    strSQL := strSQL + '  DET_CODGRU, ';   pAddNomeColuna('Grupo');
    strSQL := strSQL + '  DET_DTAENT, ';   pAddNomeColuna('Data da Venda');
    strSQL := strSQL + '  DET_HORENT, ';   pAddNomeColuna('Hora da Venda');
    strSQL := strSQL + '  DET_NUMDOC, ';   pAddNomeColuna('Documento');
    strSQL := strSQL + '  DET_ESPDOC, ';   pAddNomeColuna('Espécie');
    strSQL := strSQL + '  DET_CODEMP, ';   pAddNomeColuna('Empresa');
    strSQL := strSQL + '  DET_QTDITE, ';
    strSQL := strSQL + '  DET_QTDPEC, ';
    strSQL := strSQL + '  DET_COMPEC, ';
    strSQL := strSQL + '  DET_LARPEC, ';
    strSQL := strSQL + '  DET_ESPPEC, ';
    strSQL := strSQL + '  DET_APAREL, ';
    strSQL := strSQL + '  DET_PERAPA, ';
    strSQL := strSQL + '  DET_BENEFI, ';
    strSQL := strSQL + '  DET_PERBEN, ';
    strSQL := strSQL + '  DET_VAL_RT, ';
    strSQL := strSQL + '  DET_UNITAR, ';
    strSQL := strSQL + '  DET_UNIORI, ';
    strSQL := strSQL + '  DET_UNIVIS, ';
    strSQL := strSQL + '  DET_TOTITE, ';
    strSQL := strSQL + '  DET_TOTCUS, ';
    strSQL := strSQL + '  DET_TOTCU2, ';
    strSQL := strSQL + '  DET_PRECU2, ';
    strSQL := strSQL + '  DET_PRECUS, ';
    strSQL := strSQL + '  DET_IDEPRO, ';
    strSQL := strSQL + '  DET_EMPACA, ';
    strSQL := strSQL + '  DET_CODACA, ';
    strSQL := strSQL + '  DET_SEQGER, ';
    strSQL := strSQL + '  DET_TABELA, ';
    strSQL := strSQL + '  DET_ITEEMB, ';
    strSQL := strSQL + '  DET_TIPEMB, ';
    strSQL := strSQL + '  DET_QTDEMB, ';
    strSQL := strSQL + '  DET_CODVEN, ';
    strSQL := strSQL + '  DET_CLAFIS, ';
    strSQL := strSQL + '  DET_AUTOIN, ';
    strSQL := strSQL + ' ' + strNomTab + '.AUTOINCREM ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + strNomTab + ' ';
    strSQL := strSQL + '  JOIN CADMAR ON DET_CODMAR = MAR_CODMAR ';
    strSQL := strSQL + '  JOIN CADUNI ON DET_UNIDAD = UNI_CODUNI ';

    // lista código de barra  **RL**
    strSQL := strSQL + 'INNER JOIN CADITE ON ITE_CODITE = DET_CODITE';

    strSQL := strSQL + ' LEFT JOIN CADFIS ON ';
    strSQL := strSQL + '  FIS_NUMDOC = DET_NUMDOC AND ';
    strSQL := strSQL + '  FIS_ESPDOC = DET_ESPDOC AND ';
    strSQL := strSQL + '  FIS_CODEMP = DET_CODEMP AND ';
    strSQL := strSQL + '  FIS_TIP_FC = DET_TIP_FC AND ';
    strSQL := strSQL + '  IFNULL(FIS_SERIE_, "") = IFNULL(DET_SERIE_, "") ';

    strWhere := strWhere + 'WHERE ';

    strWhere := strWhere + '  DET_NOTESP <> "S"      AND ';
    strWhere := strWhere + '  DET_ESPDOC = "NF"      AND ';
    strWhere := strWhere + ' (LOCATE(DET_CLAFIS, ' + QuotedStr(VS_strClaDev) + ') <= 0) AND ';
    strWhere := strWhere + '  DET_TIP_FC = "C" ';

    If blnUsaSer Then
    Begin
      strWhere := strWhere + '  AND DET_CODITE <> ' + QuotedStr(strIteSer) + ' ';
      strWhere := strWhere + '  AND DET_CODITE <> ' + QuotedStr(strSerTer) + ' ';
    End;
  End;

  Result.strSQLAndWhere := Result.strSQL + Result.strWhere;
End;

{************************************}
{* CONSULTA DE ITENS PARA DEVOLUÇÃO *}
{*********************************JU*}
function fPesqIteDev(Self         : TForm;                                 {* Formulário                                  *}
                     qryConIteDev : TUniQuery;                               {* Query                                       *}
                     Var chrKey   : char;                                  {* Key                                         *}
                     Var arrSel   : TConsultasArray;                       {* Array de Seleção                            *}
                     strNomTab    : String;                                {* Nome da Tabela                              *}
                     strOpcDoc    : String;                                {* Vendedor ou Comprador                       *}
                     strIteSer    : String;                                {* Item Serviço                                *}
                     strSerTer    : String;                                {* Item Serviço - Terceirizado                 *}
                     blnUsaSer    : Boolean;                               {* Usa Serviço                                 *}
                     blnConSim    : Boolean = True;                        {* Consulta Simples ou Múltipla (multi select) *}
                     objFrmPnl    : TPanelCx = Nil;                        {* Painel                                      *}
                     strTitulo    : String  = 'Consulta de Itens para Devolução';
                     blnDevEsp    : Boolean = False): Boolean;
  Var
    qryConsulta: TUniQuery;
    objConsulta: TDefConsulta;
    recConsIteDev: TConsIteDev;
    arrOrdenacao: Array Of String;
Begin
  Result := False;

  If fEntraCons(chrKey) Then
  Begin

    chrKey := #0;

    Try

      objConsulta := TDefConsulta.Create;
      objConsulta.pFormataDecimal('DET_QTDITE', fCfgSis('DECQTD', varInteger));

      If blnDevEsp Then
      Begin
        strTitulo     := 'Consulta de Itens para Devolução Especial';
        recConsIteDev := fSqlfPesqIteDevEsp(strNomTab, strOpcDoc, strIteSer, strSerTer, blnUsaSer);
        arrOrdenacao  := ['DET_DTAENT','DET_HORENT','DET_CODITE'];
      End
      Else
      Begin
        recConsIteDev := fSqlfPesqIteDev(strNomTab, strOpcDoc, strIteSer, strSerTer, blnUsaSer);
        arrOrdenacao  := ['DET_NUMDOC','DET_DESCRI','DET_CODGRU','DET_CODITE'];
      End;

      objConsulta.pIncluiCampoSimNao('AUX_VENPRE');

      If Not Assigned(qryConIteDev) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryConIteDev;

      If fConsulta([recConsIteDev.strSQL, recConsIteDev.strWhere],
                   recConsIteDev.arrTitCol,
                   arrOrdenacao,
                   'AUTOINCREM',
                   strNomTab,
                   Self.Name,
                   strTitulo,
                   qryConsulta,
                   objFrmPnl,
                   blnConSim,
                   arrSel,
                   'AUTOINCREM',
                   objConsulta,
                   False,
                   False,
                   '',
                   Nil,
                   True,
                   True,
                   True,
                   Nil,
                   Nil,
                   Nil,
                   VS_Application) Then
      Begin

        Result := True;

        If Not Assigned(qryConIteDev) Then
          FreeAndNil(qryConsulta);

      End;

    Except

      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;

    End;

    FreeAndNil(objConsulta);

  End;

End;

{***********************}
{* CONSULTA DE CHEQUES *}
{********************JU*}
function fPesqCheques(Self      : TForm;                                    {* Formulário                                  *}
                      qryConChq : TUniQuery;                                  {* Query                                       *}
                      Var chrKey: Char;                                     {* Key                                         *}
                      Var arrSel: TConsultasArray;                          {* Array de Seleção                            *}
                      strNomTab : String;                                   {* Nome da Tabela                              *}
                      intOpcao  : Integer;                                  {* Baixados ou Abertos                         *}
                      blnConSim : Boolean = True;                           {* Consulta Simples ou Múltipla (multi select) *}
                      strTitulo : String  = 'Consulta de Cheques'): Boolean;
  Var
    arrTitCol  : TColunasArray;                                           {* Títulos das Colunas                         *}
    strSQL     : String;
    strWhere   : String;
    qryConsulta: TUniQuery;
    objConsulta: TDefConsulta;

    Procedure pAddNomeColuna(strNomCol: String);
    Begin
      SetLength(arrTitCol, Succ(Length(arrTitCol)));
      arrTitCol[High(arrTitCol)] := strNomCol;
    End;

Begin
  Result := False;

  If fEntraCons(chrKey) Then
  Begin

    chrKey := #0;

    Try

      objConsulta := TDefMascaraCheque.Create;
      objConsulta.pIncluiSubConsulta('DEPOSITO', 'CAST(IF(Q.CHQ_DTADP2 IS NULL, Q.CHQ_DTADEP, Q.CHQ_DTADP2) AS DATE)');
      objConsulta.pIncluiSubConsulta('DOCUMENTO', 'IF( LOCATE("DIVERSOS",CHQ_DOCUME), '+
                                                  '    CHQ_DOCUME, ' +

                                                  '  IF(LOCATE("AG", CHQ_DOCUME), ' +
                                                  '     CONCAT( SUBSTRING(CHQ_DOCUME,1,LOCATE("AG", CHQ_DOCUME) -1), "-", ' +
                                                  '             "AG", "-", SUBSTRING(CHQ_DOCUME,LOCATE("AG", CHQ_DOCUME) + 2, 3), "-", ' +
                                                  '                        SUBSTRING(CHQ_DOCUME,LOCATE("AG", CHQ_DOCUME) + 5,3)),' +

                                                  '    IF(LENGTH(CHQ_DOCUME)=20, '+
                                                  '       CONCAT( SUBSTRING(CHQ_DOCUME,1,12), "-", SUBSTRING(CHQ_DOCUME,13,2), "-", SUBSTRING(CHQ_DOCUME,15,3), "-", SUBSTRING(CHQ_DOCUME,18,3)),  '+
                                                  '       CONCAT( SUBSTRING(CHQ_DOCUME,1,13), "-", SUBSTRING(CHQ_DOCUME,14,2), "-", SUBSTRING(CHQ_DOCUME,16,3), "-", SUBSTRING(CHQ_DOCUME,19,3)))))');
      objConsulta.pIncluiSubConsulta('DIGITADOR', 'CONCAT(Q.CHQ_CODOPE, "-", O.OPE_NOMOPE)');


      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  CHQ_CODBCO, ';  pAddNomeColuna('Banco');
      strSQL := strSQL + '  BCO_NOMBCO, ';  pAddNomeColuna('Nome Banco');
      strSQL := strSQL + '  CHQ_NUMAGE, ';  pAddNomeColuna('Agência');
      strSQL := strSQL + '  CHQ_CONCOR, ';  pAddNomeColuna('Cta. Corrente');
      strSQL := strSQL + '  CHQ_NUMCHQ, ';  pAddNomeColuna('Nro. Cheque');
      strSQL := strSQL + '  CHQ_CODCLI, ';  pAddNomeColuna('Cód. Cliente');
      strSQL := strSQL + '  CLI_NOMCLI, ';  pAddNomeColuna('Nome Cliente');
      strSQL := strSQL + '  CHQ_NOMEMI, ';  pAddNomeColuna('Emitente');
      strSQL := strSQL + '  CHQ_DTACAD, ';  pAddNomeColuna('Data Cadastro');
      strSQL := strSQL + '  CHQ_DTAVEN, ';  pAddNomeColuna('Vencimento');
      strSQL := strSQL + '  DEPOSITO, ';    pAddNomeColuna('Data Deposito');
      strSQL := strSQL + '  CHQ_VALCHQ, ';  pAddNomeColuna('Valor');
      strSQL := strSQL + '  CHQ_C_G_C_, ';  pAddNomeColuna('CNPJ');
      strSQL := strSQL + '  DOCUMENTO,  ';  pAddNomeColuna('Documento');
      strSQL := strSQL + '  DIGITADOR,  ';  pAddNomeColuna('Digitador');
      strSQL := strSQL + '  CHQ_CODEMP, ';  pAddNomeColuna('Emp.');
      strSQL := strSQL + '  CHQ_CGCCPF, ';
      strSQL := strSQL + '  Q.AUTOINCREM ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + strNomTab + ' Q ';
      strSQL := strSQL + '  JOIN CADCLI C ON Q.CHQ_CODCLI = C.CLI_CODCLI ';
      strSQL := strSQL + '  JOIN CADBCO B ON Q.CHQ_CODBCO = B.BCO_CODBCO ';
      strSQL := strSQL + '  LEFT JOIN CADOPE O ON O.OPE_CODOPE = Q.CHQ_CODOPE ';

      strWhere := strWhere + 'WHERE TRUE ';
      //strWhere := strWhere + '  Q.CHQ_CODBCO = B.BCO_CODBCO AND ';
      //strWhere := strWhere + '  Q.CHQ_CODCLI = C.CLI_CODCLI ';

      If intOpcao = 2 Then
      Begin
        strWhere := strWhere + ' AND (';
        strWhere := strWhere + '      (Q.CHQ_DTADEP IS NOT NULL AND Q.CHQ_DTADEV IS NULL) OR ';
        strWhere := strWhere + '      (Q.CHQ_DTADEP IS NOT NULL AND Q.CHQ_DTADEV IS NOT NULL AND Q.CHQ_DTADP2 IS NOT NULL AND Q.CHQ_DTADV2 IS NULL) OR ';
        strWhere := strWhere + '      (Q.CHQ_DTADEV IS NOT NULL AND Q.CHQ_DTADV2 IS NOT NULL) OR ';
        strWhere := strWhere + '      (COALESCE(Q.CHQ_INCCTR, "N") = "S") ';
        strWhere := strWhere + ' ) ';
      End
      Else
      If intOpcao = 3 Then
      Begin
        strWhere := strWhere + ' AND (';
        strWhere := strWhere + '      ((Q.CHQ_DTADEP IS NULL AND Q.CHQ_DTADV2 IS NULL) OR ';
        strWhere := strWhere + '      (Q.CHQ_DTADEP IS NOT NULL AND Q.CHQ_DTADEV IS NOT NULL AND Q.CHQ_DTADP2 IS NULL AND Q.CHQ_DTADV2 IS NULL)) AND ';
        strWhere := strWhere + '      (COALESCE(Q.CHQ_INCCTR, "N") IN ("N", "")) ';
        strWhere := strWhere + '      ) ';
      End;

      If Not Assigned(qryConChq) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryConChq;

      If fConsulta([strSQL, strWhere],
                   arrTitCol,
                   ['CHQ_NUMCHQ','BCO_NOMBCO','CLI_NOMCLI','CHQ_CODCLI'],
                   'AUTOINCREM',
                   strNomTab,
                   Self.Name,
                   strTitulo,
                   qryConsulta,
                   nil,
                   blnConSim,
                   arrSel,
                   'AUTOINCREM',
                   objConsulta) Then
      Begin

        Result := True;

        If Not Assigned(qryConChq) Then
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

End;

{****************}
{* CONSULTA SAC *}
{*************JU*}
function fPesqServAtCli(Self      : TForm;                                  {* Formulário                                  *}
                        qryConSAC : TUniQuery;                                {* Query                                       *}
                        Var chrKey: Char;                                   {* Key                                         *}
                        Var arrSel: TConsultasArray;                        {* Array de Consulta                           *}
                        blnConSim : Boolean = True;                         {* Consulta Simples ou Múltipla (multi select) *}
                        strTitulo : String  = 'Consulta de Serviços de Atendimento ao Cliente'): Boolean;
  Var
    arrTitCol  : TColunasArray;                                           {* Títulos das Colunas                         *}
    strSQL     : String;
    qryConsulta: TUniQuery;
    objConsulta: TDefConsulta;

    Procedure pAddNomeColuna(strNomCol: String);
    Begin
      SetLength(arrTitCol, Succ(Length(arrTitCol)));
      arrTitCol[High(arrTitCol)] := strNomCol;
    End;
Begin
  Result := False;

  If fEntraCons(chrKey) Then
  Begin

    chrKey := #0;

    Try

      objConsulta := TDefConsulta.Create;
      objConsulta.pIncluiSubConsulta('SITUACAO', 'IF(SAC_RSLPRO = "R","RESOLVIDO","NÃO RESOLVIDO")');

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  SAC_CODSAC, '; pAddNomeColuna('Código');
      strSQL := strSQL + '  SAC_DTAATN, '; pAddNomeColuna('Data');
      strSQL := strSQL + '  SAC_NOMCLI, '; pAddNomeColuna('Nome do Cliente');
      strSQL := strSQL + '  SAC_NOMVEN, '; pAddNomeColuna('Nome do Vendedor');
      strSQL := strSQL + '  SAC_DESITE, '; pAddNomeColuna('Descrição do Produto');
      strSQL := strSQL + '  SAC_NOMREP, '; pAddNomeColuna('Nome do Atendente');
      strSQL := strSQL + '  SITUACAO,   '; pAddNomeColuna('Situação');
      strSQL := strSQL + '  SAC_CODMOT, '; pAddNomeColuna('Motivo de Atendimento');
      strSQL := strSQL + '  AUTOINCREM  ';
      strSQL := strSQL + 'FROM  ';
      strSQL := strSQL + '  CADSAC ';

      If Not Assigned(qryConSAC) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryConSAC;

      If fConsulta([strSQL],
                   arrTitCol,
                   ['SAC_NOMCLI','SAC_NOMREP','SAC_CODSAC'],
                   'AUTOINCREM',
                   'CADSAC',
                   Self.Name,
                   strTitulo,
                   qryConsulta,
                   nil,
                   blnConSim,
                   arrSel,
                   'AUTOINCREM',
                   objConsulta) Then
      Begin

        Result := True;

        If Not Assigned(qryConSAC) Then
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

End;

{******************************}
{* CONSULTA DE LOTES DE PREÇO *}
{***************************JU*}
function fPesqLotePre(Self      : TForm;                                    {* Formulário                                  *}
                      qryLotPre : TUniQuery;                                  {* Query                                       *}
                      Var chrKey: Char;                                     {* Key                                         *}
                      Var arrSel: TConsultasArray;                          {* Array de Consulta                           *}
                      blnConSim : Boolean = True;                           {* Consulta Simples ou Múltipla (multi select) *}
                      strTitulo : String  = 'Consulta de Lotes de Preço'): Boolean;
  Var
    arrTitCol  : TColunasArray;                                           {* Títulos das Colunas                         *}
    strSQL     : String;
    strWhere   : String;
    strGroup   : String;
    qryConsulta: TUniQuery;
    objConsulta: TDefConsulta;

    Procedure pAddNomeColuna(strNomCol: String);
    Begin
      SetLength(arrTitCol, Succ(Length(arrTitCol)));
      arrTitCol[High(arrTitCol)] := strNomCol;
    End;

Begin
  Result := False;

  If fEntraCons(chrKey) Then
  Begin

    chrKey := #0;

    Try

      objConsulta := TDefConsulta.Create;
      objConsulta.pIncluiSubConsulta('QUANTIDADE', 'COUNT(*)');

      If fConferenciaDepoisDaEntrada Then
        objConsulta.pIncluiSubConsulta('SIT_PRENOTA', 'IF(GER_DOCENT IS NULL, "SEM PRÉ-NOTA", IF(GER_DTACON IS NULL, "CONFERÊNCIA PENDENTE", "CONFERIDA"))');

      strSql := '';
      strSql := strSql  + ' SELECT SQL_NO_CACHE ';
      strSql := strSql  + '   DET_DTAENT, ';     pAddNomeColuna('Data de Entrada');
      strSql := strSql  + '   DET_NUMDOC, ';     pAddNomeColuna('Documento');
      strSql := strSql  + '   DET_ESPDOC, ';     pAddNomeColuna('Espécie');
      strSql := strSql  + '   DET_SERIE_, ';     pAddNomeColuna('Série');
      strSql := strSql  + '   DET_CODEMP, ';     pAddNomeColuna('Emp.');
      strSql := strSql  + '   DET_CODFOR, ';     pAddNomeColuna('Cód.Forn.');
      strSql := strSql  + '   FOR_NOMFOR, ';     pAddNomeColuna('Fornecedor');
      strSql := strSql  + '   LTP_OPERES, ';     pAddNomeColuna('Cód.Resp.');
      strSql := strSql  + '   OPE_NOMOPE, ';     pAddNomeColuna('Responsável');
      strSql := strSql  + '   QUANTIDADE, ';     pAddNomeColuna('Qtd.Itens');

      If fConferenciaDepoisDaEntrada Then
      Begin
        strSql := strSql  + '   SIT_PRENOTA, ';  pAddNomeColuna('Situação Pré-Nota');
      End;

      strSql := strSql  + '   L.AUTOINCREM, ';
      strSql := strSql  + '   LTP_SEQDET ';
      strSql := strSql  + ' FROM LOTPRE L ';
      strSql := strSql  + '   INNER JOIN MOVDET D ON L.LTP_SEQDET = D.AUTOINCREM ';
      strSql := strSql  + '   INNER JOIN CADFOR F ON F.FOR_CODFOR = D.DET_CODFOR ';
      strSql := strSql  + '   LEFT  JOIN CADOPE R ON R.OPE_CODOPE = L.LTP_OPERES ';

      If fConferenciaDepoisDaEntrada Then
      Begin
        strSql := strSql  + '   LEFT JOIN GERELE ON GER_DOCENT = DET_NUMDOC AND ';
        strSql := strSql  + '                       GER_ESPENT = DET_ESPDOC AND ';
        strSql := strSql  + '                       GER_EMPENT = DET_CODEMP AND ';
        strSql := strSql  + '                       B07_SERIE  = DET_SERIE_ AND ';
        strSql := strSql  + '                       GER_CODFOR = DET_CODFOR     ';
      End;

      strWhere := strWhere  + ' WHERE ';
      strWhere := strWhere  + ' 	DET_DTAENT IS NOT NULL AND ';
      strWhere := strWhere  + ' 	LTP_BAIXAD = "N" ';

      If Not (fCfgSis('EMPGER', varBoolean) And fCfgSis('LOTGER', varBoolean)) Then
        strWhere := strWhere  + ' 	AND LTP_CODEMP = "' + VS_strCodEmp + '" ';

      strGroup := strGroup  + ' GROUP BY ';
      strGroup := strGroup  + ' 	DET_NUMDOC, ';
      strGroup := strGroup  + ' 	DET_ESPDOC, ';
      strGroup := strGroup  + ' 	DET_SERIE_, ';
      strGroup := strGroup  + ' 	DET_CODFOR, ';
      strGroup := strGroup  + ' 	DET_CODEMP, ';
      strGroup := strGroup  + ' 	LTP_OPERES  ';

      If Not Assigned(qryLotPre) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryLotPre;

      If fConsulta([strSQL, strWhere, strGroup],
                   arrTitCol,
                   ['DET_NUMDOC','FOR_NOMFOR','DET_CODFOR'],
                   'AUTOINCREM',
                   'LOTPRE',
                   Self.Name,
                   strTitulo,
                   qryConsulta,
                   nil,
                   blnConSim,
                   arrSel,
                   'AUTOINCREM',
                   objConsulta) Then
      Begin

        Result := True;

        If Not Assigned(qryLotPre) Then
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

End;

{*******************************}
{* CONSULTA DE VENDAS PERDIDAS *}
{****************************JU*}
function fPesqVenPerd(Self      : TForm;                                    {* Formulário                                  *}
                      edtCodigo : TCustomEdit;                              {* Edit do Código                              *}
                      qryVenPer : TUniQuery;                                  {* Query                                       *}
                      Var chrKey: Char;                                     {* Key                                         *}
                      Var arrSel: TConsultasArray;                          {* Array de Consulta                           *}
                      blnConSim : Boolean = True;                           {* Consulta Simples ou Múltipla (multi select) *}
                      strTitulo : String  = 'Consulta de Vendas Pedidas'): Boolean;
  Var
    arrTitCol  : TColunasArray;                                           {* Títulos das Colunas                         *}
    strSQL     : String;
    qryConsulta: TUniQuery;

    Procedure pAddNomeColuna(strNomCol: String);
    Begin
      SetLength(arrTitCol, Succ(Length(arrTitCol)));
      arrTitCol[High(arrTitCol)] := strNomCol;
    End;

Begin
  Result := False;

  If fEntraCons(chrKey) Then
  Begin
    chrKey := #0;

    Try

      strSQL := '';
      strSQL := strSQL + 'SELECT  ';
      strSQL := strSQL + '  VPG_CODIGO, '; pAddNomeColuna('Sequencial');
      strSQL := strSQL + '  VPG_DTACAD, '; pAddNomeColuna('Cadastro');
      strSQL := strSQL + '  VPG_CODCLI, '; pAddNomeColuna('Cód.Cliente');
      strSQL := strSQL + '  CLI_NOMCLI, '; pAddNomeColuna('Cliente');
      strSQL := strSQL + '  VPG_CODVEN, '; pAddNomeColuna('Cód.Vendedor');
      strSQL := strSQL + '  OPE_NOMOPE, '; pAddNomeColuna('Vendedor');
      strSQL := strSQL + '  VPG_DTAALT, '; pAddNomeColuna('Alteração');
      strSQL := strSQL + '  M.AUTOINCREM  ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  MOVVPG M ';
      strSQL := strSQL + 'INNER JOIN CADOPE ON OPE_CODOPE = VPG_CODVEN ';
      strSQL := strSQL + 'INNER JOIN CADCLI ON CLI_CODCLI = VPG_CODCLI ';

      If Not Assigned(qryVenPer) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryVenPer;

      If fConsulta([strSQL],
                   arrTitCol,
                   ['CLI_NOMCLI','VPG_CODCLI','VPG_CODIGO'],
                   'AUTOINCREM',
                   'MOVVPG',
                   Self.Name,
                   strTitulo,
                   qryConsulta,
                   nil,
                   blnConSim,
                   arrSel,
                   'AUTOINCREM',
                   nil) Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('VPG_CODIGO').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('VPG_CODIGO').AsString;
        End;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 8)
            Else
              edtCodigo.Text := fStrZero('0', 8);
          End;

        End;

        Result := True;

        If Not Assigned(qryVenPer) Then
          FreeAndNil(qryConsulta);
      End;

      edtCodigo.Text := fTiraCaracEspeciais(edtCodigo.Text);

    Except

      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;

    End;

  End;

End;

{*******************************}
{* CONSULTA DE VENDAS PERDIDAS *}
{****************************JU*}
function fPesqRequisicaoCompra(Self      : TForm;                                    {* Formulário                                  *}
                               edtCodigo : TCustomEdit;                              {* Edit do Código                              *}
                               Var chrKey: Char;                                     {* Key                                         *}
                               strTitulo : String  = 'Consulta de Requisição de Compras'): Boolean;
  Var
    arrTitCol  : TColunasArray;
    arrSel     : TConsultasArray;
    strSQL,
    strWhere   : String;
    qryConsulta: TUniQuery;

    Procedure pAddNomeColuna(strNomCol: String);
    Begin
      SetLength(arrTitCol, Succ(Length(arrTitCol)));
      arrTitCol[High(arrTitCol)] := strNomCol;
    End;

Begin
  Result := False;

  If fEntraCons(chrKey) Then
  Begin
    chrKey := #0;

    Try

      strSQL := '';
      strSQL := strSQL + 'SELECT  ';
      strSQL := strSQL + '  RCG_CODIGO, '; pAddNomeColuna('Sequencial');
      strSQL := strSQL + '  RCG_CODEMP, '; pAddNomeColuna('Empresa');
      strSQL := strSQL + '  RCG_DTACAD, '; pAddNomeColuna('Cadastro');
      strSQL := strSQL + '  RCG_CODCLI, '; pAddNomeColuna('Cód.Cliente');
      strSQL := strSQL + '  CLI_NOMCLI, '; pAddNomeColuna('Cliente');
      strSQL := strSQL + '  RCG_CODVEN, '; pAddNomeColuna('Cód.Vendedor');
      strSQL := strSQL + '  OPE_NOMOPE, '; pAddNomeColuna('Vendedor');
      strSQL := strSQL + '  RCG_DTAALT, '; pAddNomeColuna('Alteração');
      strSQL := strSQL + '  M.AUTOINCREM  ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  MOVRCG M ';
      strSQL := strSQL + 'INNER JOIN CADOPE ON OPE_CODOPE = RCG_CODVEN ';
      strSQL := strSQL + 'INNER JOIN CADCLI ON CLI_CODCLI = RCG_CODCLI ';

      strWhere := '';
      strWhere := strWhere + ' WHERE ';
      strWhere := strWhere + '   RCG_CODEMP = ' + QuotedStr(VS_strCodEmp);


      qryConsulta := fCriaQuery(Nil);
      Try
        If fConsulta([strSQL, strWhere],
                     arrTitCol,
                     ['CLI_NOMCLI','RCG_CODCLI','RCG_CODIGO'],
                     'AUTOINCREM',
                     'MOVRCG',
                     Self.Name,
                     strTitulo,
                     qryConsulta,
                     nil,
                     True,
                     arrSel,
                     'AUTOINCREM',
                     nil) Then
        Begin
          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('RCG_CODIGO').AsString
            Else
              edtCodigo.Text := qryConsulta.FieldByName('RCG_CODIGO').AsString;
          End;

          If (Length(arrSel) > 1) Then
          Begin

            If Assigned(edtCodigo) then
            Begin
              If (edtCodigo Is TMaskEditFocus) Then
                (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 8)
              Else
                edtCodigo.Text := fStrZero('0', 8);
            End;

          End;

          Result := True;
        End;
      Finally
        FreeAndNil(qryConsulta);
      End;

      edtCodigo.Text := fTiraCaracEspeciais(edtCodigo.Text);

    Except

      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;

    End;

  End;

End;

{****************************************}
{* CONSULTA DE CONTROLE DE ENTREGADORES *}
{*************************************JU*}
function fPesqContEnt(Self      : TForm;                                    {* Formulário                                  *}
                      edtProxEnt: TCustomEdit;                              {* Edit do Código                              *}
                      qryConEnt : TUniQuery;                                  {* Query                                       *}
                      Var chrKey: Char;                                     {* Key                                         *}
                      Var arrSel: TConsultasArray;                          {* Array de Consulta                           *}
                      blnConSim : Boolean = True;                           {* Consulta Simples ou Múltipla (multi select) *}
                      strTitulo : String  = 'Consulta de Controle de Entregadores'): Boolean;
  Var
    arrTitCol  : TColunasArray;                                           {* Títulos das Colunas                         *}
    strSQL     : String;
    strWhere   : String;
    qryConsulta: TUniQuery;
    objConsulta: TDefConsultaConEntrega;

    Procedure pAddNomeColuna(strNomCol: String);
    Begin
      SetLength(arrTitCol, Succ(Length(arrTitCol)));
      arrTitCol[High(arrTitCol)] := strNomCol;
    End;

Begin
  Result := False;

  If fEntraCons(chrKey) Then
  Begin

    chrKey := #0;

    Try

      objConsulta := TDefConsultaConEntrega.Create;
      objConsulta.pIncluiSubConsulta('BAIXADO', 'IF(ENG_DTABAI IS NULL, "NÃO", "SIM")');
      objConsulta.pIncluiSubConsulta('VEICULO', 'IF(IFNULL(ENG_PLAVEI,"") = "", "", CONCAT(LEFT(ENG_PLAVEI,3),"-",RIGHT(ENG_PLAVEI,4)))');

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  ENG_PROENT, '; pAddNomeColuna('Num.Entrega');
      strSQL := strSQL + '  ENG_CODENT, '; pAddNomeColuna('Código Entregador');
      strSQL := strSQL + '  MOT_NOMMOT, '; pAddNomeColuna('Nome Entregador');
      strSQL := strSQL + '  ENG_DTACAD, '; pAddNomeColuna('Data de Cadastro');
      strSQL := strSQL + '  ENG_HRACAD, '; pAddNomeColuna('Hora de Cadastro');
      strSQL := strSQL + '  VEICULO, ';    pAddNomeColuna('Veículo');
      strSQL := strSQL + '  BAIXADO, ';    pAddNomeColuna('Baixado');
      strSQL := strSQL + '  COMENG.AUTOINCREM ';
      strSQL := strSQL + 'FROM      ';
      strSQL := strSQL + '  COMENG, ';
      strSQL := strSQL + '  CADMOT  ';

      strWhere := strWhere + 'WHERE     ';
      strWhere := strWhere + '  MOT_CODMOT = ENG_CODENT ';

      If Not Assigned(qryConEnt) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryConEnt;

      If fConsulta([strSQL, strWhere],
                   arrTitCol,
                   ['ENG_PROENT','MOT_NOMMOT','ENG_CODENT'],
                   'AUTOINCREM',
                   'COMENG',
                   Self.Name,
                   strTitulo,
                   qryConsulta,
                   nil,
                   blnConSim,
                   arrSel,
                   'AUTOINCREM',
                   objConsulta) Then
      Begin
        If Assigned(edtProxEnt) then
        Begin
          If (edtProxEnt Is TMaskEditFocus) Then
            (edtProxEnt As TMaskEditFocus).Text := qryConsulta.FieldByName('ENG_PROENT').AsString
          Else
            edtProxEnt.Text := qryConsulta.FieldByName('ENG_PROENT').AsString;
        End;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtProxEnt) then
          Begin
            If (edtProxEnt Is TMaskEditFocus) Then
              (edtProxEnt As TMaskEditFocus).Text := fStrZero('0', 8)
            Else
              edtProxEnt.Text := fStrZero('0', 8);
          End;

        End;

        Result := True;

        If Not Assigned(qryConEnt) Then
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

End;

function fPesqEstrutura(Self      : TForm;                                  {* Formulário                                  *}
                        edtCodPro : TCustomEdit;                            {* Edit do Código                              *}
                        qryConEst : TUniQuery;                              {* Query                                       *}
                        Var chrKey: Char;                                   {* Key                                         *}
                        Var arrSel: TConsultasArray;                        {* Array de Consulta                           *}
                        blnConSim : Boolean = True;                         {* Consulta Simples ou Múltipla (multi select) *}
                        strTitulo : String  = 'Consulta de Estruturas';
                        blnCodIte: Boolean = False): Boolean;
  Var
    arrTitCol  : TColunasArray;                                           {* Títulos das Colunas                         *}
    strSQL     : String;
    strWhere   : String;
    qryConsulta: TUniQuery;

    Procedure pAddNomeColuna(strNomCol: String);
    Begin
      SetLength(arrTitCol, Succ(Length(arrTitCol)));
      arrTitCol[High(arrTitCol)] := strNomCol;
    End;

Begin
  Result := False;

  If fEntraCons(chrKey) Then
  Begin

    chrKey := #0;

    Try

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  CADGRU.GRU_CODGRU, '; pAddNomeColuna('Grupo');
      strSQL := strSQL + '  GERMAT.GMT_CODITE, '; pAddNomeColuna('Codigo');
      strSQL := strSQL + '  CADITE.ITE_DESITE, '; pAddNomeColuna('Descrição');
      strSQL := strSQL + '  GERMAT.GMT_REFERE, '; pAddNomeColuna('Referencia');
      strSQL := strSQL + '  CADITE.ITE_CODUNI, '; pAddNomeColuna('Cód. Unidade');
      strSQL := strSQL + '  CADUNI.UNI_DESUNI, '; pAddNomeColuna('Unidade');
      strSQL := strSQL + '  CADMAR.MAR_DESMAR, '; pAddNomeColuna('Marca');
      strSQL := strSQL + '  CADITE.ITE_CODFAB, '; pAddNomeColuna('Cód. Fábrica');
      strSQL := strSQL + '  CADITE.ITE_CODBAR, '; pAddNomeColuna('Cód. Barras');
      strSQL := strSQL + '  GERMAT.GMT_TIPQTD,  ';
      strSQL := strSQL + '  GERMAT.GMT_LAYORD,  ';
      strSQL := strSQL + '  GERMAT.AUTOINCREM  ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADITE ';
      strSQL := strSQL + '  JOIN ITEGER ON ITEGER.ITE_CODITE = CADITE.ITE_CODITE ';
      strSQL := strSQL + '  JOIN GERMAT ON GERMAT.GMT_CODITE = CADITE.ITE_CODITE ';
      strSQL := strSQL + '  JOIN CADUNI ON CADITE.ITE_CODUNI = CADUNI.UNI_CODUNI ';
      strSQL := strSQL + '  JOIN CADMAR ON CADITE.ITE_CODMAR = CADMAR.MAR_CODMAR ';
      strSQL := strSQL + '  JOIN CADGRU ON GRU_CODGRU = CADITE.ITE_CODGRU ';

      strWhere := 'WHERE ';
      strWhere := strWhere + '  ITEGER.ITE_CODEMP = ' + VS_strCodEmp;

      If Not Assigned(qryConEst) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryConEst;

      If fConsulta([strSQL, strWhere],
                   arrTitCol,
                   ['ITE_DESITE','GRU_CODGRU','GMT_CODITE'],
                   'AUTOINCREM',
                   'GERMAT',
                   Self.Name,
                   strTitulo,
                   qryConsulta,
                   nil,
                   blnConSim,
                   arrSel,
                   IIf(blnCodIte,'GMT_CODITE','AUTOINCREM'),
                   nil) Then
      Begin
        If Assigned(edtCodPro) then
        Begin
          If (edtCodPro Is TMaskEditFocus) Then
            (edtCodPro As TMaskEditFocus).Text := qryConsulta.FieldByName('GMT_CODITE').AsString
          Else
            edtCodPro.Text := qryConsulta.FieldByName('GMT_CODITE').AsString;
        End;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodPro) then
          Begin
            If (edtCodPro Is TMaskEditFocus) Then
              (edtCodPro As TMaskEditFocus).Text := fStrZero('0', 8)
            Else
              edtCodPro.Text := fStrZero('0', 8);
          End;

        End;

        Result := True;

        If Not Assigned(qryConEst) Then
          FreeAndNil(qryConsulta);
      End;

    Except

      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;

    End;

  End;

End;



{*********************************}
{* CONSULTA DE PRODUTOS ACABADOS *}
{******************************JU*}
function fPesqProdAcabado(Self      : TForm;                                {* Formulário                                  *}
                          edtCodAca : TCustomEdit;                          {* Edit do Código                              *}
                          edtDesAca : TEditFocus;                           {* Edit da Descrição                           *}
                          qryConAca : TUniQuery;                              {* Query                                       *}
                          Var chrKey: Char;                                 {* Key                                         *}
                          Var arrSel: TConsultasArray;                      {* Array de Consulta                           *}
                          strEmpAca : String;                               {* Código da Empresa                           *}
                          strEmpEst : String;
                          blnConSim : Boolean = True;                       {* Consulta Simples ou Múltipla (multi select) *}
                          strTitulo : String  = 'Consulta de Produtos Acabados';
                          blnCodAca : Boolean = False): Boolean;
  Var
    arrTitCol  : TColunasArray;                                             {* Títulos das Colunas                         *}
    strSQL     : String;
    strWhere   : String;
    qryConsulta: TUniQuery;
    objConsulta: TDefConsulta;

    Procedure pAddNomeColuna(strNomCol: String);
    Begin
      SetLength(arrTitCol, Succ(Length(arrTitCol)));
      arrTitCol[High(arrTitCol)] := strNomCol;
    End;

Begin
  Result := False;

  If fEntraCons(chrKey) Then
  Begin

    chrKey := #0;

    Try

      objConsulta := TDefConsulta.Create;
      objConsulta.pIncluiSubConsulta('ACA_SALDOS', 'ROUND(G.ACA_SALDOS, 3)');

      objConsulta.pIncluiConflito('ACA_CODACA', 'G.ACA_CODACA');

      strSQL := '';
      strSQL := strSQL + 'SELECT DISTINCT ';
      strSQL := strSQL + '	A.ACA_CODACA, ';  pAddNomeColuna('Código');
      strSQL := strSQL + '	A.ACA_DESCRI, ';  pAddNomeColuna('Descrição');
      strSQL := strSQL + '	A.ACA_CODBAR, ';  pAddNomeColuna('Cód. Barras');
      strSQL := strSQL + '  ACA_SALDOS,   ';  pAddNomeColuna('Saldo');
      strSQL := strSQL + '	G.ACA_PREVEN, ';  pAddNomeColuna('Preço de Venda');
      strSQL := strSQL + '	A.AUTOINCREM ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '	CADACA A ';
      strSQL := strSQL + 'JOIN	ACAGER G ON G.ACA_CODACA = A.ACA_CODACA AND ';
      strSQL := strSQL + '                  G.ACA_CODEMP = A.ACA_CODEMP ';

      strWhere := strWhere + 'WHERE TRUE ';

      If Not fEmptyStr(strEmpAca) Then
        strWhere := strWhere + ' AND A.ACA_CODEMP = ' + QuotedStr(strEmpAca);

      If Not fEmptyStr(strEmpEst) Then
        strWhere := strWhere + ' AND G.ACA_EMPEST = ' + QuotedStr(strEmpEst);

      If Not Assigned(qryConAca) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryConAca;

      If fConsulta([strSQL,strWhere],
                   arrTitCol,
                   ['ACA_DESCRI','ACA_CODACA'],
                   'AUTOINCREM',
                   'CADACA',
                   Self.Name,
                   strTitulo,
                   qryConsulta,
                   nil,
                   blnConSim,
                   arrSel,
                   IIf(blnCodAca,'AUTOINCREM','ACA_CODACA'),
                   objConsulta) Then
      Begin
          If Assigned(edtCodAca) then
          Begin
            If (edtCodAca Is TMaskEditFocus) Then
              (edtCodAca As TMaskEditFocus).Text := qryConsulta.FieldByName('ACA_CODACA').AsString
            Else
              edtCodAca.Text := qryConsulta.FieldByName('ACA_CODACA').AsString;
          End;

          If Assigned(edtDesAca) Then
            edtDesAca.Text := qryConsulta.FieldByName('ACA_DESCRI').AsString;

          If (Length(arrSel) > 1) Then
          Begin

            If Assigned(edtCodAca) then
            Begin
              If (edtCodAca Is TMaskEditFocus) Then
                (edtCodAca As TMaskEditFocus).Text := fStrZero('0', 8)
              Else
                edtCodAca.Text := fStrZero('0', 8);
            End;

            If Assigned(edtDesAca) Then
              edtDesAca.Text := '+1';

          End;

        Result := True;

        If Not Assigned(qryConAca) Then
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

End;





function fPesqGruCfg(Self      : TForm;                                   {* Formulário                                  *}
                     edtDesCfg : TEditFocus;                              {* Edit da Descrição                           *}
                     qryConCfg : TUniQuery;                                 {* Query                                       *}
                     Var chrKey: Char;                                    {* Key                                         *}
                     Var arrSel: TConsultasArray;                         {* Array de Seleção                            *}
                     blnConSim : Boolean = True;                          {* Consulta Simples ou Múltipla (multi select) *}
                     strTitulo : String  = 'Consulta de Grupos de Configurações'): Boolean;
  Var
    arrTitCol  : TColunasArray;                                           {* Títulos das Colunas                         *}
    strSQL     : String;
    strWhere   : String;
    qryConsulta: TUniQuery;
    objConsulta: TDefConsulta;

    Procedure pAddNomeColuna(strNomCol: String);
    Begin
      SetLength(arrTitCol, Succ(Length(arrTitCol)));
      arrTitCol[High(arrTitCol)] := strNomCol;
    End;

Begin
  Result := False;

  If fEntraCons(chrKey) Then
  Begin
    chrKey := #0;
    Try
      objConsulta := TDefConsulta.Create;
      strSQL := '';
//      strSQL := strSQL + ' SELECT ';
//      strSQL := strSQL + '   SIS_GRUCFG, ';
//      strSQL := strSQL + '   (@AUTOINCREMENTO := @AUTOINCREMENTO + 1) AS COLUNA ';
//      strSQL := strSQL + ' FROM ';
//      strSQL := strSQL + '   CROSS JOIN (SELECT @AUTOINCREMENTO := 0) AS TABELA ';
      strSQL := strSQL + '  SELECT DISTINCT SIS_GRUCFG, AUTOINCREM FROM CFGSIS '; pAddNomeColuna('Descrição');
      strWhere := '';
      objConsulta.pIncluiSubConsulta('AUTOINCREM', '""');

      If Not Assigned(qryConCfg) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryConCfg;

      If fConsulta([strSQL, strWhere],
                   arrTitCol,
                   ['SIS_GRUCFG'],
                   'SIS_GRUCFG',
                   'CFGSIS',
                   Self.Name,
                   strTitulo,
                   qryConsulta,
                   nil,
                   blnConSim,
                   arrSel,
                   'SIS_GRUCFG',
                   objConsulta) Then
      Begin
        Result := True;
        If Not Assigned(qryConCfg) Then
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

{ TDefConsultaConEntrega }

constructor TDefConsultaConEntrega.Create;
begin
  Inherited Create;

  cxsBaixado           := TcxStyle.Create(nil);
  cxsBaixado.TextColor := clRed;
end;

destructor TDefConsultaConEntrega.Destroy;
begin
  FreeAndNil(cxsBaixado);
  Inherited Destroy;
end;

function TDefConsultaConEntrega.fGetCellStyle(AView: TcxGridDBTableView;
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
  ADataSet: TDataSet): TcxStyle;
  Var
    ARowInfo: TcxRowInfo;

  function fIdxColumn(strCampo: String): Integer;
  begin
    Result := -1;

    {********************************************************}
    {* ESSA FUNÇAO TEVE DE ALTERAR O COMPONENTE DEV-EXPRESS *}
    {* SE ESTA OCORRENDO ERRO DE TYPECAST VC DEVE VERIFICAR *}
    {* NOS COMPONENTES SE A CORREÇÃO FOI APLICADA EM SUA    *}
    {* MÁQUINA                                              *}
    {*****************************************************AF*}
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

  If ARecord.IsData And (ARecord.Index > -1) Then
  Begin

    If IfNull(fGetValor(fIdxColumn('BAIXADO')), '') = 'SIM' Then
      Result := cxsBaixado;

  End;

end;

function fPesqMotVendasPerdidas(Self     : TForm;                    {* Formulário                                  *}
                                edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                                qryTabela: TUniQuery;                  {* Query                                       *}
                                Var chrKey: Char;                    {* Key                                         *}
                                Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL     : String;
    strWhere   : String;
    qryConsulta: TUniQuery;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  MOT_CODMOT,       ';
      strSQL := strSQL + '  MOT_DESMOT,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  MOTVPD            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL,strWhere],
                  ['Código',
                   'Descrição',
                   'AUTOINCREM'],
                   ['MOT_DESMOT','MOT_CODMOT'],
                   '',
                   'MOTVPD',
                   Self.Name,
                   'Consulta de Motivos de Vendas Perdidas',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'MOT_CODMOT') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('MOT_CODMOT').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('MOT_CODMOT').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('MOT_DESMOT').AsString;

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
      End;

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;



{Pesquisa as cores}
function fPesqCores(Self     : TForm;                           {* Formulário                                  *}
                    edtCodigo: TCustomEdit;                     {* Edit do Código                              *}
                    edtDescri: TEditFocus;                      {* Edit da Descrição                           *}
                    qryTabela: TUniQuery;                         {* Query                                       *}
                    Var chrKey: Char;                           {* Key                                         *}
                    Var arrSel: TConsultasArray;                {* Array de Seleção                            *}
                    blnConSim: Boolean = True;                  {* Consulta Simples ou Múltipla (multi select) *}
                    strCodGra: String = ''): Boolean;           {* Código do Prouto a Granel *}
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE DISTINCT ';
      strSQL := strSQL + '  COR_CODCOR,       ';
      strSQL := strSQL + '  COR_DESCOR,       ';
      strSQL := strSQL + '  C.AUTOINCREM      ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  CADCOR C          ';

      If Not fEmptyStr(strCodGra) Then
      Begin
        strSQL := strSQL + ' INNER JOIN CADITE ON ITE_CODPAG = ' + QuotedStr(strCodGra) ;
        strSQL := strSQL + '            AND ITE_CODCOR = COR_CODCOR ';
      End;

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Código',
                   'Descrição',
                   'AUTOINCREM'],
                   ['COR_DESCOR','COR_CODCOR'],
                   '',
                   'CADCOR',
                   Self.Name,
                   'Consulta de Cores',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'COR_CODCOR') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('COR_CODCOR').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('COR_CODCOR').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('COR_DESCOR').AsString;

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
End;


function fPesqComposicaoProdAcab(Self      : TForm;                                  {* Formulário                                  *}
                                 edtCodPro : TCustomEdit;                            {* Edit do Código                              *}
                                 qryConEst : TUniQuery;                                {* Query                                       *}
                                 Var chrKey: Char;                                   {* Key                                         *}
                                 Var arrSel: TConsultasArray;                        {* Array de Consulta                           *}
                                 blnConSim : Boolean = True;                         {* Consulta Simples ou Múltipla (multi select) *}
                                 strTitulo : String  = 'Consulta Composição Produto Acabado'): Boolean;
  Var
    arrTitCol  : TColunasArray;                                           {* Títulos das Colunas                         *}
    strSQL     : String;
    strWhere   : String;
    qryConsulta: TUniQuery;

    Procedure pAddNomeColuna(strNomCol: String);
    Begin
      SetLength(arrTitCol, Succ(Length(arrTitCol)));
      arrTitCol[High(arrTitCol)] := strNomCol;
    End;

Begin
  Result := False;

  If fEntraCons(chrKey) Then
  Begin

    chrKey := #0;

    Try

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  CADGRU.GRU_CODGRU, '; pAddNomeColuna('Grupo');
      strSQL := strSQL + '  GERCPA.GPA_CODITE, '; pAddNomeColuna('Codigo');
      strSQL := strSQL + '  CADITE.ITE_DESITE, '; pAddNomeColuna('Descrição');
      strSQL := strSQL + '  CADITE.ITE_REFERE, '; pAddNomeColuna('Referencia');
      strSQL := strSQL + '  CADITE.ITE_CODUNI, '; pAddNomeColuna('Cód. Unidade');
      strSQL := strSQL + '  CADUNI.UNI_DESUNI, '; pAddNomeColuna('Unidade');
      strSQL := strSQL + '  CADMAR.MAR_DESMAR, '; pAddNomeColuna('Marca');
      strSQL := strSQL + '  CADITE.ITE_CODFAB, '; pAddNomeColuna('Cód. Fábrica');
      strSQL := strSQL + '  CADITE.ITE_CODBAR, '; pAddNomeColuna('Cód. Barras');
      strSQL := strSQL + '  GERCPA.AUTOINCREM  ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  JOIN CADITE ';
      strSQL := strSQL + '  JOIN ITEGER ON ITEGER.ITE_CODITE = CADITE.ITE_CODITE ';
      strSQL := strSQL + '  JOIN GERCPA ON GERCPA.GPA_CODITE = CADITE.ITE_CODITE ';
      strSQL := strSQL + '  JOIN CADUNI ON CADITE.ITE_CODUNI = CADUNI.UNI_CODUNI ';
      strSQL := strSQL + '  JOIN CADMAR ON CADITE.ITE_CODMAR = CADMAR.MAR_CODMAR ';
      strSQL := strSQL + '  JOIN CADGRU ON GRU_CODGRU = CADITE.ITE_CODGRU ';

      strWhere := strWhere + 'WHERE ';
      //strWhere := strWhere + '  ITEGER.ITE_CODITE = CADITE.ITE_CODITE AND ';
      strWhere := strWhere + '  ITEGER.ITE_CODEMP = ' + VS_strCodEmp; //+ ' AND ';
      //strWhere := strWhere + '  GERCPA.GPA_CODITE = CADITE.ITE_CODITE AND ';
      //strWhere := strWhere + '  CADITE.ITE_CODUNI = CADUNI.UNI_CODUNI AND ';
      //strWhere := strWhere + '  CADITE.ITE_CODMAR = CADMAR.MAR_CODMAR  ';

      If Not Assigned(qryConEst) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryConEst;

      If fConsulta([strSQL, strWhere],
                   arrTitCol,
                   ['ITE_DESITE','GRU_CODGRU','GPA_CODITE'],
                   'AUTOINCREM',
                   'GERCPA',
                   Self.Name,
                   strTitulo,
                   qryConsulta,
                   nil,
                   blnConSim,
                   arrSel,
                   'AUTOINCREM',
                   nil) Then
      Begin
        If Assigned(edtCodPro) then
        Begin
          If (edtCodPro Is TMaskEditFocus) Then
            (edtCodPro As TMaskEditFocus).Text := qryConsulta.FieldByName('GPA_CODITE').AsString
          Else
            edtCodPro.Text := qryConsulta.FieldByName('GPA_CODITE').AsString;
        End;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodPro) then
          Begin
            If (edtCodPro Is TMaskEditFocus) Then
              (edtCodPro As TMaskEditFocus).Text := fStrZero('0', 8)
            Else
              edtCodPro.Text := fStrZero('0', 8);
          End;

        End;

        Result := True;

        If Not Assigned(qryConEst) Then
          FreeAndNil(qryConsulta);
      End;

    Except

      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;

    End;

  End;

End;




function fPesqSubItensDaEstrutura(Self      : TForm;                    {* Formulário                                  *}
                                  edtCodigo : TCustomEdit;              {* Edit do Código                              *}
                                  edtDescri : TEditFocus;               {* Edit da Cidade                              *}
                                  qryTabela : TUniQuery;                {* Query                                       *}
                                  Var chrKey: Char;                     {* Key                                         *}
                                  Var arrSel: TConsultasArray;          {* Array de Seleção                            *}
                                  strCodIte : String;                   {*Código do produto acabado                    *}
                                  blnConSim : Boolean = True):Boolean;  {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL     : String;
    strWhere   : String;
    qryConsulta: TUniQuery;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + ' SELECT ITE_CODITE,                                    ';
      strSQL := strSQL + '        ITE_DESITE,                                    ';
      strSQL := strSQL + '        ITE_REFERE,                                    ';
      strSQL := strSQL + '        UNI_SIGUNI,                                    ';
      strSQL := strSQL + '        CADITE.AUTOINCREM                              ';
      strSQL := strSQL + ' FROM GERMAT                                           ';
      strSQL := strSQL + '   INNER JOIN DETMAT ON DMT_SEQGER = GERMAT.AUTOINCREM ';
      strSQL := strSQL + '   INNER JOIN CADITE ON ITE_CODITE = DMT_ITESUB        ';
      strSQL := strSQL + '   LEFT  JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI        ';

      strWhere := ' WHERE GMT_CODITE = ' + QuotedStr(strCodIte);

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL, strWhere],
                  ['Código',
                   'Descrição',
                   'Referência',
                   'Un'],
                   ['ITE_CODITE', 'ITE_DESITE', 'ITE_REFERE', 'UNI_SIGUNI'],
                   '',
                   'CADITE',
                   Self.Name,
                   'Itens da Estrutura',
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

        If Assigned(edtCodigo) Then
          edtDescri.Text := qryConsulta.FieldByName('ITE_DESITE').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', fTamCodIte)
            Else
              edtCodigo.Text := fStrZero('0', fTamCodIte);
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1'
          Else
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

End;




{*****************************}
{* CONSULTA DE COMPOSIÇÃO    *}
{**************************PZ*}
function fPesqComposicao(Self      : TForm;                           {* Formulário                                  *}
                         edtCodigo : TCustomEdit;                     {* Edit do Código                              *}
                         edtDescri : TEditFocus;                      {* Edit da Cidade                              *}
                         qryTabela : TUniQuery;                         {* Query                                       *}
                         Var chrKey: Char;                            {* Key                                         *}
                         Var arrSel: TConsultasArray;                 {* Array de Seleção                            *}
                         blnConSim : Boolean = True): Boolean;        {* Consulta Simples ou Múltipla (multi select) *}
  Var
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
      strSQL := strSQL + '  GCO_CODCOM,       ';
      strSQL := strSQL + '  GCO_DESCOM,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  GERCOM            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Código',
                   'Descrição',
                   'AUTOINCREM'],
                   ['GCO_DESCOM','GCO_CODCOM'],
                   '',
                   'GERCOM',
                   Self.Name,
                   'Consulta de Composição de produtos',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'GCO_CODCOM') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('GCO_CODCOM').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('GCO_CODCOM').AsString;
        End;

        If Assigned(edtCodigo) Then
          edtDescri.Text := qryConsulta.FieldByName('GCO_DESCOM').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 2)
            Else
              edtCodigo.Text := fStrZero('0', 2);
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1'
          Else
            edtDescri.Text := '+1';

        End;

        Result := True;
      End;

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

Constructor TDefMascaraOPIndustrial.Create;
Begin
  Inherited Create;

  pIncluiIndCampos(['ORD_NUMLOT']);

  pIncluiDefMascara('ORD_NUMLOT', pDisplayNumLot);
End;

procedure TDefMascaraOPIndustrial.pDisplayNumLot(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
//  Var
//    intIndex: Integer;
begin
//  intIndex := fIdxCampo('ORD_NUMLOT');
  AText := FormatMaskText('999999-999;0;', AText);
end;

function fPesqOrdProIndustrial(Self     : TForm;                            {* Formulário                                  *}
                               edtCodigo: TCustomEdit;                      {* Edit do Código                              *}
                               edtDescri: TCustomEdit;                      {* Edit da Descrição                           *}
                               qryTabela: TUniQuery;                          {* Query                                       *}
                               Var chrKey: Char;                            {* Key                                         *}
                               Var arrSel: TConsultasArray;                 {* Array de Seleção                            *}
                               tpcPsqOPI: TPesquisaOPI;
                               blnConSim: Boolean = True;
                               staState: TStateOPI = staTodas;                   {* Consulta Simples ou Múltipla (multi select) *}
                               strCodIte: String = '';
                               strCodCor: String = ''):Boolean;
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
    objConsulta: TDefMascaraOPIndustrial;
    arrTitCol: TColunasArray;                                   {* Títulos das Colunas                         *}

  procedure pAddCol(strTit: String);
  begin
    SetLength(arrTitCol, Length(arrTitCol) + 1);
    arrTitCol[Length(arrTitCol) - 1] := strTit;
  end;

begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      objConsulta := TDefMascaraOPIndustrial.Create;
      SetLength(arrTitCol, 0);

      chrKey := #0;

      objConsulta.pIncluiCampoSimNao('ORD_BAIXAD');

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE        ';
      strSQL := strSQL + '  ORD_NUMLOT,              ';    pAddCol('Número do Lote');
      strSQL := strSQL + '  ORD_CODORD,              ';    pAddCol('Código da OP');
      strSQL := strSQL + '  ORD_DTACAD,              ';    pAddCol('Data de Cadastro');
      strSQL := strSQL + '  ORD_CODITE,              ';    pAddCol('Cód.Item');
      strSQL := strSQL + '  ITE_DESITE,              ';    pAddCol('Descrição do Item');
      strSQL := strSQL + '  ORD_CODCOR,              ';    pAddCol('Cód.Cor');
      strSQL := strSQL + '  COR_DESCOR,              ';    pAddCol('Descrição da Cor');
      strSQL := strSQL + '  ORD_BAIXAD,              ';    pAddCol('Baixada');
      strSQL := strSQL + '  ORD_DTABAI,              ';    pAddCol('Data da Baixa');
      strSQL := strSQL + '  ITE_REFERE,              ';    pAddCol('Referência');
      strSQL := strSQL + '  VOLUME,                  ';    pAddCol('Volume');
      strSQL := strSQL + '  PESTOT,                  ';    pAddCol('Peso Total');
      strSQL := strSQL + '  ORD_PEDIDO,              ';    pAddCol('Pedido de Venda');
      strSQL := strSQL + '  NUMRES,                  ';    pAddCol('Pedido da Reserva Matéria Prima');
      If fCfgSis('ARMAMO', varBoolean) Then
      Begin
        strSQL := strSQL + ' ORD_LOCORP, LOP_DESCRI, ';
        pAddCol('Loc. Fis. Amostra');
        pAddCol('Descrição Loc. Fis. Amostra');
      End;
      strSQL := strSQL + '  AUTOINCREM               ';

      strSQL := strSQL + ' FROM ( SELECT CONCAT(DATE_FORMAT(ORD_DTACAD,"%d%m%y"), ORD_CODORD) AS ORD_NUMLOT, ';
      strSQL := strSQL + '               MAX(ORD_CODORD) AS ORD_CODORD,                            ';
      strSQL := strSQL + '               MAX(ORD_DTACAD) AS ORD_DTACAD,                            ';
      strSQL := strSQL + '               MAX(O.ORD_CODITE) AS ORD_CODITE,                          ';
      strSQL := strSQL + '               MAX(G.ITE_DESITE) AS ITE_DESITE,                          ';
      strSQL := strSQL + '               MAX(ORD_CODCOR) AS ORD_CODCOR,                            ';
      strSQL := strSQL + '               MAX(COR_DESCOR) AS COR_DESCOR,                            ';
      strSQL := strSQL + '               IF(IFNULL(ORD_DTABAI,0) = 0, "NÃO", "SIM") AS ORD_BAIXAD, ';
      strSQL := strSQL + '               MAX(ORD_DTABAI) AS ORD_DTABAI,                            ';
      strSQL := strSQL + '               MAX(G.ITE_REFERE) AS ITE_REFERE,                          ';
      strSQL := strSQL + '               SUM(IF(UNI_KILLIT="K", IF(GMT_PESREA > 0, ((ORD_QTDPRO * UNI_PESLIT) / GMT_PESREA),0), ORD_QTDPRO * UNI_PESLIT )) AS VOLUME, ';
      strSQL := strSQL + '               SUM(IF(UNI_KILLIT="K", ORD_QTDPRO * UNI_PESLIT, ORD_QTDPRO * UNI_PESLIT * GMT_PESREA )) AS   PESTOT,                         ';
      strSQL := strSQL + '               (SELECT GROUP_CONCAT(FDO_NUMDOC SEPARATOR " - ")          ';
      strSQL := strSQL + '                FROM EXTDOR                                              ';
      strSQL := strSQL + '                LEFT JOIN FATDOR ON FATDOR.AUTOINCREM = FDO_SEQFDO      ';
      strSQL := strSQL + '                WHERE FDO_SEQOPI = O.AUTOINCREM ) AS ORD_PEDIDO,         ';
      strSQL := strSQL + ' CONCAT(FATGOR.FGO_NUMDOC, "-", FATGOR.FGO_ESPDOC, "-", FATGOR.FGO_CODEMP) AS NUMRES, ';

      If fCfgSis('ARMAMO', varBoolean) Then
        strSQL := strSQL + '             ORD_LOCORP, LOP_DESCRI,                                   ';
      strSQL := strSQL + '               O.AUTOINCREM                                              ';
      strSQL := strSQL + 'FROM ORDGER O                                           ';
      strSQL := strSQL + 'INNER JOIN ORDDET ON ORD_SEQGER = O.AUTOINCREM          ';
      strSQL := strSQL + 'INNER JOIN CADITE G ON O.ORD_CODITE = G.ITE_CODITE      ';
      strSQL := strSQL + 'INNER JOIN CADITE D ON D.ITE_CODITE = ORDDET.ORD_CODITE ';
      strSQL := strSQL + 'LEFT  JOIN CADUNI ON UNI_CODUNI = D.ITE_CODUNI          ';
      strSQL := strSQL + 'INNER JOIN CADCOR ON ORD_CODCOR = COR_CODCOR            ';
      strSQL := strSQL + 'LEFT  JOIN GEIMAT ON GMT_CODITE = O.ORD_CODITE          ';
      strSQL := strSQL + '                 AND GMT_CODCOR = ORD_CODCOR            ';
      strSQL := strSQL + '                 AND GMT_FORMUL = ORD_FORMUL            ';

      strSQL := strSQL + ' LEFT JOIN EXTGOR ON EXTGOR.FGO_ORDIND = O.AUTOINCREM      ';
      strSQL := strSQL + ' LEFT JOIN FATGOR ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO ';

      If fCfgSis('ARMAMO', varBoolean) Then
        strSQL := strSQL + 'LEFT JOIN LOCORP  ON LOP_LOCFIS = ORD_LOCORP          ';

      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   ORD_CODEMP = ' + QuotedStr(VS_strCodEmp);

      if not fEmptyStr(strCodIte) Then
        strSQL := strSQL + ' AND O.ORD_CODITE = ' + QuotedStr(strCodIte);

      if not fEmptyStr(strCodCor) Then
        strSQL := strSQL + ' AND ORD_CODCOR = ' + QuotedStr(strCodCor);

      Case staState Of
        staAbertas : strSQL := strSQL + ' AND ORD_DTABAI IS NULL ';

        staBaixadas: Begin
                       strSQL := strSQL + ' AND ORD_DTABAI IS NOT NULL ';
                     End;
        Else
          Case fMensagem('','Selecione o status:', ['Abertos', 'Baixados', 'Todos'],1) Of
            1: strSQL := strSQL + ' AND ORD_DTABAI IS NULL ';
            2: strSQL := strSQL + ' AND ORD_DTABAI IS NOT NULL ';
          End;
      End;

      strSQL := strSQL + ' GROUP BY O.AUTOINCREM ) AS TMP ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                    arrTitCol,
                   ['ITE_DESITE','ORD_NUMLOT','O.ORD_CODITE','ORD_CODORD'],
                   '',
                   'ORDGER',
                   Self.Name,
                   'Consulta de Ordens de Produção',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'AUTOINCREM',
                   objConsulta) Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If tpcPsqOPI = poiCodigo Then
          Begin

            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('ORD_CODORD').AsString
            Else
              edtCodigo.Text := qryConsulta.FieldByName('ORD_CODORD').AsString;

            If (edtDescri Is TMaskEditFocus) Then
              (edtDescri As TMaskEditFocus).Text := qryConsulta.FieldByName('ORD_DTACAD').AsString
            Else
              edtDescri.Text := qryConsulta.FieldByName('ORD_DTACAD').AsString;

          End Else
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text :=
                FormatDateTime('DDMMYY', qryConsulta.FieldByName('ORD_DTACAD').AsDateTime) +
                qryConsulta.FieldByName('ORD_CODORD').AsString
            Else
              edtCodigo.Text := FormatDateTime('DDMMYY', qryConsulta.FieldByName('ORD_DTACAD').AsDateTime) +
                                qryConsulta.FieldByName('ORD_CODORD').AsString;

            If Assigned(edtDescri) Then
              edtDescri.Text := qryConsulta.FieldByName('ORD_CODITE').AsString + '-' +
                                fRetNomProduto(qryConsulta.FieldByName('ORD_CODITE').AsString);
          End;
        End;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 9)
            Else
              edtCodigo.Text := fStrZero('0', 9);
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';

        End;

        Result := True;

        If Not Assigned(qryTabela) Then
          FreeAndNil(qryConsulta);

        FreeAndNil(objConsulta);

      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

function fPesqGrupoProduto(Self         : TForm;                            {* Formulário                                  *}
                           edtCodigo    : TCustomEdit;                      {* Edit do Código                              *}
                           edtDescricao : TEditFocus;                       {* Edit da Descrição                           *}
                           qryTabela    : TUniQuery;                        {* Query                                       *}
                           Var chrKey   : Char;                             {* Key                                         *}
                           Var arrSel   : TConsultasArray;                  {* Array de Seleção                            *}
                           blnConSim    : Boolean = True): Boolean;         {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL: String;
    qryConsulta: TUniQuery;
Begin
  Result := False;

  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  PRD_CODGRU,       ';
      strSQL := strSQL + '  PRD_DESGRU,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  GRPPRD            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                   ['Código', 'Descrição', 'AUTOINCREM'],
                   ['PRD_DESGRU', 'PRD_CODGRU'],
                   'PRD_CODGRU',
                   'GRPPRD',
                   Self.Name,
                   'Consulta de Grupo de Produtos',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'PRD_CODGRU') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('PRD_CODGRU').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('PRD_CODGRU').AsString;
        End;

        If Assigned(edtDescricao) Then
          edtDescricao.Text := qryConsulta.FieldByName('PRD_DESGRU').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 5)
            Else
              edtCodigo.Text := fStrZero('0', 5);
          End;

          If Assigned(edtDescricao) Then
            edtDescricao.Text := '+1'
          Else
            edtCodigo.Text := '+1';

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
End;

{****************************}
{* PESQUISA CLASSICAÇÃO ONU *}
{*************************GB*}

function fPesqAltPar(Self     : TForm;                    {* Formulário                                  *}
                     edtDtaAlt: TEditFocus;               {* Edit da Data de Alteração                   *}
                     edtNomCam: TEditFocus;               {* Edit do Nome do Campo                       *}
                     edtValAnt: TEditFocus;               {* Edit do Valor anterior                      *}
                     qryTabela: TUniQuery;                  {* Query                                       *}
                     Var chrKey: Char;                    {* Key                                         *}
                     Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                     strTpPart: String;                   {* Tipo Participante - Cliente/Forn/Consumidor *}
                     strCdPart: String;                   {* Código Participante                         *}
                     blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL,
    strWhere,
    strAutoIncrem: String;
    qryConsulta: TUniQuery;
    objConsulta: TDefConsulta;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      objConsulta := TDefConsulta.Create;
      objConsulta.pIncluiSubConsulta('NOMECAMPO', fSQLNomCam);
      objConsulta.pIncluiSubConsulta('NOME_OPEALT', 'CONCAT(OPE_CODOPE, "-", OPE_NOMOPE)');

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  A.ALT_DTAALT, ';
      strSQL := strSQL + '  NOME_OPEALT, ';
      strSQL := strSQL + '  A.ALT_CONANT, ';
      strSQL := strSQL + '  NOMECAMPO,    ';
      strSQL := strSQL + '  A.AUTOINCREM ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  ALTPAR A          ';
      strSQL := strSQL + '  LEFT JOIN CADOPE OPE ON ';
      strSQL := strSQL + '  OPE.OPE_CODOPE = A.ALT_OPEALT ';
      strSQL := strSQL + '  LEFT JOIN CADFOR FR ON ';
      strSQL := strSQL + '  FR.FOR_CODFOR = A.ALT_CODPAR AND ';
      strSQL := strSQL + '  A.ALT_TIP_FC = "F" ';
      strSQL := strSQL + '  LEFT JOIN CADCLI CLI ON ';
      strSQL := strSQL + '  CLI.CLI_CODCLI = A.ALT_CODPAR AND ';
      strSQL := strSQL + '  A.ALT_TIP_FC = "C" ';
      strSQL := strSQL + '  LEFT JOIN CADCON CON ON ';
      strSQL := strSQL + '  CON.CON_CODCON = A.ALT_CODPAR AND ';
      strSQL := strSQL + '  A.ALT_TIP_FC = "S" ';
      strSQL := strSQL + '  LEFT JOIN CADCLI CONCLI ON ';
      strSQL := strSQL + '  CON.CON_CODCLI = CONCLI.CLI_CODCLI AND ';
      strSQL := strSQL + '  A.ALT_TIP_FC = "S" ';

      If (Not fEmptyStr(strTpPart)) And (Not fEmptyStr(strCdPart)) Then
      Begin
        strWhere := ' WHERE A.ALT_CODPAR = "'+ strCdPart +'"'+
                    ' AND A.ALT_TIP_FC = "'+ strTpPart +'"';
      End;

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL, strWhere],
                  ['Data Alteração',
                   'Operador Alteração',
                   'Conteúdo Anterior',
                   'Nome Campo Alterado',
                   'AUTOINCREM'],
                   ['ALT_DTAALT','NOME_OPEALT'],
                   '',
                   'ALTPAR',
                   Self.Name,
                   'Consulta de Alterações de Participantes',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'AUTOINCREM',
                   objConsulta) Then
      Begin
        strAutoIncrem := qryConsulta.FieldByName('AUTOINCREM').AsString;

        qryConsulta.Close;
        qryConsulta.SQL.Clear;
        qryConsulta.SQL.Add('SELECT A.*,'+ fSQLNomCam + ' AS ALT_NOMCAM FROM ALTPAR A WHERE AUTOINCREM = :AUTOINCREM');
        qryConsulta.ParamByName('AUTOINCREM').AsString := strAutoIncrem;
        qryConsulta.Open;

        If Assigned(edtDtaAlt) Then
          edtDtaAlt.Text := qryConsulta.FieldByName('ALT_DTAALT').AsString;

        If Assigned(edtNomCam) Then
          edtNomCam.Text := qryConsulta.FieldByName('ALT_NOMCAM').AsString;

        If Assigned(edtValAnt) Then
          edtValAnt.Text := qryConsulta.FieldByName('ALT_VALANT').AsString;

        qryConsulta.Close;
        qryConsulta.SQL.Clear;
        qryConsulta.SQL.Add('SELECT * FROM ALTPAR WHERE AUTOINCREM = :AUTOINCREM');
        qryConsulta.ParamByName('AUTOINCREM').AsString := strAutoIncrem;
        qryConsulta.Open;

        If (Length(arrSel) > 1) Then
        Begin
          If Assigned(edtDtaAlt) Then
            edtDtaAlt.Text := '';

          If Assigned(edtNomCam) Then
            edtNomCam.Text := '';

          If Assigned(edtValAnt) Then
            edtValAnt.Text := '';
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


function fSQLNomCam: string;
begin
  Result := '';
  Result := Result + '  CASE WHEN A.ALT_NUMCAM = "03" THEN "NOME" ';
  Result := Result + '       WHEN A.ALT_NUMCAM = "04" THEN "CÓD PAÍS" ';
  Result := Result + '       WHEN A.ALT_NUMCAM = "05" THEN "CNPJ" ';
  Result := Result + '       WHEN A.ALT_NUMCAM = "06" THEN "CPF" ';
  Result := Result + '       WHEN A.ALT_NUMCAM = "07" THEN "INSC. ESTADUAL" ';
  Result := Result + '       WHEN A.ALT_NUMCAM = "08" THEN "CÓD MUNICÍPIO" ';
  Result := Result + '       WHEN A.ALT_NUMCAM = "09" THEN "SUFRAMA" ';
  Result := Result + '       WHEN A.ALT_NUMCAM = "10" THEN "ENDEREÇO" ';
  Result := Result + '       WHEN A.ALT_NUMCAM = "11" THEN "NÚMERO ENDEREÇO" ';
  Result := Result + '       WHEN A.ALT_NUMCAM = "12" THEN "COMPLEMENTO ENDEREÇO" ';
  Result := Result + '   ELSE "BAIRRO" END ';
end;


function fPesqComboVenda(Self: TForm;                            {* Formulario                                  *}
                         edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                         edtDescri: TEditFocus;                  {* Edit da Descrição                           *}
                         qryTabela: TUniQuery;                   {* Query                                       *}
                         Var chrKey: Char;                       {* Key                                         *}
                         Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                         blnConSim: Boolean = True;              {* Consulta Simples ou Múltipla (multi select) *}
                         blnRetCodCom: Boolean = False): Boolean;{* Retorna CodCom ou Autoincrem                *}

  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
    objConsulta : TDefConsulta;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      objConsulta := TDefConsulta.Create;

      strSQL := strSQL + 'SELECT          ';
      strSQL := strSQL + '  EMPRESA,      ';
      strSQL := strSQL + '  C.COM_CODCOM, ';
      strSQL := strSQL + '  C.COM_DESCOM, ';
      strSQL := strSQL + '  C.COM_DTAINI, ';
      strSQL := strSQL + '  C.COM_DTAFIN, ';
      strSQL := strSQL + '  C.AUTOINCREM  ';
      strSQL := strSQL + 'FROM            ';
      strSQL := strSQL + '  COMVEN C      ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      objConsulta.pIncluiSubConsulta('EMPRESA', '(SELECT GROUP_CONCAT(CE.COM_CODEMP) FROM COMEMP CE WHERE CE.COM_SEQGER = C.AUTOINCREM)');

      If fConsulta([strSQL],
                  ['Empresa',
                   'Código',
                   'Descrição',
                   'Data Inicial',
                   'Data Final',
                   'AUTOINCREM'],
                   ['COM_CODCOM'],
                   '',
                   'COMVEN',
                   Self.Name,
                   'Consulta de Combos para Venda',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   IIf(blnRetCodCom, 'COM_CODCOM','AUTOINCREM'),
                   objConsulta) Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('COM_CODCOM').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('COM_CODCOM').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := AnsiReplaceStr(qryConsulta.FieldByName('COM_DESCOM').AsString, '<<csq>>', ' ');

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := '0'
            Else
              edtCodigo.Text := fStrZero('0', 7);
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';

        End;

        Result := True;

        If Not Assigned(qryTabela) Then
          FreeAndNil(qryConsulta);
        FreeAndNil(objConsulta);
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
End;

{ TDefConsultaPedidoCompra }

constructor TDefConsultaPedidoCompra.Create;
begin
  cxsRed    := TcxStyle.Create(Nil);
  cxsRed.TextColor := clRed;

  cxsBlue := TcxStyle.Create(Nil);
  cxsBlue.TextColor := clBlue;

  cxsBlack  := TcxStyle.Create(Nil);
  cxsBlack.TextColor := clBlack;


end;

destructor TDefConsultaPedidoCompra.Destroy;
begin
  FreeAndNil(cxsRed);
  FreeAndNil(cxsBlue);
  FreeAndNil(cxsBlack);

  Inherited Destroy;

end;

function TDefConsultaPedidoCompra.fGetCellStyle(AView: TcxGridDBTableView;
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
  ADataSet: TDataSet): TcxStyle;
  Var
    ARowInfo: TcxRowInfo;

  function fIdxColumn(strCampo: String): Integer;
  begin
    Result := -1;

    {********************************************************}
    {* ESSA FUNÇAO TEVE DE ALTERAR O COMPONENTE DEV-EXPRESS *}
    {* SE ESTA OCORRENDO ERRO DE TYPECAST VC DEVE VERIFICAR *}
    {* NOS COMPONENTES SE A CORREÇÃO FOI APLICADA EM SUA    *}
    {* MÁQUINA                                              *}
    {*****************************************************AF*}
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

  If ARecord.IsData And (ARecord.Index > -1) Then
  Begin
    If (fGetValor(fIdxColumn('PCG_STATUS')) = 'NÃO RECEB.') And
        (fGetValor(fIdxColumn('PCG_DTAENT')) < VS_Date)  Then
      Result := cxsRed
    Else
    If (fGetValor(fIdxColumn('PCG_STATUS')) = 'RECEB. PARC.') And
        (fGetValor(fIdxColumn('PCG_DTAENT')) < VS_Date)  Then
      Result := cxsBlue
    Else
      Result := cxsBlack;

  End;

end;
Constructor TDefConsultaPortadores.Create;
  Var
    strPorOpe: String;
Begin

  cxsPorOpe := TcxStyle.Create(Nil);
  cxsPorOpe.TextColor := clRed;

  strPorOpe := '';
  strPorOpe := strPorOpe + '  (SELECT SQL_NO_CACHE ';
  strPorOpe := strPorOpe + '     P.POR_CODPOR      ';
  strPorOpe := strPorOpe + '   FROM                ';
  strPorOpe := strPorOpe + '     CADPOR P          ';
  strPorOpe := strPorOpe + '   WHERE               ';
  strPorOpe := strPorOpe + '     LOCATE(POR_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0 ';

  pIncluiSubConsulta('POR_CODPOR_', strPorOpe);
  pIncluiDefMascara('POR_PLANCO', pDisplayPlanoContabil);
End;

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

  If ARecord.IsData And (ARecord.Index > -1) Then
  Begin

    If Pos(fGetValor(fIdxColumn('POR_CODPOR')), strPortadoresOperador) <= 0  Then
      Result := cxsPorOpe;

  End;
end;

procedure TDefConsultaPortadores.pDisplayPlanoContabil(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  if Assigned(fMskCon) then
    AText := FormatMaskText(fMskCon, AText);
end;



{ TDefConsultaPed }

constructor TDefConsultaPed.Create;
begin
  // PEDIDOS DE PRETO
  cxPedBlue := TcxStyle.Create(Nil);
  cxPedBlue.TextColor := clBlue;

  // PEDIDO DE ORDEM DE SERVICO EM AZUL
  cxPedBlack := TcxStyle.Create(Nil);
  cxPedBlack.TextColor := clBlack;

  // PEDIDO DE VENDA BAIXADOS PARCIALMENTE
  cxPedPurple := TcxStyle.Create(Nil);
  cxPedPurple.TextColor := clPurple;
end;

destructor TDefConsultaPed.Destroy;
begin
  FreeAndNil(cxPedBlue);
  FreeAndNil(cxPedBlack);
  FreeAndNil(cxPedPurple);
  inherited;
end;

function TDefConsultaPed.fGetCellStyle(AView: TcxGridDBTableView;
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

  If ARecord.IsData And (ARecord.Index > -1) Then
  Begin
    If (fGetValor(fIdxColumn('TIPO_DOC_TMP')) = 'OS') Then
      Result := cxPedBlue
    Else
    Begin
      If (fGetValor(fIdxColumn('PEDPAR')) = 'P') Then
        Result := cxPedPurple
      Else
        Result := cxPedBlack;
    End;
  End;
end;

function fPesqColorantes(Self: TForm; opcConsulta: TTipoTintas; edtCodCol, edtCodIte: TCustomEdit; qryTabela: TUniQuery; Var chrKey: Char;
                         Var arrSel: TConsultasArray;  blnConSim: Boolean = True; strFiltros: string = ''; CampoRelacionamento: String = ''; blnComProdutos: boolean = True): Boolean;
  Var
    consTinta: TGerenciaConsultaColorante;
    qryConsulta: TUniQuery;
Begin
  Result := False;
  If Not fEntraCons(chrKey) Then
    Exit;

  chrKey := #0;

  consTinta:= TGerenciaConsultaColorante.Create(opcConsulta, CampoRelacionamento, blnComProdutos);
  Try
    Try
      If Not Assigned(qryTabela) Then
         qryConsulta := fCriaQuery(Nil)
      Else
         qryConsulta := qryTabela;
      If fConsulta([consTinta.strSQL, consTinta.strWhere + ' ' + strFiltros , consTinta.strGroup],
                      consTinta.arrTitCol,
                      consTinta.arrCampoFiltro,
                      'AUTOINCREM',
                      consTinta.strTabela,
                      Self.Name,
                      consTinta.strTituloTela + ' - ' + consTinta.strNomeTinta,
                      qryConsulta,
                      Nil,
                      blnConSim,
                      arrSel,
                      'AUTOINCREM',
                      consTinta.objConsulta) Then
      Begin
        if Assigned(edtCodCol) Then
           edtCodCol.Text := qryConsulta.FieldByName('COL_CODCOL').AsString;
        if Assigned(edtCodIte) Then
           edtCodIte.Text := qryConsulta.FieldByName('COL_CODITE').AsString;
        Result := True;

        If Not Assigned(qryTabela) Then
          FreeAndNil(qryConsulta)
        else
          consTinta.pFormatarCampos(qryTabela);
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  Finally
    FreeAndNil(consTinta);
  End;

End;

function fPesqBaseTinta(Self: TForm;
                          opcConsulta: TTipoTintas;
                          edtBase,
                          edtDescBase: TCustomEdit; {Ver Descricao no Comentario da untConsultasTinta para Este Parametro em TGerenciaConsultasBaseTinta.strCampoGenerico}
                          qryTabela: TUniQuery;
                          Var chrKey: Char;
                          Var arrSel: TConsultasArray;
                          blnConSim: Boolean = True;
                          strFiltros: string = '';
                          CampoRelacionamento: string = '';
                          blnComProdutos: boolean = True): Boolean;
  var
    consTinta: TGerenciaConsultasBaseTinta;
    qryConsulta: TUniQuery;
Begin
  Result := False;
  If Not fEntraCons(chrKey) Then
    Exit;

  chrKey := #0;
  consTinta:= TGerenciaConsultasBaseTinta.Create(opcConsulta, CampoRelacionamento, blnComProdutos);
  Try
    Try
      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;
      If fConsulta([consTinta.strSQL, consTinta.strWhere + ' ' + strFiltros , consTinta.strGroup],
                      consTinta.arrTitCol,
                      consTinta.arrCampoFiltro,
                      'AUTOINCREM',
                      consTinta.strTabela,
                      Self.Name,
                      consTinta.strTituloTela + ' - ' + consTinta.strNomeTinta,
                      qryConsulta,
                      Nil,
                      blnConSim,
                      arrSel,
                      'AUTOINCREM',
                      consTinta.objConsulta) Then
      Begin

        If Assigned(edtBase) Then
           edtBase.Text := qryConsulta.FieldByName(consTinta.strCampoBase).AsString;
        If Assigned(edtDescBase) Then
           edtDescBase.Text := qryConsulta.FieldByName(consTinta.strCampoDescricaoBase).AsString;

        Result := True;

        If Not Assigned(qryTabela) Then
           FreeAndNil(qryConsulta)
        else
          consTinta.pFormatarCampos(qryTabela);

      End;
    Except
      On E: Exception Do
         pMensagensErro(E.Message, '');
    End;
  Finally
    FreeAndNil(consTinta);
  End;
end;

function fPesqEmbalagemUnidadeTinta(Self: TForm;
                        opcConsulta: TTipoTintas;
                        edtCodEmabalagem,
                        edtCodUnidade,
                        edtQuantidade: TCustomEdit;
                        strFiltro: String; {Campo de Filtro para quando o }
                        qryTabela: TUniQuery;
                        Var chrKey: Char;
                        Var arrSel: TConsultasArray;
                        blnConSim: Boolean = True): Boolean;
  var
    consTinta: TGerenciaConsultaEmbalagemTinta;
    qryConsulta: TUniQuery;
Begin
  Result := False;
  If Not fEntraCons(chrKey) Then
    Exit;

  chrKey := #0;
  consTinta := TGerenciaConsultaEmbalagemTinta.Create(opcConsulta);
  Try
    Try
      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;
      If fConsulta([consTinta.strSQL, consTinta.strWhere + ' ' + strFiltro, consTinta.strGroup],
                      consTinta.arrTitCol,
                      consTinta.arrCampoFiltro,
                      'AUTOINCREM',
                      consTinta.strTabela,
                      Self.Name,
                      consTinta.strTituloTela + ' - ' + consTinta.strNomeTinta,
                      qryConsulta,
                      Nil,
                      blnConSim,
                      arrSel) Then
      Begin
        If (Assigned(edtCodEmabalagem)) and (consTinta.strCodEmbalagem <> '') Then
           edtCodEmabalagem.Text := qryConsulta.FieldByName(consTinta.strCodEmbalagem).AsString;
        If (Assigned(edtCodUnidade)) and (consTinta.strCodUnidade <> '')Then
           edtCodUnidade.Text := qryConsulta.FieldByName(consTinta.strCodUnidade).AsString;
        If (Assigned(edtQuantidade)) and (consTinta.strQuantidade <> '') Then
           edtQuantidade.Text := qryConsulta.FieldByName(consTinta.strQuantidade).AsString;

        Result := True;

        If Not Assigned(qryTabela) Then
           FreeAndNil(qryConsulta)
        else
          consTinta.pFormatarCampos(qryTabela);

      End;
    Except
      On E: Exception Do
         pMensagensErro(E.Message, '');
    End;
  Finally
    FreeAndNil(consTinta);
  End;

end;

function fPesqEmbalagens(self: TForm; strNomeTabela: string;  edtCodEmb,  edtQuanti, edtUnidad: TCustomEdit;
         qryTabela: TUniQuery; Var chrKey: Char; Var arrSel: TConsultasArray; blnConSim: Boolean = True): Boolean;

  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
    objConsulta: TDefConsulta;
    arrTitCol: TColunasArray;
    sOrdenacao: string;
    consTinta: TGerenciaNomeTintaPesqEmbalagens;

  Procedure pAddNomeColuna(strNomCol: String);
  Begin
    SetLength(arrTitCol, Succ(Length(arrTitCol)));
    arrTitCol[High(arrTitCol)] := strNomCol;
  End;
Begin
  Result := False;
  If Not fEntraCons(chrKey) Then
    Exit;

  chrKey := #0;

  consTinta:= TGerenciaNomeTintaPesqEmbalagens.Create(strNomeTabela);
  Try
    strSQL := '';
    strSQL := strSQL + ' SELECT       ';
    strSQL := strSQL + '  EMB_CODEMB, '; pAddNomeColuna('Código da Embalagem');
    strSQL := strSQL + '  EMB_QTDEMB, '; pAddNomeColuna('Quantidade');
    strSQL := strSQL + '  EMB_UNIDAD, '; pAddNomeColuna('Unidade');
    strSQL := strSQL + '  AUTOINCREM  ';
    strSQL := strSQL + ' FROM         ';
    strSQL := strSQL + strNomeTabela;

    objConsulta := TDefConsulta.Create;
    sOrdenacao := 'EMB_CODEMB';

    pAddNomeColuna('Base');
    objConsulta.pIncluiSubConsulta('Código da Embalagem', 'EMB_CODEMB');
    objConsulta.pIncluiSubConsulta('Quantidade', 'EMB_QTDEMB');
    objConsulta.pIncluiSubConsulta('Unidade', 'EMB_UNIDAD');

    If Not Assigned(qryTabela) Then
      qryConsulta := fCriaQuery(Nil)
    Else
      qryConsulta := qryTabela;

    If fConsulta([strSQL],
                 arrTitCol,
                 [sOrdenacao],
                 'AUTOINCREM',
                 strNomeTabela,
                 Self.Name,
                 'Consulta de Embalagens' + ' - ' + consTinta.strNomeTintaEmb, //Alterar aqui
                 qryConsulta,
                 Nil,
                 blnConSim,
                 arrSel,
                 'AUTOINCREM',
                 objConsulta) Then
    Begin
      edtCodEmb.Text := qryConsulta.FieldByName('EMB_CODEMB').AsString;
      edtQuanti.Text := qryConsulta.FieldByName('EMB_QTDEMB').AsString;
      edtUnidad.Text := qryConsulta.FieldByName('EMB_UNIDAD').AsString;
      Result := True;
      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);
      FreeAndNil(objConsulta);
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;
End;


function fPesqFormulaTinta(self: TForm;
                        opcConsulta: TTipoTintas;
                        edtCodFormula: TCustomEdit;
                        qryTabela: TUniQuery;
                        Var chrKey: Char;
                        Var arrSel: TConsultasArray;
                        blnConSim: Boolean = True;
                        strFiltros: String = ''): Boolean;
  Var
    consTinta: TGerenciaConsultaNovasFormulas;
    qryConsulta: TUniQuery;
Begin
  Result := False;
  If Not fEntraCons(chrKey) Then
    Exit;

  chrKey := #0;
  consTinta:= TGerenciaConsultaNovasFormulas.Create(opcConsulta);
  Try
    Try
      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;
      If fConsulta([consTinta.strSQL, consTinta.strWhere + ' ' + strFiltros , consTinta.strGroup],
                      consTinta.arrTitCol,
                      consTinta.arrCampoFiltro,
                      'AUTOINCREM',
                      consTinta.strTabela,
                      Self.Name,
                      consTinta.strTituloTela + ' - ' + consTinta.strNomeTinta,
                      qryConsulta,
                      Nil,
                      blnConSim,
                      arrSel) Then
      Begin
        If Assigned(edtCodFormula) Then
           edtCodFormula.Text := qryConsulta.FieldByName(consTinta.strCodigoFormula).AsString;

        Result := True;

        If Not Assigned(qryTabela) Then
           FreeAndNil(qryConsulta)
        else
          consTinta.pFormatarCampos(qryTabela);

      End;
    Except
      On E: Exception Do
         pMensagensErro(E.Message, '');
    End;
  Finally
    FreeAndNil(consTinta);
  End;
End;


function fPesqSkyGrupoTinta(Self: TForm;
                         edtCodGru: TCustomEdit;
                         qryTabela: TUniQuery;
                         Var chrKey: Char;
                         Var arrSel: TConsultasArray;
                         blnConSim: Boolean = True): Boolean;
  var
    strSQL     : String;
    qryConsulta: TUniQuery;
    objConsulta: TDefConsulta;
    arrTitCol: TColunasArray;
    sOrdenacao: string;

  Procedure pAddNomeColuna(strNomCol: String);
  Begin
    SetLength(arrTitCol, Succ(Length(arrTitCol)));
    arrTitCol[High(arrTitCol)] := strNomCol;
  End;

Begin
  Result := False;

  If Not fEntraCons(chrKey) Then
    Exit;

  chrKey := #0;

  Try
    strSQL := '';
    strSQL := strSQL + ' SELECT  ';
    strSQL := strSQL + ' 	GRU_CODGRU, '; pAddNomeColuna('Código');
    strSQL := strSQL + ' 	GRU_VALIDA, '; pAddNomeColuna('Validade');
    strSQL := strSQL + ' 	GRU_LINHA_, '; pAddNomeColuna('Linha');
    strSQL := strSQL + ' 	GRU_MARCA_, '; pAddNomeColuna('Marca');
    strSQL := strSQL + '  AUTOINCREM ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + ' 	SKY_CADGRU ';
//    strSQL := strSQL + ' WHERE ';
//    strSQL := strSQL + ' 	TRUE ';

    objConsulta := TDefConsulta.Create;
    sOrdenacao := 'GRU_CODGRU';

    objConsulta.pIncluiSubConsulta('Código',   'GRU_CODGRU');
    objConsulta.pIncluiSubConsulta('Validade', 'GRU_VALIDA');
    objConsulta.pIncluiSubConsulta('Linha',    'GRU_LINHA_');
    objConsulta.pIncluiSubConsulta('Marca',    'GRU_MARCA_');
    objConsulta.pIncluiSubConsulta('Unidade',  'BAS_CODUNI');

    If Not Assigned(qryTabela) Then
      qryConsulta := fCriaQuery(Nil)
    Else
      qryConsulta := qryTabela;

    If fConsulta([strSQL],
                 arrTitCol,
                 [sOrdenacao],
                 'AUTOINCREM',
                 'SKY_CADGRU',
                 Self.Name,
                 'Consulta de Grupos -  Tintas',
                 qryConsulta,
                 Nil,
                 blnConSim,
                 arrSel,
                 'AUTOINCREM',
                 objConsulta) Then
    Begin
      If Assigned(edtCodGru) Then
         edtCodGru.Text := qryConsulta.FieldByName('GRU_CODGRU').AsString;

      Result := True;
      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);
      FreeAndNil(objConsulta);
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;


end;

function fPesqSkySubGrupoTinta(Self: TForm;
                         edtCodGru: TCustomEdit;
                         qryTabela: TUniQuery;
                         Var chrKey: Char;
                         Var arrSel: TConsultasArray;
                         blnConSim: Boolean = True): Boolean;
  var
    strSQL     : String;
    qryConsulta: TUniQuery;
    objConsulta: TDefConsulta;
    arrTitCol: TColunasArray;
    sOrdenacao: string;

  Procedure pAddNomeColuna(strNomCol: String);
  Begin
    SetLength(arrTitCol, Succ(Length(arrTitCol)));
    arrTitCol[High(arrTitCol)] := strNomCol;
  End;

Begin
  Result := False;
  If Not fEntraCons(chrKey) Then
    Exit;

  chrKey := #0;


  Try
    strSQL := '';

    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + ' 	SGR_CODSGR, '; pAddNomeColuna('Código');
    strSQL := strSQL + ' 	SGR_ASPECT, '; pAddNomeColuna('Aspecto');
    strSQL := strSQL + '  AUTOINCREM ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + ' 	SKY_CADSGR ';
//    strSQL := strSQL + ' WHERE ';
//    strSQL := strSQL + ' 	TRUE ';

    objConsulta := TDefConsulta.Create;
    sOrdenacao := 'GRU_CODGRU';

    objConsulta.pIncluiSubConsulta('Código',   'SGR_CODSGR');
    objConsulta.pIncluiSubConsulta('Aspecto', 'SGR_ASPECT');
    If Not Assigned(qryTabela) Then
      qryConsulta := fCriaQuery(Nil)
    Else
      qryConsulta := qryTabela;

    If fConsulta([strSQL],
                 arrTitCol,
                 [sOrdenacao],
                 'AUTOINCREM',
                 'SKY_CADSGR',
                 Self.Name,
                 'Consulta de SubGrupos - Tintas',
                 qryConsulta,
                 Nil,
                 blnConSim,
                 arrSel,
                 'AUTOINCREM',
                 objConsulta) Then
    Begin
      If Assigned(edtCodGru) Then
         edtCodGru.Text := qryConsulta.FieldByName('SGR_CODSGR').AsString;

      Result := True;
      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);
      FreeAndNil(objConsulta);
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;
end;

function fPesqMontadoraTinta(Self: TForm;
                             opcConsulta: TTipoTintas;
                             edtCodMontadora,
                             edtDesMontadora: TCustomEdit;
                             qryTabela: TUniQuery;
                             Var chrKey: Char;
                             Var arrSel: TConsultasArray;
                             blnConSim: Boolean = True): Boolean;

  var
    consTinta: TGerenciaConsultaMontadora;
    qryConsulta: TUniQuery;
Begin
  Result := False;
  If Not fEntraCons(chrKey) Then
    Exit;

  chrKey := #0;
  consTinta := TGerenciaConsultaMontadora.Create(opcConsulta);
  Try
    Try
      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;
      If fConsulta([consTinta.strSQL, consTinta.strWhere, consTinta.strGroup],
                      consTinta.arrTitCol,
                      consTinta.arrCampoFiltro,
                      'AUTOINCREM',
                      consTinta.strTabela,
                      Self.Name,
                      consTinta.strTituloTela + ' - ' + consTinta.strNomeTinta,
                      qryConsulta,
                      Nil,
                      blnConSim,
                      arrSel) Then
      Begin


        If Assigned(edtCodMontadora) Then
          edtCodMontadora.Text := qryConsulta.FieldByName(consTinta.strCodMontadora).AsString;

        If Assigned(edtDesMontadora) Then
          edtDesMontadora.Text := qryConsulta.FieldByName(consTinta.strDesMontadora).AsString;

        Result := True;

        If Not Assigned(qryTabela) Then
           FreeAndNil(qryConsulta)
        else
          consTinta.pFormatarCampos(qryTabela);

      End;
    Except
      On E: Exception Do
         pMensagensErro(E.Message, '');
    End;
  Finally
    FreeAndNil(consTinta);
  End;
End;

function fPesqLinhaTinta(Self: TForm;
                             opcConsulta: TTipoTintas;
                             edtCodLinha,
                             edtDesLinha: TCustomEdit;
                             qryTabela: TUniQuery;
                             Var chrKey: Char;
                             Var arrSel: TConsultasArray;
                             blnConSim: Boolean = True): Boolean;
Var
  consTinta: TGerenciaConsultaLinha;
  qryConsulta: TUniQuery;
Begin
  Result := False;
  If Not fEntraCons(chrKey) Then
    Exit;

  chrKey := #0;
  consTinta := TGerenciaConsultaLinha.Create(opcConsulta);
  Try
    Try
      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;
      If fConsulta([consTinta.strSQL, consTinta.strWhere, consTinta.strGroup],
                      consTinta.arrTitCol,
                      consTinta.arrCampoFiltro,
                      'AUTOINCREM',
                      consTinta.strTabela,
                      Self.Name,
                      consTinta.strTituloTela + ' - ' + consTinta.strNomeTinta,
                      qryConsulta,
                      Nil,
                      blnConSim,
                      arrSel) Then
      Begin


        If Assigned(edtCodLinha) Then
          edtCodLinha.Text := qryConsulta.FieldByName(consTinta.strCodLinha).AsString;

        If Assigned(edtDesLinha) Then
          edtDesLinha.Text := qryConsulta.FieldByName(consTinta.strDesLinha).AsString;

        Result := True;

        If Not Assigned(qryTabela) Then
           FreeAndNil(qryConsulta)
        else
          consTinta.pFormatarCampos(qryTabela);

      End;
    Except
      On E: Exception Do
         pMensagensErro(E.Message, '');
    End;
  Finally
    FreeAndNil(consTinta);
  End;
End;


function fPesqAcabamentosTinta(Self: TForm;
                               opcConsulta: TTipoTintas;
                               qryTabela: TUniQuery;
                               Var chrKey: Char;
                               Var arrSel: TConsultasArray;
                               blnConSim: Boolean = True): Boolean;

  var
    consTinta: TGerenciaConsultaAcabamentos;
    qryConsulta: TUniQuery;
Begin
  Result := False;
  If Not fEntraCons(chrKey) Then
    Exit;

  chrKey := #0;
  consTinta := TGerenciaConsultaAcabamentos.Create(opcConsulta);
  Try
    Try
      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;
      If fConsulta([consTinta.strSQL, consTinta.strWhere, consTinta.strGroup],
                      consTinta.arrTitCol,
                      consTinta.arrCampoFiltro,
                      'AUTOINCREM',
                      consTinta.strTabela,
                      Self.Name,
                      consTinta.strTituloTela + ' - ' + consTinta.strNomeTinta,
                      qryConsulta,
                      Nil,
                      blnConSim,
                      arrSel) Then
      Begin
        Result := True;

        If Not Assigned(qryTabela) Then
           FreeAndNil(qryConsulta)
        else
          consTinta.pFormatarCampos(qryTabela);
      End;
    Except
      On E: Exception Do
         pMensagensErro(E.Message, '');
    End;
  Finally
    FreeAndNil(consTinta);
  End;
End;


function fPesqMZA_CADLIN(Self: TForm;
                         edtLinCod: TCustomEdit;
                         qryTabela: TUniQuery;
                         Var chrKey: Char;
                         Var arrSel: TConsultasArray;
                         blnConSim: Boolean = True): Boolean;
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
    arrTitCol: TColunasArray;
    sOrdenacao: string;

  Procedure pAddNomeColuna(strNomCol: String);
  Begin
    SetLength(arrTitCol, Succ(Length(arrTitCol)));
    arrTitCol[High(arrTitCol)] := strNomCol;
  End;

Begin
  Result := False;
  If Not fEntraCons(chrKey) Then
    Exit;

  Try
    chrKey := #0;
    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   LIN_CODIGO,  '; pAddNomeColuna('Código');
    strSQL := strSQL + '   LIN_DESCRI,  '; pAddNomeColuna('Descrição');
    strSQL := strSQL + '   LIN_VOLUME,  '; pAddNomeColuna('Volume');
    strSQL := strSQL + '   AUTOINCREM ';
    strSQL := strSQL + ' FROM MZA_CADLIN ';

    sOrdenacao := 'LIN_CODIGO';

    If Not Assigned(qryTabela) Then
      qryConsulta := fCriaQuery(Nil)
    Else
      qryConsulta := qryTabela;

    If fConsulta([strSQL],
                 arrTitCol,
                 ['LIN_DESCRI'],
                 'AUTOINCREM',
                 'MZA_CADLIN',
                 Self.Name,
                 'Consulta de Linha - Tintas',
                 qryConsulta,
                 Nil,
                 blnConSim,
                 arrSel) Then
    Begin
      If Assigned(edtLinCod) Then
         edtLinCod.Text := qryConsulta.FieldByName('LIN_CODIGO').AsString;

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

function fPesqMZD_CADLIN(Self: TForm;
                         edtLinCod: TCustomEdit;
                         qryTabela: TUniQuery;
                         Var chrKey: Char;
                         Var arrSel: TConsultasArray;
                         blnConSim: Boolean = True): Boolean;
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
    arrTitCol: TColunasArray;
    sOrdenacao: string;

  Procedure pAddNomeColuna(strNomCol: String);
  Begin
    SetLength(arrTitCol, Succ(Length(arrTitCol)));
    arrTitCol[High(arrTitCol)] := strNomCol;
  End;

Begin
  Result := False;
  If Not fEntraCons(chrKey) Then
    Exit;

  Try
    chrKey := #0;
    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   LIN_CODIGO,  '; pAddNomeColuna('Código');
    strSQL := strSQL + '   LIN_DESCRI,  '; pAddNomeColuna('Descrição');
    strSQL := strSQL + '   LIN_VOLUME,  '; pAddNomeColuna('Volume');
    strSQL := strSQL + '   AUTOINCREM ';
    strSQL := strSQL + ' FROM MZD_CADLIN ';

    sOrdenacao := 'LIN_CODIGO';

    If Not Assigned(qryTabela) Then
      qryConsulta := fCriaQuery(Nil)
    Else
      qryConsulta := qryTabela;

    If fConsulta([strSQL],
                 arrTitCol,
                 ['LIN_DESCRI'],
                 'AUTOINCREM',
                 'MZD_CADLIN',
                 Self.Name,
                 'Consulta de Linha - Tintas',
                 qryConsulta,
                 Nil,
                 blnConSim,
                 arrSel) Then
    Begin
      If Assigned(edtLinCod) Then
         edtLinCod.Text := qryConsulta.FieldByName('LIN_CODIGO').AsString;

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


function fPesqGenericaTinta(Self: TForm;
                            strTabela: String;
                            qryTabela: TUniQuery;
                            var chrKey: char;
                            var arrSel: TConsultasArray;
                            blnConSim: Boolean = True;
                            campoAgrupador: string = '';
                            strFiltros: string = '';
                            blnComProdutos: Boolean = True): Boolean;
  Var
    ObjLocaliza: TLocalizaPesquisa;
Begin
  Result := False;
  ObjLocaliza := TLocalizaPesquisa.fLocalizaOpcConsulta(strTabela);
  Try
    Case ObjLocaliza.TipoPesquisa Of
      tpAcabamentos : Result := fPesqAcabamentosTinta(Self, ObjLocaliza.opcConsulta, qryTabela, chrKey, arrSel, blnConSim);
      tpMontadora: Result := fPesqMontadoraTinta(Self, ObjLocaliza.opcConsulta, Nil, Nil, qryTabela, chrKey, arrSel, blnConSim);
      tpBase: Result := fPesqBaseTinta(Self, ObjLocaliza.opcConsulta, Nil, Nil, qryTabela, chrKey, arrSel, blnConSim, strFiltros, campoAgrupador, blnComProdutos);
      tpColorante: Result := fPesqColorantes(Self, ObjLocaliza.opcConsulta, nil, Nil, qryTabela, chrKey, arrSel, blnConSim, strFiltros, campoAgrupador, blnComProdutos);
      tpFormula: Result := fPesqFormulaTinta(Self, ObjLocaliza.opcConsulta, nil, qryTabela, chrKey, arrSel, blnConSim, strFiltros);
      tpEmbalagem: Result := fPesqEmbalagemUnidadeTinta(Self, ObjLocaliza.opcConsulta, nil, nil, nil, strFiltros, qryTabela, chrKey, arrSel, blnConSim);
      tpLinha: Result := fPesqLinhaTinta(Self, ObjLocaliza.opcConsulta, Nil, Nil, qryTabela, chrKey, arrSel, blnConSim);
    End;
  Finally
    FreeAndNil(ObjLocaliza);
  End;
End;

function fPesqCadastroTintas(Self: TForm;
                             opcConsulta: TTipoTintas;
                             qryTabela: TUniQuery;
                             Var chrKey: Char;
                             Var arrSel: TConsultasArray;
                             blnConSim: Boolean = True): Boolean;
Var
    consTinta: TGerenciaConsultaCadastro;
    qryConsulta: TUniQuery;
Begin
  Result := False;
  If Not fEntraCons(chrKey) Then
    Exit;

  chrKey := #0;
  consTinta := TGerenciaConsultaCadastro.Create(opcConsulta);
  Try
    If Not Assigned(qryTabela) Then
      qryConsulta := fCriaQuery(Nil)
    Else
      qryConsulta := qryTabela;
    If fConsulta([consTinta.strSQL, consTinta.strWhere, consTinta.strGroup],
                    consTinta.arrTitCol,
                    consTinta.arrCampoFiltro,
                    'AUTOINCREM',
                    consTinta.strTabela,
                    Self.Name,
                    consTinta.strTituloTela + ' - ' + consTinta.strNomeTinta,
                    qryConsulta,
                    Nil,
                    blnConSim,
                    arrSel,
                    'AUTOINCREM',
                    consTinta.objConsulta) Then
      Result := True;
      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);
      FreeAndNil(consTinta);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;
End;

function fPesqItemBase(Self: TForm;
                       edtCodBas,
                       edtDescri: TCustomEdit;
                       qryTabela: TUniQuery;
                       Var chrKey: Char;
                       Var arrSel: TConsultasArray): Boolean;
  Var
    objConsulta: TDefConsulta;
    qryConsulta: TUniQuery;
    strSql, strSQLWhere: String;
    strSQLSubC: String;
    arrTitCol: Array of String;

  Procedure pAddNomeColuna(strNomCol: String);
  Begin
    SetLength(arrTitCol, Succ(Length(arrTitCol)));
    arrTitCol[High(arrTitCol)] := strNomCol;
  End;
Begin

  Result := False;
  If Not fEntraCons(chrKey) Then
    Exit;
  chrKey := #0;
  objConsulta := TDefConsulta.Create;
  Try
    If Not Assigned(qryTabela) Then
      qryConsulta := fCriaQuery(Nil)
    Else
      qryConsulta := qryTabela;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  I.ITE_CODITE, ';  pAddNomeColuna('Codigo');
    strSQL := strSQL + '  I.ITE_DESITE, ';  pAddNomeColuna('Descrição');
    strSQL := strSQL + '  I.ITE_REFERE, ';  pAddNomeColuna('Referência');
    strSQL := strSQL + '  G.ITE_PREVE1, ';  pAddNomeColuna('Preço Venda');
    strSQL := strSQL + '  M.MAR_DESMAR, ';  pAddNomeColuna('MARCA');
    strSQL := strSQL + '  SALDONUMERIC, ';  pAddNomeColuna('Saldo Numerico');
    strSQL := strSQL + '  I.ITE_CODSIM, ';
    strSQL := strSQL + '  G.ITE_SALDOS, ';
    strSQL := strSQL + '  G.ITE_PREVE1, ';
    strSQL := strSQL + '  G.ITE_PREVE2, ';

    strSQLSubC := '(SELECT ';
    strSQLSubC := strSQLSubC + '  COUNT(*) AS QTD ';
    strSQLSubC := strSQLSubC + 'FROM ';
    strSQLSubC := strSQLSubC + '  CADPRO ';
    strSQLSubC := strSQLSubC + '  INNER JOIN ITEPRO ON CADPRO.AUTOINCREM = ITEPRO.IPR_SEQGER ';
    strSQLSubC := strSQLSubC + '  INNER JOIN PROEMP ON CADPRO.AUTOINCREM = PROEMP.PRO_SEQGER ';
    strSQLSubC := strSQLSubC + 'WHERE ';
    strSQLSubC := strSQLSubC + '  PROEMP.PRO_CODEMP = G.ITE_CODEMP AND ';
    strSQLSubC := strSQLSubC + '  IPR_CODITE = G.ITE_CODITE AND ';
    strSQLSubC := strSQLSubC + '  CURRENT_DATE BETWEEN PRO_DTAINI AND PRO_DTAFIN)';

    objConsulta.pIncluiSubConsulta('SALDONUMERIC','ROUND(G.ITE_SALDOS, 3)');

    objConsulta.pIncluiSubConsulta('PROMOC', strSQlSubC);

    strSQLSubC := '(SELECT   COUNT(*) AS QTD GERMAT WHERE I.ITE_CODITE = GMT_CODITE)';

    objConsulta.pIncluiSubConsulta('ESTRUT', strSQlSubC);

    strSQL := strSQL + '  IF(I.ITE_ITEATI = "S", "ATIVO", "INATIVO") AS ITE_ITEATI, ';
    strSQL := strSQL + '  DATEDIFF(CURRENT_DATE, G.ITE_DTAUVE) AS "ULTVEN", ';
    strSQL := strSQL + '  I.ITE_MSGLV1, ';
    strSQL := strSQL + '  I.ITE_MSGLV2, ';
    strSQL := strSQL + '  I.AUTOINCREM AS AUTOINCREM ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE I, ';
    strSQL := strSQL + '  ITEGER G, ';
    strSQL := strSQL + '  CADMAR M ';
    strSQLWhere := 'WHERE ';
    strSQLWhere := strSQLWhere + '  I.ITE_ITEBAS = "S" AND ';
    strSQLWhere := strSQLWhere + '  I.ITE_CODMAR = M.MAR_CODMAR AND ';
    strSQLWhere := strSQLWhere + '  I.ITE_CODITE = G.ITE_CODITE AND ';
    strSQLWhere := strSQLWhere + '  G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';

    If fConsulta([strSQL, strSQLWhere],
                   arrTitCol,
                   ['ITE_DESITE'],
                   'AUTOINCREM',
                   'CADITE',
                   Self.Name,
                   'Consulta de Item Bases',
                   qryConsulta,
                   Nil,
                   True,
                   arrSel,
                   'AUTOINCREM',
                   objConsulta) Then
    begin
      Result := True;
      If Assigned(edtCodBas) Then
        edtCodBas.Text := qryConsulta.FieldByName('ITE_CODITE').AsString;
      If Assigned(edtDescri) Then
        edtDescri.Text := qryConsulta.FieldByName('ITE_DESITE').AsString;
    End;
  Finally
    If Not Assigned(qryTabela) Then
      FreeAndNil(qryConsulta);
    FreeAndNil(objConsulta);
  End;
End;

function fPesqItemColorante(Self: TForm;
                            edtCodIte,
                            edtDescri: TCustomEdit;
                            qryTabela: TUniQuery;
                            Var chrKey: Char;
                            Var arrSel: TConsultasArray): Boolean;
  Var
    objConsulta: TDefConsulta;
    qryConsulta: TUniQuery;
    strSql, strSQLWhere: String;
    arrTitCol: Array of String;

  Procedure pAddNomeColuna(strNomCol: String);
  Begin
    SetLength(arrTitCol, Succ(Length(arrTitCol)));
    arrTitCol[High(arrTitCol)] := strNomCol;
  End;
Begin

  Result := False;
  If Not fEntraCons(chrKey) Then
    Exit;
  chrKey := #0;
  objConsulta := TDefConsulta.Create;
  Try
    If Not Assigned(qryTabela) Then
      qryConsulta := fCriaQuery(Nil)
    Else
      qryConsulta := qryTabela;


    strSQL :='SELECT ';
    strSQL := strSQL + '  I.ITE_CODITE, ';  pAddNomeColuna('Codigo');
    strSQL := strSQL + '  I.ITE_DESITE, ';  pAddNomeColuna('Descrição');
    strSQL := strSQL + '  I.ITE_REFERE, ';  pAddNomeColuna('Referência');
    strSQL := strSQL + '  PRECOVENDA,   ';  pAddNomeColuna('Preço Venda');
    strSQL := strSQL + '  I.AUTOINCREM AS AUTOINCREM ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE I, ';
    strSQL := strSQL + '  ITEGER G ';
    objConsulta.pIncluiSubConsulta('PRECOVENDA', 'FORMAT(G.ITE_PREVE1, 2)');

    strSQLWhere := 'WHERE ';
    strSQLWhere := strSQLWhere + '  I.ITE_ITEPIG = "S" AND ';
    strSQLWhere := strSQLWhere + '  ( ( TRIM( I.ITE_MARBAS ) <> "" ) OR ( I.ITE_MARBAS IS NOT NULL ) ) AND ';
    strSQLWhere := strSQLWhere + '  I.ITE_CODITE = G.ITE_CODITE AND ';
    strSQLWhere := strSQLWhere + '  G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';

    If fConsulta([strSQL, strSQLWhere],
                   arrTitCol,
                   ['ITE_DESITE'],
                   'AUTOINCREM',
                   'CADITE',
                   Self.Name,
                   'Consulta de Item Colorante',
                   qryConsulta,
                   Nil,
                   True,
                   arrSel,
                   'AUTOINCREM',
                   objConsulta) Then
    begin
      Result := True;
      If Assigned(edtCodIte) Then
        edtCodIte.Text := qryConsulta.FieldByName('ITE_CODITE').AsString;
      If Assigned(edtDescri) Then
        edtDescri.Text := qryConsulta.FieldByName('ITE_DESITE').AsString;
    End;
  Finally
    If Not Assigned(qryTabela) Then
      FreeAndNil(qryConsulta);
    FreeAndNil(objConsulta);
  End;
End;

function fPesqItemEmbalagem(Self: TForm;
                            edtCodIte,
                            edtDescri: TCustomEdit;
                            qryTabela: TUniQuery;
                            Var chrKey: Char;
                            Var arrSel: TConsultasArray;
                            blnProEmb: Boolean = True;
                            strFiltro: string = ''): Boolean;
  Var
    objConsulta: TDefConsulta;
    qryConsulta: TUniQuery;
    strSql, strSQLWhere: String;
    arrTitCol: Array of String;

  Procedure pAddNomeColuna(strNomCol: String);
  Begin
    SetLength(arrTitCol, Succ(Length(arrTitCol)));
    arrTitCol[High(arrTitCol)] := strNomCol;
  End;

Begin
  Result := False;
  If Not fEntraCons(chrKey) Then
    Exit;

  chrKey := #0;
  objConsulta := TDefConsulta.Create;
  Try
    If Not Assigned(qryTabela) Then
      qryConsulta := fCriaQuery(Nil)
    Else
      qryConsulta := qryTabela;


    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  I.ITE_DESITE, ';  pAddNomeColuna('Descrição');
    strSQL := strSQL + '  I.ITE_REFERE, ';  pAddNomeColuna('Referência');
    strSQL := strSQL + '  I.ITE_CODITE, ';  pAddNomeColuna('Codigo');
    strSQL := strSQL + '  ITE_CODBAR  , ';  pAddNomeColuna('Cód. Barras');
    strSQL := strSQL + '  ITE_CODUNI  , ';  pAddNomeColuna('Unidade');
    strSQL := strSQL + '  UNI_SIGUNI  , ';  pAddNomeColuna('Sigla. Unid');
    strSQL := strSQL + '  I.AUTOINCREM ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE I ';
    strSQL := strSQL + 'JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';
    strSQLWhere := strSQLWhere + ' WHERE TRUE ';
    if blnProEmb Then
       strSQLWhere := strSQLWhere + ' AND ITE_PROEMB = "S" ';

    strSQLWhere := strSQLWhere + strFiltro;

    If fConsulta([strSQL, strSQLWhere],
                   arrTitCol,
                   ['ITE_DESITE'],
                   'AUTOINCREM',
                   'CADITE',
                   Self.Name,
                   'Consulta de Produto com Embalagem',
                   qryConsulta,
                   Nil,
                   True,
                   arrSel,
                   'AUTOINCREM',
                   objConsulta) Then
    begin
      Result := True;
      If Assigned(edtCodIte) Then
        edtCodIte.Text := qryConsulta.FieldByName('ITE_CODITE').AsString;
      If Assigned(edtDescri) Then
        edtDescri.Text := qryConsulta.FieldByName('ITE_DESITE').AsString;
    End;
  Finally
    If Not Assigned(qryTabela) Then
      FreeAndNil(qryConsulta);
    FreeAndNil(objConsulta);
  End;
end;

function fPesqProdutosAcabados(Self            : TForm;
                               qryTabela       : TUniQuery;
                               Var chrKey      : Char;
                               Var arrSel      : TConsultasArray;
                               blnComSaldo     : boolean = False;
                               blnSaldoDifZero : boolean = False;
                               strEmpEst       : String  = '';
                               btnConfirmaVisivel: Boolean = True): Boolean;
  Var
    objConsulta: TDefConsulta;
    qryConsulta: TUniQuery;
    strSql, strSQLWhere: String;
    arrTitCol: Array of String;
    i: Integer;

    objpnl : TPanelCxBotoesProdutoAcabadoConsulta;

    blnUsaQtdPen: Boolean;

  Procedure pAddNomeColuna(strNomCol: String);
  Begin
    SetLength(arrTitCol, Succ(Length(arrTitCol)));
    arrTitCol[High(arrTitCol)] := strNomCol;
  End;

Begin
  Result := False;
  If Not fEntraCons(chrKey) Then
    Exit;
  chrKey := #0;
  objConsulta := TDefConsulta.Create;
  Try
    If Not Assigned(qryTabela) Then
      qryConsulta := fCriaQuery(Nil)
    Else
      qryConsulta := qryTabela;

    If Not (blnComSaldo Or  blnSaldoDifZero) Then
    Begin
      objConsulta.pIncluiSubConsulta('COMSALDO', 'IF(G.ACA_SALDOS > 0, "SIM", "NÃO")');
       objConsulta.pIncluiCampoSimNao('COMSALDO');
    End;

    blnUsaQtdPen := (Not fCfgSis('BEFTRG', VarBoolean)) Or fUsaQtdPendenteEntregaFutura;
    objConsulta.pIncluiSubConsulta('ITE_SALFIS', 'ITE_SALDOS + IF(IFNULL(I.ITE_CNV_ML, 0) > 0, IFNULL(H.ITE_SAL_ML, 0) / I.ITE_CNV_ML, 0) + ' +  IIf(blnUsaQtdPen, fGetSQLSomaCamposEntregaFutura('H'), '0'));
    objConsulta.pIncluiSubConsulta('ITE_SALDOS2', fSQLSaldoDisponivel('H', True, False));

    objConsulta.pFormataDecimal('ITE_SALFIS', 2);
    objConsulta.pFormataDecimal('ITE_SALDOS2', 2);

    objConsulta.pIncluiConflito('ACA_CODACA', 'G.ACA_CODACA');

    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '	A.ACA_CODACA, ';  pAddNomeColuna('Código');
    strSQL := strSQL + '	A.ACA_DESCRI, ';  pAddNomeColuna('Descrição');
    strSQL := strSQL + '	A.ACA_CODBAR, ';  pAddNomeColuna('Cód. Barras');
    strSQL := strSQL + '  G.ACA_SALDOS, ';  pAddNomeColuna('Saldo');
    strSQL := strSQL + '	G.ACA_PREVEN, ';  pAddNomeColuna('Preço de Venda');
    strSQL := strSQL + '	A.ACA_IDEPRO, ';  pAddNomeColuna('Sigla');

    For i := 1 To Length(VS_strTabPrc) Do
    Begin
      strSQL := strSQL + '	G.ACA_PREVE' + IntToStr(i) + ' , ';
      pAddNomeColuna('Preço de Venda ' + IntToStr(i));
    End;

    strSQL := strSQL + '	G.ACA_PREMED, ';  pAddNomeColuna('Preço Médio');
    strSQL := strSQL + '	G.ACA_PREULT, ';  pAddNomeColuna('Última Compra');
    strSQL := strSQL + '	G.ACA_IMPULT, ';  pAddNomeColuna('Última Compra + Impostos');

    strSQL := strSQL + '	G.ACA_OUTVAL, ';  pAddNomeColuna('Outros Valores');
    strSQL := strSQL + '	G.ACA_ICMSAI, ';  pAddNomeColuna('ICMS');
    strSQL := strSQL + '	G.ACA_IMPFED, ';  pAddNomeColuna('Impostos Federais');
    strSQL := strSQL + '	G.ACA_DESOPE, ';  pAddNomeColuna('Despesas Operacionais');
    strSQL := strSQL + '	G.ACA_COMLIQ, ';  pAddNomeColuna('Preço de Compra Liquido');

    strSQL := strSQL + '	G.ACA_EMPEST, ';  pAddNomeColuna('Empresa');

    strSQL := strSQL + '  ITE_SALFIS,   ';  pAddNomeColuna('Saldo Físico');
    strSQL := strSQL + '  ITE_SALDOS2,  ';  pAddNomeColuna('Saldo Disponível');

    If Not (blnComSaldo Or  blnSaldoDifZero) Then
      strSQL := strSQL + ' COMSALDO,      '; pAddNomeColuna('Com Saldo');

    strSQL := strSQL + '	A.ACA_CODEMP, ';
    strSQL := strSQL + '	A.AUTOINCREM  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '	CADACA A ';
    strSQL := strSQL + 'JOIN	ACAGER G ON G.ACA_CODACA = A.ACA_CODACA AND ';
    strSQL := strSQL + '                  G.ACA_CODEMP = A.ACA_CODEMP ';

    if blnComSaldo Then
       strSQL := strSQL + ' AND G.ACA_SALDOS > 0 ';

    strSQL := strSQL + 'LEFT JOIN CADITE I ON I.ITE_CODITE = A.ACA_CODITE ';
    strSQL := strSQL + 'LEFT JOIN ITEGER H ON I.ITE_CODITE = H.ITE_CODITE AND ';
    strSQL := strSQL + '                      I.ITE_CODEMP = H.ITE_CODEMP ';


    strSQLWhere := strSQLWhere + 'WHERE TRUE';
    If blnSaldoDifZero Then
       strSQLWhere := strSQLWhere + '	AND G.ACA_SALDOS <> 0 ';


    strSQLWhere := strSQLWhere + ' AND	G.ACA_EMPEST = ' + QuotedStr(IIF(Not fEmptyStr(strEmpEst), strEmpEst, VS_strCodEmp));

    If (Not (blnComSaldo Or  blnSaldoDifZero)) And (Self.Name <> 'frmAjusteEstoque') Then
    Begin
      strSQLWhere := strSQLWhere + ' AND G.ACA_SALDOS <> 0   ';
    End;

    objpnl := TPanelCxBotoesProdutoAcabadoConsulta.Create;

    If fConsulta([strSQL, strSQLWhere],
                   arrTitCol,
                   ['ACA_DESCRI'],
                   'AUTOINCREM',
                   'CADACA',
                   Self.Name,
                   'Consulta de Produto Acabados',
                   qryConsulta,
                   objpnl,
                   True,
                   arrSel,
                   'AUTOINCREM',
                   objConsulta,
                   False,
                   False,
                   '',
                   Nil,
                   True,
                   btnConfirmaVisivel) Then
      Result := True;

  Finally
    If Not Assigned(qryTabela) Then
      FreeAndNil(qryConsulta);
    FreeAndNil(objConsulta);
  End;
End;

function fPesqRei_cadCor(Self: TForm;
                               qryTabela: TUniQuery;
                               Var chrKey: Char;
                               Var arrSel: TConsultasArray): boolean;
  Var
    qryConsulta: TUniQuery;
    strSql: String;
    arrTitCol: Array of String;

  Procedure pAddNomeColuna(strNomCol: String);
  Begin
    SetLength(arrTitCol, Succ(Length(arrTitCol)));
    arrTitCol[High(arrTitCol)] := strNomCol;
  End;

Begin
  Result := False;
  If Not fEntraCons(chrKey) Then
    Exit;
  chrKey := #0;
  Try
    If Not Assigned(qryTabela) Then
      qryConsulta := fCriaQuery(Nil)
    Else
      qryConsulta := qryTabela;

    strSQL := strSQL + 'SELECT ';

    strSQL := strSQL + ' COR_CODPRO, ';  pAddNomeColuna('Código');
    strSQL := strSQL + ' COR_DESCRI, ';  pAddNomeColuna('Descrição');
    strSQL := strSQL + ' COR_CODEMP, ';
    strSQL := strSQL + ' AUTOINCREM ';
    strSQL := strSQL + ' FROM REI_CADCOR';


    If fConsulta([strSQL],
                   arrTitCol,
                   ['COR_DESCRI'],
                   'AUTOINCREM',
                   'REI_CADCOR',
                   Self.Name,
                   'Consulta Cores - Renner Imobilíaria',
                   qryConsulta,
                   Nil,
                   True,
                   arrSel) Then
      Result := True;
  Finally
    If Not Assigned(qryTabela) Then
      FreeAndNil(qryConsulta);
  End;
end;

{ TDefConsultaOS }

constructor TDefConsultaOS.Create;
begin
  Inherited Create;

  cxsVencendoPrazo := TcxStyle.Create(nil);
  cxsVencendoPrazo.TextColor := clOrange;

  cxsPrazoVencido := TcxStyle.Create(nil);
  cxsPrazoVencido.TextColor := clRed;

  pIncluiIndCampos(['CGCCPF']);
  pIncluiDefMascara('C_G_C_', pDisplayCGCCPF);
end;

destructor TDefConsultaOS.destroy;
begin
  FreeAndNil(cxsVencendoPrazo);
  FreeAndNil(cxsPrazoVencido);
end;

function TDefConsultaOS.fGetCellStyle(AView: TcxGridDBTableView;
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
  ADataSet: TDataSet): TcxStyle;
  Var
    ARowInfo: TcxRowInfo;


  function fIdxColumn(strCampo: String): Integer;
  begin
    Result := -1;

    {********************************************************}
    {* ESSA FUNÇAO TEVE DE ALTERAR O COMPONENTE DEV-EXPRESS *}
    {* SE ESTA OCORRENDO ERRO DE TYPECAST VC DEVE VERIFICAR *}
    {* NOS COMPONENTES SE A CORREÇÃO FOI APLICADA EM SUA    *}
    {* MÁQUINA                                              *}
    {*****************************************************AF*}
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
  If ARecord.IsData And (ARecord.Index > -1) Then
  Begin
    If fGetValor(fIdxColumn('SUBSTA_')) = 'APROVADA GARANTIA' Then
    Begin
      If VS_date > fGetValor(fIdxColumn('DTENTR')) Then
         Result := cxsPrazoVencido
      Else
         Result := cxsVencendoPrazo;
    End;
  End;
end;

procedure TDefConsultaOS.pDisplayCGCCPF(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AText: string);
  Var
    intIndex: Integer;
begin
  intIndex := fIdxCampo('CGCCPF');

  If VarToStr(ARecord.Values[intIndex]) = '1' Then
    AText := FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_G_C_), AText)
  Else
    AText := FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_P_F_), AText);
end;

{TDefConsultaClasseLocal}

constructor TDefConsultaClasseLocal.Create;
begin
  Inherited Create;

  cxsMapeadasItem    := TcxStyle.Create(Nil);
  cxsMapeadasItem.TextColor := clBlue;   //ao alterar essa cor, alterar o shpMapeamento da unit untPnlDadosClasseLocal

  cxsNormal    := TcxStyle.Create(Nil);
  cxsNormal.TextColor := clBlack;
end;

destructor TDefConsultaClasseLocal.destroy;
begin
  FreeAndNil(cxsMapeadasItem);
  FreeAndNil(cxsNormal);
end;

function TDefConsultaClasseLocal.fGetCellStyle(AView: TcxGridDBTableView;
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
  ADataSet: TDataSet): TcxStyle;
  Var
    ARowInfo: TcxRowInfo;


  function fIdxColumn(strCampo: String): Integer;
  begin
    Result := -1;

    {********************************************************}
    {* ESSA FUNÇAO TEVE DE ALTERAR O COMPONENTE DEV-EXPRESS *}
    {* SE ESTA OCORRENDO ERRO DE TYPECAST VC DEVE VERIFICAR *}
    {* NOS COMPONENTES SE A CORREÇÃO FOI APLICADA EM SUA    *}
    {* MÁQUINA                                              *}
    {*****************************************************AF*}
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
  If ARecord.IsData And (ARecord.Index > -1) Then
  Begin
    If fGetValor(fIdxColumn('CLAPROD')) = 'S' Then
      Result := cxsMapeadasItem
    else
      Result := cxsNormal;
  End;
end;


{ TDefConsultaLotFat }

function TDefConsultaLotFat.fCellBold(AView: TcxGridDBTableView;
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
  ADataSet: TDataSet): Boolean;

  Var
    ARowInfo: TcxRowInfo;

  function fIdxColumn(strCampo: String): Integer;
  begin
    Result := -1;
    {********************************************************}
    {* ESSA FUNÇAO TEVE DE ALTERAR O COMPONENTE DEV-EXPRESS *}
    {* SE ESTA OCORRENDO ERRO DE TYPECAST VC DEVE VERIFICAR *}
    {* NOS COMPONENTES SE A CORREÇÃO FOI APLICADA EM SUA    *}
    {* MÁQUINA                                              *}
    {*****************************************************AF*}
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
  Result := False;
  If ARecord.IsData And (ARecord.Index > -1) Then
    Result := fGetValor(fIdxColumn('FABANT')) = 'S';
end;

function fPesqGrupoServicos(Self     : TForm;                            {* Formulário                                  *}
                              edtCodigo: TCustomEdit;                      {* Edit do Código                              *}
                              edtDescri: TEditFocus;                       {* Edit da Descrição                           *}
                              qryTabela: TUniQuery;                        {* Query                                       *}
                              Var chrKey: Char;                            {* Key                                         *}
                              Var arrSel: TConsultasArray;                 {* Array de Seleção                            *}
                              blnConSim: Boolean = True): Boolean;         {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE   ';
      strSQL := strSQL + '  GRUSER.GRU_CODGRU,  ';
      strSQL := strSQL + '  GRUSER.GRU_DESGRU,  ';
      strSQL := strSQL + '  GRUSER.GRU_CODEMP,  ';
      strSQL := strSQL + '  GRUSER.AUTOINCREM   ';
      strSQL := strSQL + 'FROM                  ';
      strSQL := strSQL + '  GRUSER              ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Código',
                   'Descrição',
                   'Empresa'],
                   ['GRU_DESGRU', 'GRU_CODGRU', 'GRU_CODEMP'],
                   '',
                   'GRUSER',
                   Self.Name,
                   'Consulta de Grupos de Serviços',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'GRU_CODGRU') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('GRU_CODGRU').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('GRU_CODGRU').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('GRU_DESGRU').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', Length(qryConsulta.FieldByName('GRU_CODGRU').AsString))
            Else
              edtCodigo.Text := fStrZero('0', Length(qryConsulta.FieldByName('GRU_CODGRU').AsString));
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

function fPesqCest(Self: TForm;                             {* Formulario                                  *}
                   edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                   edtDescri: TEditFocus;                  {* Edit da Descrição                           *}
                   qryTabela: TUniQuery;                     {* Query                                       *}
                   Var chrKey: Char;                       {* Key                                         *}
                   Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                   blnConSim: Boolean = True;           {* Consulta Simples ou Múltipla (multi select) *}
                   strCodNCM: String = ''): Boolean;

  Var
    strSQL     : String;
    strWhere   : String;
    qryConsulta: TUniQuery;
    objConsulta : TDefConsulta;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      objConsulta := TDefConsulta.Create;

      strSQL := strSQL + 'SELECT C.CES_CDCEST, ';
      strSQL := strSQL + '       C.CES_CODNCM, ';
      strSQL := strSQL + '       DESCRI, ';
      strSQL := strSQL + '       C.AUTOINCREM  ';
      strSQL := strSQL + '  FROM CDCEST C      ';

      If Not fEmptyStr((strCodNCM)) Then
         strWhere := strWhere + ' WHERE CES_CODNCM = ' + QuotedStr(strCodNCM);

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      objConsulta.pIncluiSubConsulta('DESCRI', 'CAST(REPLACE (C.CES_DESCRI, "<<csq>>", " ") AS CHAR(255))');

      If fConsulta([strSQL, strWhere],
                  ['Código',
                   'Código NCM',
                   'Descrição',
                   'AUTOINCREM'],
                   ['CES_CDCEST'],
                   '',
                   'CDCEST',
                   Self.Name,
                   'Consulta de Classifição CEST',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'CES_CDCEST',
                   objConsulta) Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('CES_CDCEST').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('CES_CDCEST').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := AnsiReplaceStr(qryConsulta.FieldByName('CES_DESCRI').AsString, '<<csq>>', ' ');

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := '0'
            Else
              edtCodigo.Text := fStrZero('0', 7);
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';

        End;

        Result := True;

        If Not Assigned(qryTabela) Then
          FreeAndNil(qryConsulta);
        FreeAndNil(objConsulta);
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
End;

function fPesqCondPagBosch(Self: TForm;                            {* Formulario                                  *}
                           edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                           edtDescri: TEditFocus;                  {* Edit da Descrição                           *}
                           qryTabela: TUniQuery;                     {* Query                                       *}
                           Var chrKey: Char;                       {* Key                                         *}
                           Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                           blnConSim: Boolean = True): Boolean;    {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
    objConsulta : TDefConsulta;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      objConsulta := TDefConsulta.Create;

      strSQL := strSQL + 'SELECT C.CND_CODCND, ';
      strSQL := strSQL + '       C.CND_DESCRI, ';
      strSQL := strSQL + '       C.CND_AUTCOM, ';
      strSQL := strSQL + '       C.AUTOINCREM  ';
      strSQL := strSQL + '  FROM BOSCH_CADCND C      ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;
      If fConsulta([strSQL],
                  ['Código Cond. Pagto. Bosch',
                   'Descrição Cond. Pagto.',
                   'Cond. Pagto. Autcom'],
                   ['CND_CODCND', 'CND_DESCRI', 'CND_AUTCOM'],
                   'AUTOINCREM',
                   'BOSCH_CADCND',
                   Self.Name,
                   'Consulta Condições de Pagamento BOSCH',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel) Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('CND_CODCND').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('CND_CODCND').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('CND_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := '0'
            Else
              edtCodigo.Text := fStrZero('0', 7);
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';

        End;

        Result := True;

        If Not Assigned(qryTabela) Then
          FreeAndNil(qryConsulta);
        FreeAndNil(objConsulta);
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
End;

function fPesqCondPagBosch2(Self: TForm;                            {* Formulario                                  *}
                           edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                           edtDescri: TEditFocus;                  {* Edit da Descrição                           *}
                           qryTabela: TUniQuery;                     {* Query                                       *}
                           Var chrKey: Char;                       {* Key                                         *}
                           Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                           blnConSim: Boolean = True): Boolean;    {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
    objConsulta : TDefConsulta;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      objConsulta := TDefConsulta.Create;

      strSQL := strSQL + 'SELECT C.CND_CODCND, ';
      strSQL := strSQL + '       C.CND_DESCRI, ';
      strSQL := strSQL + '       C.CND_AUTCOM, ';
      strSQL := strSQL + '       C.AUTOINCREM  ';
      strSQL := strSQL + '  FROM BOSCH_CADCND C      ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;
      If fConsulta([strSQL],
                  ['Código Cond. Pagto. Bosch',
                   'Descrição Cond. Pagto.',
                   'Cond. Pagto. Autcom'],
                   ['CND_CODCND', 'CND_DESCRI', 'CND_AUTCOM'],
                   'CND_CODCND',
                   'BOSCH_CADCND',
                   Self.Name,
                   'Consulta Condições de Pagamento BOSCH',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'CND_CODCND') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('CND_CODCND').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('CND_CODCND').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('CND_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := '0'
            Else
              edtCodigo.Text := fStrZero('0', 7);
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';

        End;

        Result := True;

        If Not Assigned(qryTabela) Then
          FreeAndNil(qryConsulta);
        FreeAndNil(objConsulta);
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
End;

function fPesqCliCtt(Self: TForm;                         {* Formulario                                  *}
                     edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                     qryTabela: TUniQuery;                {* Query                                       *}
                     Var chrKey: Char;                    {* Key                                         *}
                     Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                     strCodCli : String = '';             {* Código do cliente                           *}
                     blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
    objConsulta: TDefConsulta;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      objConsulta := TDefConsulta.Create;

      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  CLI_NOMCTT, ';
      strSQL := strSQL + '  CLI_NASCTT, ';
      strSQL := strSQL + '  CLI_ENDCTT, ';
      strSQL := strSQL + '  CLI_BAICTT, ';
      strSQL := strSQL + '  CID_NOMCID, ';
      strSQL := strSQL + '  CID_ESTADO, ';
      strSQL := strSQL + '  CLI_TELCTT, ';
      strSQL := strSQL + '  CLI_CELCTT, ';
      strSQL := strSQL + '  CLI_FAXCTT, ';
      strSQL := strSQL + '  CLI_DEPCTT, ';
      strSQL := strSQL + '  CLI_EMACTT, ';
      strSQL := strSQL + '  AUTOINCREM  ';
      strSQL := strSQL + 'FROM (SELECT ';
      strSQL := strSQL + '        CLI_NOMCTT, ';
      strSQL := strSQL + '        CLI_NASCTT, ';
      strSQL := strSQL + '        CLI_ENDCTT, ';
      strSQL := strSQL + '        CLI_BAICTT, ';
      strSQL := strSQL + '        CID_NOMCID, ';
      strSQL := strSQL + '        CID_ESTADO, ';
      strSQL := strSQL + '        CLI_TELCTT, ';
      strSQL := strSQL + '        CLI_CELCTT, ';
      strSQL := strSQL + '        CLI_FAXCTT, ';
      strSQL := strSQL + '        CLI_DEPCTT, ';
      strSQL := strSQL + '        CLI_EMACTT, ';
      strSQL := strSQL + '        CLICTT.AUTOINCREM ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CLICTT ';
      strSQL := strSQL + '  LEFT JOIN CADCID ';
      strSQL := strSQL + '    ON CID_CODCID = CLI_CIDCTT ';
      strSQL := strSQL + ' WHERE CLI_CODCLI = ' + strCodCli + ') AS CLICTT';

      If (Not Assigned(qryTabela)) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      objConsulta.pIncluiCamposFone(['CLI_TELCTT', 'CLI_CELCTT', 'CLI_FAXCTT']);

      If fConsulta([strSQL],
                   ['Nome', 'Dt. Nascimento', 'Endereço', 'Bairro', 'Cidade', 'Estado', 'Telefone', 'Celular', 'Fax', 'Departamento', 'Email'],
                   ['CLI_NOMCTT'],
                   'AUTOINCREM',
                   'CLICTT',
                   Self.Name,
                   'Consulta de Contatos de Cliente',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'AUTOINCREM',
                   objConsulta) Then
      Begin
        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('CLI_NOMCTT').AsString;

        If (Length(arrSel) > 1) Then Begin
          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';
        End;

        Result := True;

        If Not Assigned(qryTabela) Then
          FreeAndNil(qryConsulta);
        FreeAndNil(objConsulta);
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
End;

function fPesqMaterialConsumo(Self     : TForm;                          {* Formulário                                  *}
                              edtCodigo: TCustomEdit;                    {* Edit do Código                              *}
                              edtDescri: TCustomEdit;                    {* Edit da Descrição                           *}
                              qryTabela: TUniQuery;                      {* Query                                       *}
                              Var chrKey: Char;                          {* Key                                         *}
                              Var arrSel: TConsultasArray;               {* Array de Seleção                            *}
                              blnConSim: Boolean = True;                 {* Consulta Simples ou Múltipla (multi select) *}
                              strCodFor: String = ''): Boolean;       {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQLWhere,
    strSQL     : String;
    qryConsulta: TUniQuery;
    objConsulta: TDefConsulta;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      objConsulta:= TDefConsulta.Create;
      objConsulta.pIncluiSubConsulta('MCO_ATIVO_', ' IF(MCO_MCOATI="S", "SIM", "NÃO") ');

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  MCO_CODMCO,       ';
      strSQL := strSQL + '  MCO_DESCRI,       ';
      strSQL := strSQL + '  MCO_PRECOM,       ';
      strSQL := strSQL + '  MCO_ATIVO_,       ';
      strSQL := strSQL + '  MCO_CODFOR,       ';
      strSQL := strSQL + '  FOR_NOMFOR,       ';
      strSQL := strSQL + '  MCO_CODFAB,       ';
      strSQL := strSQL + '  MCO_CODBAR,       ';
      strSQL := strSQL + '  MCO_CODCTA,       ';
      strSQL := strSQL + '  CTA_DESCTA,       ';
      strSQL := strSQL + '  C.AUTOINCREM      ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  CADMCO C           ';

      strSQL := strSQL + 'LEFT JOIN CADFOR ON MCO_CODFOR = FOR_CODFOR  ';
      strSQL := strSQL + 'LEFT JOIN CADCTA ON MCO_CODCTA = CTA_CODCTA  ';

      If Not fEmptyStr(strCodFor) Then
      Begin
        strSQLWhere := ' WHERE MCO_CODFOR = ' + QuotedStr(strCodFor) + ' ';
      End;

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL,
                    strSQLWhere],
                  ['Código',
                   'Descrição',
                   'Preço Compra',
                   'Ativo',
                   'Cód.Fornecedor',
                   'Fornecedor',
                   'Código Fábrica',
                   'Código Barras',
                   'Cód. Plano de Contas',
                   'Plano de Contas'],
                  ['MCO_DESCRI'],
                   '',
                   'CADMCO',
                   Self.Name,
                   'Consulta de Material Consumo',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'AUTOINCREM',
                   objConsulta) Then
      Begin

        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('MCO_CODMCO').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('MCO_CODMCO').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('MCO_DESCRI').AsString;

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

      End;

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);

      FreeAndNil(objConsulta);

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

function fPesqFaixasCndPagtoAgr(Self   : TForm;                                   {* Formulário                                  *}
                                qryCadFai : TUniQuery;                            {* Query                                       *}
                                Var chrKey: Char;                                 {* Key                                         *}
                                Var arrSel: TConsultasArray;                      {* Array de Consulta                           *}
                                blnConSim : Boolean = True;                       {* Consulta Simples ou Múltipla (multi select) *}
                                strTitulo : String  = 'Consulta de Faixas de Condição de Pagamento para agrupamento'): Boolean;
Var
  strSQL     : String;
  qryConsulta: TUniQuery;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';

      strSQL := strSQL + 'SELECT        ';
      strSQL := strSQL + '  AUTOINCREM, ';
      strSQL := strSQL + '  FAI_VALINI, ';
      strSQL := strSQL + '  FAI_VALFIN, ';
      strSQL := strSQL + '  FAI_CODCND, ';
      strSQL := strSQL + '  FAI_CONPAG  ';
      strSQL := strSQL + 'FROM          ';
      strSQL := strSQL + '  FAICND      ';

      If Not Assigned(qryCadFai) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryCadFai;

      If fConsulta([strSQL],
                   ['AUTOINCREM', 'Valor inicial', 'Valor final', 'Cód. condição', 'Condição'],
                   ['FAI_VALINI', 'FAI_VALFIN', 'FAI_CODCND'],
                   'AUTOINCREM',
                   'FAICND',
                   Self.Name,
                   'Consulta de Faixas de condição de pagamento para agrupamento',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel) Then
      Begin
        Result := True;

        If Not Assigned(qryCadFai) Then
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

function fPesqAgendaVisita(Self   : TForm;           {* Formulário                             *}
                           Var strNumLote: String;   {* Número do lote do registro selecionado *}
                           Var strAutoIncrem: String {* Chave primária do registro selecionado *}
                           ): Boolean;
Var
  strSQL, strWhere: String;
  qryConsulta: TUniQuery;
  arrSel: TConsultasArray;
Begin
  Result := False;
  Try
    strSQL := '';

    strSQL := strSQL + 'SELECT                                                ';
    strSQL := strSQL + '  A.AUTOINCREM,                                       ';
    strSQL := strSQL + '  A.AGE_CODLOT,                                       ';
    strSQL := strSQL + '  A.AGE_CODEMP,                                       ';
    strSQL := strSQL + '  A.AGE_CODREP,                                       ';
    strSQL := strSQL + '  R.OPE_NOMOPE,                                       ';
    strSQL := strSQL + '  A.AGE_CODCLI,                                       ';
    strSQL := strSQL + '  C.CLI_NOMCLI,                                       ';
    strSQL := strSQL + '  CONCAT(I.CID_NOMCID, "-", I.CID_ESTADO) AS CIDADE,  ';
    strSQL := strSQL + '  A.AGE_DTAVIS                                        ';
    strSQL := strSQL + 'FROM                                                  ';
    strSQL := strSQL + '  AGEVIS A                                            ';
    strSQL := strSQL + 'INNER JOIN CADOPE V                                   ';
    strSQL := strSQL + ' ON V.OPE_CODOPE = A.AGE_CODVEN                       ';
    strSQL := strSQL + 'INNER JOIN CADOPE R                                   ';
    strSQL := strSQL + '  ON R.OPE_CODOPE = A.AGE_CODREP                      ';
    strSQL := strSQL + 'INNER JOIN CADCLI C                                   ';
    strSQL := strSQL + '  ON C.CLI_CODCLI = A.AGE_CODCLI                      ';
    strSQL := strSQL + 'INNER JOIN CADCID I                                   ';
    strSQL := strSQL + '  ON I.CID_CODCID = A.AGE_CODCID                      ';

    strWhere := ' WHERE A.AGE_INDCOL = "I" ';

    qryConsulta := fCriaQuery(Nil);
    Try
      If fConsulta([strSQL, strWhere],
                   ['AUTOINCREM', 'Núm. Lote', 'Empresa', 'Cód. Representante', 'Representante', 'Cód. Cliente', 'Cliente', 'Cidade', 'Data da visita'],
                   ['AGE_CODLOT', 'AGE_CODEMP', 'AGE_CODREP', 'AGE_CODCLI', 'AGE_DTAVIS'],
                   'AUTOINCREM',
                   'AGEVIS',
                   Self.Name,
                   'Consulta de Agendamento de Visitas',
                   qryConsulta,
                   Nil,
                   True,
                   arrSel) Then
      Begin
        strNumLote := qryConsulta.FieldByName('AGE_CODLOT').AsString;
        strAutoIncrem := qryConsulta.FieldByName('AUTOINCREM').AsString;

        Result := True;
      End;
    Finally
      FreeAndNil(qryConsulta);
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;
End;

function fPesqFornecedorAtualCRM(Self     : TForm;                            {* Formulário                                  *}
                                 edtCodigo: TCustomEdit;                      {* Edit do Código                              *}
                                 edtDescri: TEditFocus;                       {* Edit da Descrição                           *}
                                 qryTabela: TUniQuery;                        {* Query                                       *}
                                 Var chrKey: Char;                            {* Key                                         *}
                                 Var arrSel: TConsultasArray;                 {* Array de Seleção                            *}
                                 blnConSim: Boolean = True): Boolean;         {* Consulta Simples ou Múlti pla (multi select) *}
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT CRF_CODIGO,       ';
      strSQL := strSQL + '       CRF_NOMFOR,       ';
      strSQL := strSQL + '       AUTOINCREM        ';
      strSQL := strSQL + 'FROM CRMFOR              ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Código',
                   'Nome',
                   'AUTOINCREM'],
                   ['CRF_NOMFOR','CRF_CODIGO'],
                   '',
                   'CRMFOR',
                   Self.Name,
                   'Consulta de Fornecedor Atual - CRM',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'CRF_CODIGO') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('CRF_CODIGO').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('CRF_CODIGO').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('CRF_NOMFOR').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 6)
            Else
              edtCodigo.Text := fStrZero('0', 6);
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';

        End;

        Result := True;
      End;

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

function fPesqFrequenciaCRM(Self     : TForm;                            {* Formulário                                  *}
                            edtCodigo: TCustomEdit;                      {* Edit do Código                              *}
                            edtDescri: TEditFocus;                       {* Edit da Descrição                           *}
                            qryTabela: TUniQuery;                        {* Query                                       *}
                            Var chrKey: Char;                            {* Key                                         *}
                            Var arrSel: TConsultasArray;                 {* Array de Seleção                            *}
                            blnConSim: Boolean = True): Boolean;         {* Consulta Simples ou Múlti pla (multi select) *}
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT CRF_CODIGO,       ';
      strSQL := strSQL + '       CRF_DESCRI,       ';
      strSQL := strSQL + '       AUTOINCREM        ';
      strSQL := strSQL + 'FROM CRMFRE              ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Código',
                   'Descrição',
                   'AUTOINCREM'],
                   ['CRF_DESCRI','CRF_CODIGO'],
                   '',
                   'CRMFRE',
                   Self.Name,
                   'Consulta de Frequência - CRM',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'CRF_CODIGO') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('CRF_CODIGO').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('CRF_CODIGO').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('CRF_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 6)
            Else
              edtCodigo.Text := fStrZero('0', 6);
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';

        End;

        Result := True;
      End;

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;



constructor TDefMascaraDiversos.Create;
begin
 Inherited Create;
 pIncluiIndCampos(['DIV_CGCCPF']);

 pIncluiDefMascara('DIV_C_G_C_', pDisplayCGCCPF);
end;

destructor TDefMascaraDiversos.Destroy;
begin
  Inherited Destroy;
end;

procedure TDefMascaraDiversos.pDisplayCGCCPF(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AText: string);
  Var
  intIndex: Integer;
begin
  intIndex := fIdxCampo('DIV_CGCCPF');

  If VarToStr(ARecord.Values[intIndex]) = '1' Then
    AText := FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_G_C_), AText)
  Else
    AText := FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_P_F_), AText);
end;

{ TDefConsultaDefeito }

constructor TDefConsultaDefeito.Create;
begin
  Inherited Create;
end;

destructor TDefConsultaDefeito.Destroy;
begin
  Inherited Destroy;
end;

procedure TDefConsultaDefeito.pParametriza(qryConsulta: TUniQuery);
begin
  If Assigned(sltDefeitos) And (qryConsulta.Params.FindParam('LISTA') <> Nil) Then
    qryConsulta.ParamByName('LISTA').AsString := sltDefeitos.CommaText;
end;

{ TDefConsultaServico }

constructor TDefConsultaServico.Create;
begin
  Inherited Create;
end;

destructor TDefConsultaServico.Destroy;
begin
  Inherited Destroy;
end;

procedure TDefConsultaServico.pParametriza(qryConsulta: TUniQuery);
begin
  If Assigned(sltServicos) And (qryConsulta.Params.FindParam('LISTA') <> Nil) Then
    qryConsulta.ParamByName('LISTA').AsString := sltServicos.CommaText;
end;

{ TDefMascaraContasReceber }

constructor TDefMascaraContasReceber.Create;
begin
  pIncluiIndCampos(['CLI_CGCCPF']);
  pIncluiDefMascara('CLI_C_G_C_', pDisplayCGCCPF);
end;

procedure TDefMascaraContasReceber.pDisplayCGCCPF(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
  Var
    intIndex : Integer;
begin
  intIndex := fIdxCampo('CLI_CGCCPF');

  If VarToStr(ARecord.Values[intIndex]) = '1' Then
    AText := FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_G_C_), AText)
  Else
    AText := FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_P_F_), AText);

end;

function fPesqContatosOperador(Self     : TForm;                    {* Formulário                                  *}
                               edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                               edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                               qryTabela: TUniQuery;                {* Query                                       *}
                               Var chrKey: Char;                    {* Key                                         *}
                               Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                               blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL, strWhere, strGroup : String;
    qryConsulta: TUniQuery;
    objConsulta: TDefConsulta;
begin

  Result := False;

  If fEntraCons(chrKey) Then
  Begin

    Try

      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  CON_NOMCON,       ';
      strSQL := strSQL + '  CON_TELRES,       ';
      strSQL := strSQL + '  CON_TELCOM,       ';
      strSQL := strSQL + '  CON_CELULA,       ';
      strSQL := strSQL + '  GROUP_CONCAT(EMA_EMAIL_ SEPARATOR " | ") AS EMA_EMAIL_, ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  CONOPE            ';
      strSQL := strSQL + 'INNER JOIN EMACON   ';
      strSQL := strSQL + '   ON AUTOINCREM = EMA_SEQCON ';

      strWhere := ' WHERE CON_CODOPE = ' + QuotedStr(strLoginUsuarioLogado);

      strGroup := ' GROUP BY AUTOINCREM ';

      objConsulta := TDefConsulta.Create;
      objConsulta.pIncluiCamposFone(['CON_TELRES', 'CON_TELCOM', 'CON_CELULA']);

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL, strWhere, strGroup],
                  ['Nome Contato',
                   'Telefone Residencial',
                   'Telefone Comercial',
                   'Celular',
                   'e-Mail',
                   'AUTOINCREM'],
                   ['CON_NOMCON','CON_TELRES','CON_TELCOM','CON_CELULA','EMA_EMAIL_'],
                   '',
                   'CONOPE',
                   Self.Name,
                   'Consulta Contatos de Operadores',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'AUTOINCREM',
                   objConsulta) Then
      Begin

        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('AUTOINCREM').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('AUTOINCREM').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('CON_NOMCON').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 20)
            Else
              edtCodigo.Text := fStrZero('0', 20);
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
        pMensagensErro(E.Message, 'untConsultas.fPesqContatosOperador');
      End;
    End;
  End;
end;

function fPesqDescClienteProduto(Self     : TForm;                          {* Formulário                                  *}
                                 edtCodigo: TCustomEdit;                    {* Edit do Código                              *}
                                 qryTabela: TUniQuery;                      {* Query                                       *}
                                 Var chrKey: Char;                          {* Key                                         *}
                                 Var arrSel: TConsultasArray;               {* Array de Seleção                            *}
                                 blnConSim: Boolean = True): Boolean;       {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
    objConsulta : TDefConsulta;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + ' SELECT                                       ';
      strSQL := strSQL + '    PDS_CODCLI,                               ';
      strSQL := strSQL + '    CLI_NOMCLI,                               ';
      strSQL := strSQL + '    PDS_CODITE,                               ';
      strSQL := strSQL + '    ITE_DESITE,                               ';
      strSQL := strSQL + '    UNI_SIGUNI,                               ';
      strSQL := strSQL + '    PDS_PERDES,                               ';
      strSQL := strSQL + '    PRODES.AUTOINCREM                         ';
      strSQL := strSQL + '   FROM PRODES                                ';
      strSQL := strSQL + ' INNER JOIN CADCLI ON CLI_CODCLI = PDS_CODCLI ';
      strSQL := strSQL + ' INNER JOIN CADITE ON ITE_CODITE = PDS_CODITE ';
      strSQL := strSQL + ' INNER JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      objConsulta := TDefConsulta.Create;
      objConsulta.pFormataDecimal('PDS_PERDES', 2);

      If fConsulta([strSQL],
                  ['Código Cliente',
                   'Nome',
                   'Código Produto',
                   'Produto',
                   'UN',
                   'Desconto',
                   'AUTOINCREM'],
                  ['CLI_NOMCLI', 'PDS_CODCLI', 'PDS_CODITE', 'ITE_DESITE', 'UNI_SIGUNI', 'PDS_PERDES'],
                   '',
                   'PRODES',
                   Self.Name,
                   'Consulta de Desconto Cliente / Produtos',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'AUTOINCREM',
                   objConsulta) Then
      Begin

        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('PDS_CODCLI').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('PDS_CODCLI').AsString;
        End;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 8)
            Else
              edtCodigo.Text := fStrZero('0', 8);
          End;

        End;

        Result := True;
      End;

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);

      FreeAndNil(objConsulta);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

function fPesqCliDes(strFormName : String;                      {* Formulário                                  *}
                     edtCodigo: TCustomEdit;                    {* Edit do Código                              *}
                     qryTabela: TUniQuery;                      {* Query                                       *}
                     Var chrKey: Char;                          {* Key                                         *}
                     Var arrSel: TConsultasArray;               {* Array de Seleção                            *}
                     blnConSim: Boolean = True): Boolean;       {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
    strWhere : String;
    objConsulta : TDefConsulta;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strWhere := '';

      strSQL := '';
      strSQL := strSQL + ' SELECT CLI_NOMCLI, FOR_NOMFOR, ';
      strSQL := strSQL + '        CDS_PERDES, CDS_PERCOM, ';
      strSQL := strSQL + '        CDS_CODCLI, CDS_CODFOR, CLIDES.AUTOINCREM ';
      strSQL := strSQL + '   FROM CLIDES ';
      strSQL := strSQL + '   JOIN CADCLI ON CLI_CODCLI = CDS_CODCLI ';
      strSQL := strSQL + '   JOIN CADFOR ON FOR_CODFOR = CDS_CODFOR ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      objConsulta := TDefConsulta.Create;
      objConsulta.pFormataDecimal('CDS_PERDES', 2);
      objConsulta.pFormataDecimal('CDS_PERCOM', 2);

      If fConsulta([strSQL, strWhere],
                  ['Cliente',
                   'Fornecedor',
                   '% Desc.',
                   '% Comiss.',
                   'Cód. Cliente',
                   'Cód. For.',
                   'AUTOINCREM'],
                  ['CLI_NOMCLI', 'FOR_NOMFOR', 'CDS_PERDES', 'CDS_PERCOM', 'CDS_CODCLI', 'CDS_CODFOR'],
                   '',
                   'CLIDES',
                   strFormName,
                   'Consulta de Desconto Cliente / Fornecedor',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'AUTOINCREM',
                   objConsulta) Then
      Begin

        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('CDS_CODCLI').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('CDS_CODCLI').AsString;
        End;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 8)
            Else
              edtCodigo.Text := fStrZero('0', 8);
          End;

        End;

        Result := True;
      End;

      FreeAndNil(objConsulta);

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

function fPesqRegDes(strFormName : String;                      {* Formulário                                  *}
                     edtCodigo: TCustomEdit;                    {* Edit do Código                              *}
                     qryTabela: TUniQuery;                      {* Query                                       *}
                     Var chrKey: Char;                          {* Key                                         *}
                     Var arrSel: TConsultasArray;               {* Array de Seleção                            *}
                     blnConSim: Boolean = True): Boolean;       {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
    strWhere : String;
    objConsulta : TDefConsulta;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strWhere := '';

      strSQL := '';
      strSQL := strSQL + ' SELECT REG_DESREG, FOR_NOMFOR, RDS_PERDES, ';
      strSQL := strSQL + '        RDS_PERCOM, RDS_CODFOR, REGDES.AUTOINCREM ';
      strSQL := strSQL + '   FROM REGDES ';
      strSQL := strSQL + '   JOIN CADREG ON REG_CODREG = RDS_CODREG ';
      strSQL := strSQL + '   JOIN CADFOR ON FOR_CODFOR = RDS_CODFOR ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      objConsulta := TDefConsulta.Create;
      objConsulta.pFormataDecimal('RDS_PERDES', 2);
      objConsulta.pFormataDecimal('RDS_PERCOM', 2);

      If fConsulta([strSQL, strWhere],
                  ['Região',
                   'Fornecedor',
                   '% Desc.',
                   '% Comiss.'],
                  ['REG_DESREG', 'FOR_NOMFOR', 'RDS_PERDES', 'RDS_PERCOM', 'RDS_CODREG', 'RDS_CODFOR'],
                   '',
                   'REGDES',
                   strFormName,
                   'Consulta de Desconto Região / Fornecedor',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'AUTOINCREM',
                   objConsulta) Then
      Begin

        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('RDS_CODREG').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('RDS_CODREG').AsString;
        End;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 5)
            Else
              edtCodigo.Text := fStrZero('0', 5);
          End;

        End;

        Result := True;
      End;

      FreeAndNil(objConsulta);

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

function fPesqDocas(Self      : TForm;                         {* Formulário                                  *}
                    edtCodigo : TCustomEdit;                   {* Edit do Codigo                              *}
                    edtDescri : TCustomEdit;                   {* Edit da Descrição                           *}
                    qryTabela : TUniQuery;                     {* Query                                       *}
                    Var chrKey: Char;                          {* Key                                         *}
                    Var arrSel: TConsultasArray;               {* Array de Seleção                            *}
                    blnConSim : Boolean = True;                {* Consulta Simples ou Múltipla (multi select) *}
                    strStatus : String = ''):Boolean;
  Var
    strSQL     : String;
    strWhere   : String;
    qryConsulta: TUniQuery;
    objConsulta: TDefConsulta;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT DOC_IDDOCA,   ';
      strSQL := strSQL + '       DOC_DESCRI,  ';
      strSQL := strSQL + '       STATUS_DOC,  ';
      strSQL := strSQL + '       AUTOINCREM   ';
      strSQL := strSQL + 'FROM CADOCA         ';

      strWhere := '';
      If not fEmptyStr(strStatus) Then
        strWhere := 'WHERE DOC_STATUS = ' + QuotedStr(strStatus);

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      objConsulta := TDefConsulta.Create;

      objConsulta.pIncluiSubConsulta('STATUS_DOC', ' IF(DOC_STATUS = "L" , "LIVRE", "OCUPADA") ');

      If fConsulta([strSQL, strWhere],
                  ['Código',
                   'Descrição',
                   'Status'],
                   ['DOC_DESCRI','DOC_IDDOCA'],
                   '',
                   'CADOCA',
                   Self.Name,
                   'Consulta de Docas',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'AUTOINCREM',
                   objConsulta) Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('DOC_IDDOCA').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('DOC_IDDOCA').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('DOC_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 3)
            Else
              edtCodigo.Text := fStrZero('0', 3);
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';

        End;

        Result := True;
      End;
      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;

End;

function fPesqAgendamentoEntregaWMS(Self      : TForm;                         {* Formulário                                  *}
                                    edtCodigo : TCustomEdit;                   {* Edit do Codigo                              *}
                                    qryTabela : TUniQuery;                     {* Query                                       *}
                                    Var chrKey: Char;                          {* Key                                         *}
                                    Var arrSel: TConsultasArray;               {* Array de Seleção                            *}
                                    blnConSim : Boolean = True;                {* Consulta Simples ou Múltipla (multi select) *}
                                    strStatus : String = '';
                                    strPlaca  : String = ''):Boolean;
  Var
    strSQL   : String;
    strWhere : String;
    objConsulta: TDefConsulta;
    qryConsulta: TUniQuery;
Begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      strWhere := 'WHERE ARC_CODEMP = ' + QuotedStr(VS_strCodEmp);

      If not fEmptyStr(strStatus) Then
        strWhere := strWhere + ' AND ARC_STATUS IN (' + strStatus+ ')';

      If not fEmptyStr(strPlaca) Then
        strWhere := strWhere + ' AND ARC_PLACA_ = ' + QuotedStr(strPlaca);

      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + ' SELECT ARC_CODIGO,    ';
      strSQL := strSQL + '        ARC_IDEDIG,    ';
      strSQL := strSQL + '        ARC_CODTRA,    ';
      strSQL := strSQL + '        TRA_NOMTRA,    ';
      strSQL := strSQL + '        ARC_PLACA_,    ';
      strSQL := strSQL + '        ARC_DTAENT,    ';
      strSQL := strSQL + '        ARC_HRAENT,    ';
      strSQL := strSQL + '        ARC_IDENTI,    ';
      strSQL := strSQL + '        BAIVIR,        ';
      strSQL := strSQL + '        DOCUMENTOS,  ';
      strSQL := strSQL + '        G.AUTOINCREM   ';
      strSQL := strSQL + ' FROM AGEREC G         ';
      strSQL := strSQL + '   LEFT JOIN CADTRA ON TRA_CODTRA = ARC_CODTRA   ';

      objConsulta := TDefConsulta.Create;

      objConsulta.pIncluiSubConsulta('BAIVIR', ' IF(ARC_STATUS = "AG" , "RECEBIMENTO AGENDADO",   ' +
                                               ' IF(ARC_STATUS = "EC" ,"ENTRADA DE CAMINHAO",     ' +
                                               ' IF(ARC_STATUS = "EP" ,"ENDEREÇAMENTO PLANEJADO", ' +
                                               ' IF(ARC_STATUS = "CE" ,"CAMINHAO ESTACIONADO",    ' +
                                               ' IF(ARC_STATUS = "CN" ,"CONFERIDO", "")))))       ');

      objConsulta.pIncluiSubConsulta('DOCUMENTOS','(SELECT GROUP_CONCAT(CONCAT(ADC_NUMDOC,"-",ADC_ESPDOC,"-",ADC_CODEMP) SEPARATOR " ") FROM AGEDOC WHERE ADC_SEQGER = G.AUTOINCREM)');


      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL, strWhere],
                  ['Código',
                   'Seq. de Recebimento',
                   'Cód. Transportadora',
                   'Transportadora',
                   'Placa',
                   'Data de Entrega',
                   'Hora de Entrega',
                   'Identificação',
                   'Status',
                   'Documentos'],
                   ['TRA_NOMTRA', 'ARC_CODIGO'],
                   '',
                   'AGEREC',
                   Self.Name,
                   'Consulta de Agendamento de Entrega',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'AUTOINCREM',
                   objConsulta) Then
      Begin
        Result := True;
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('ARC_CODIGO').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('ARC_CODIGO').AsString;
        End;
      End;

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);

      FreeAndNil(objConsulta);

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;

End;

function fPesqBoxWms(Self     : TForm;                    {* Formulário                                  *}
                     edtCodigo: TCustomEdit;                 {* Edit da Sigla                               *}
                     qryTabela: TUniQuery;                  {* Query                                       *}
                     Var chrKey: Char;                      {* Key                                         *}
                     Var arrSel: TConsultasArray;           {* Array de Seleção                            *}
                     blnConSim: Boolean = True;             {* Consulta Simples                            *}
                     blnSomenteDisponivel : Boolean = False):Boolean;
  Var
    qryConsulta: TUniQuery;
    strSQL: String;
    strWhere: String;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + ' SELECT BOX_CODIGO, ';
      strSQL := strSQL + '        BOX_NUMDOC, ';
      strSQL := strSQL + '        BOX_ESPDOC, ';
      strSQL := strSQL + '        BOX_EMPDOC, ';
      strSQL := strSQL + '        AUTOINCREM  ';
      strSQL := strSQL + ' FROM CADBOX        ';
      strWhere :=        ' WHERE BOX_CODEMP = ' + QuotedStr(VS_strCodEmp);
      If blnSomenteDisponivel then
        strWhere := strWhere + ' AND BOX_NUMDOC IS NULL ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL, strWhere],
                   ['Código', 'Documento', 'Espécie', 'Cód. Empresa'],
                   ['BOX_CODIGO'],
                   'AUTOINCREM',
                   'CADBOX',
                   Self.Name,
                   'Consulta de Box - WMS',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'AUTOINCREM') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('BOX_CODIGO').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('BOX_CODIGO').AsString;
        End;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := '+1'
            Else
              edtCodigo.Text := '+1';
          End;

        End;

        Result := True;

      End;

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;

End;

function fPesqClasseLocFis(Self     : TForm;                      {* Formulário                                  *}
                           edtSigla: TCustomEdit;                 {* Edit da Sigla                               *}
                           qryTabela: TUniQuery;                  {* Query                                       *}
                           Var chrKey: Char;                      {* Key                                         *}
                           Var arrSel: TConsultasArray;           {* Array de Seleção                            *}
                           blnConSim: Boolean = True;             {* Consulta Simples                            *}
                           strCodIte: String  = '';               {* Código do Item                              *}
                           objFrmPnl: TPanelCx = nil ): Boolean;  {* Panel para legendas                         *}
  Var
    qryConsulta: TUniQuery;
    objConsulta : TDefConsultaClasseLocal;
    strSQL: String;
    strWhere: String;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      objConsulta := TDefConsultaClasseLocal.Create;
      try

        strSQL := '';
        strSQL := strSQL + ' SELECT CLA_SIGLA_,                                   ';
        strSQL := strSQL + '        AUTOINCREM,                                   ';
        strSQL := strSQL + '        IF((SELECT                                    ';
        strSQL := strSQL + '              COUNT(*)                                ';
        strSQL := strSQL + '            FROM                                      ';
        strSQL := strSQL + '              CLAITE                                  ';
        strSQL := strSQL + '            WHERE                                     ';
        strSQL := strSQL + '                  CIT_CODITE = '+QuotedStr(strCodIte)  ;
        strSQL := strSQL + '              AND CIT_SIGLA_ = CLA_SIGLA_) > 0        ';
        strSQL := strSQL + '           , "S"                                      ';
        strSQL := strSQL + '           , "N"                                      ';
        strSQL := strSQL + '          ) AS CLAPROD                                ';// campo utilizado para marcar as classes mapeadas para o produto
        strSQL := strSQL + ' FROM CLASSE                                          ';

        strWhere :=        ' WHERE CLA_CODEMP = ' + QuotedStr(VS_strCodEmp);

        If Not Assigned(qryTabela) Then
          qryConsulta := fCriaQuery(Nil)
        Else
          qryConsulta := qryTabela;

        If fConsulta([strSQL, strWhere],
                     ['Sigla'],
                     ['CLA_SIGLA_'],
                     'AUTOINCREM',
                     'CLASSE',
                     Self.Name,
                     'Consulta de Classe de Localização Física',
                     qryConsulta,
                     objFrmPnl,
                     blnConSim,
                     arrSel,
                     'CLA_SIGLA_',
                     objConsulta,
                     False,
                     False,
                     '',
                     Nil,
                     True,
                     True,
                     True,
                     Nil,
                     Nil,
                     Nil,
                     VS_Application) Then
        Begin
          If Assigned(edtSigla) then
          Begin
            If (edtSigla Is TMaskEditFocus) Then
              (edtSigla As TMaskEditFocus).Text := qryConsulta.FieldByName('CLA_SIGLA_').AsString
            Else
              edtSigla.Text := qryConsulta.FieldByName('CLA_SIGLA_').AsString;
          End;

          If (Length(arrSel) > 1) Then
          Begin

            If Assigned(edtSigla) then
            Begin
              If (edtSigla Is TMaskEditFocus) Then
                (edtSigla As TMaskEditFocus).Text := '+1'
              Else
                edtSigla.Text := '+1';
            End;

          End;

          Result := True;

        End;

        If Not Assigned(qryTabela) Then
          FreeAndNil(qryConsulta);
      finally
        FreeAndNil(objConsulta);
      end;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;

End;

function fGetFiltroClienteEmpresaIdentificadora(strCodOpe: String; blnComAnd: Boolean = True): String;
begin
  Result := '';

  if blnComAnd Then
    Result := Result + ' AND ';

  If fCfgSis('IDEEMP', VarBoolean) Then
  Begin
    Result := Result + ' ( ';
    Result := Result + '   (LOCATE(CLI_EMPIDE,' + QuotedStr(fRetEmpAcessoUsuario(strCodOpe)) + ') > 0) OR ';
    Result := Result + '   (CLI_EMPIDE IS NULL) OR ';
    Result := Result + '   (CLI_EMPIDE = "") ';
    Result := Result + ' ) ';
  End
  Else
    Result := Result + ' TRUE ';
end;

function fPesqLayoutEtiquetaDespacho(Self     : TForm;                         {* Formulário                                  *}
                                    edtCodigo: TCustomEdit;                   {* Edit do Código                              *}
                                    edtDescri: TEditFocus;                    {* Edit da Descrição                           *}
                                    qryTabela: TUniQuery;                     {* Query                                       *}
                                    Var chrKey: Char;                         {* Key                                         *}
                                    Var arrSel: TConsultasArray;              {* Array de Seleção                            *}
                                    blnConSim: Boolean = True): Boolean;      {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL,
    strSQLWhere: String;
    qryConsulta: TUniQuery;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  LAY_CODLAY,       ';
      strSQL := strSQL + '  LAY_NOMLAY,       ';
      strSQL := strSQL + '  LAY_DESCRI,       ';
      strSQL := strSQL + '  LAY_PADRAO,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  LAYETI            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      strSQLWhere := ' WHERE LAY_TIPLAY = ';
      If fCfgSis('ETIDES') = 'L' Then
         strSQLWhere := strSQLWhere + '35'
      Else
         strSQLWhere := strSQLWhere + '36';

      If fConsulta([strSQL, strSQLWhere],
                  ['Código',
                   'Tipo do Layout',
                   'Descrição',
                   'Padrão'],
                   ['LAY_NOMLAY','LAY_DESCRI','LAY_CODLAY'],
                    'LAY_CODLAY',
                    'LAYETI',
                   Self.Name,
                   'Consulta de Layouts de Despacho',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'LAY_CODLAY') Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('LAY_CODLAY').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('LAY_CODLAY').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('LAY_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 6)
            Else
              edtCodigo.Text := fStrZero('0', 6);
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';

        End;

        Result := True;

      End;
      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
End;




{*************************************}
{* CONCILIAÇÃO DE CARTÕES DE CRÉDITO *}
{**********************************AJ*}





function fGetSQLNumCmp(strAliasFatGor: String = 'FATGOR'): String;
  Var
    strSQL : String;
begin
  strSQL := '';
  strSQL := strSQL + '  CONCAT(IFNULL((SELECT IF(IFNULL(CMP_NUMCMP,"") <> "", CONCAT(GROUP_CONCAT(DISTINCT CMP_NUMCMP SEPARATOR ";"), ";"), "") ';
  strSQL := strSQL + '                   FROM NUMCMP ';
  strSQL := strSQL + '                  WHERE CMP_SEQGER = ' + strAliasFatGor + '.AUTOINCREM ';
  strSQL := strSQL + '                    AND IFNULL(CMP_NUMCMP, "") <> ""), ""), ';
  strSQL := strSQL + '         IFNULL((SELECT GROUP_CONCAT(DISTINCT FDO_NUMCMP SEPARATOR ";") ';
  strSQL := strSQL + '                   FROM EXTDOR ';
  strSQL := strSQL + '                  WHERE FDO_SEQFDO IN (SELECT AUTOINCREM ';
  strSQL := strSQL + '                                         FROM FATDOR ';
  strSQL := strSQL + '                                        WHERE FDO_SEQGER = ' + strAliasFatGor + '.AUTOINCREM) ';
  strSQL := strSQL + '                    AND IFNULL(FDO_NUMCMP, "") <> ""), "")) ';
  Result := strSQL;
end;


{ TDefMascaraCheque }

constructor TDefMascaraCheque.Create;
begin
  pIncluiIndCampos(['CHQ_CGCCPF']);
  pIncluiDefMascara('CHQ_C_G_C_', pDisplayCGCCPF);
end;

procedure TDefMascaraCheque.pDisplayCGCCPF(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AText: string);
  Var
    intIndex : Integer;
begin
  intIndex := fIdxCampo('CHQ_CGCCPF');

  If VarToStr(ARecord.Values[intIndex]) = '1' Then
    AText := FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_G_C_), AText)
  Else
    AText := FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_P_F_), AText);
end;

{ TDefMascaraCadFisCGC }

constructor TDefMascaraCadFisCGC.Create;
begin
  Inherited Create;
  pIncluiDefMascara('FIS_C_G_C_', pDisplayCGCCPF);
end;


procedure TDefMascaraCadFisCGC.pDisplayCGCCPF(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AText: string);
  Var
    intIndex: Integer;

 Function fIDxCampo2(strCampo: string): integer;
   var i: integer;
     blnEncontrou: boolean;
 Begin
   blnEncontrou := False;
   Result := -1;

   For i :=  0 To ARecord.ViewInfo.GridView.DataController.ItemCount -1 do// Sender.DataController.FFields.Count -1 do
   Begin
     If SameText(TcxGridDBColumn(ARecord.ViewInfo.GridView.DataController.GetItem(i)).DataBinding.FieldName, strCampo) Then
     Begin
       Result := i;
       blnEncontrou := True;
       Break;
     End;
   End;
   If Not blnEncontrou Then
     Result := -1;

 End;

begin
  intIndex := fIDxCampo2('FIS_TIP_FC');
  If intIndex > -1 Then
  Begin
    If VarToStr(ARecord.Values[intIndex]) = 'F' Then
      AText := FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_G_C_), AText)
    Else
      AText := FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_P_F_), AText);
  End
  Else
    AText := FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_P_F_), AText);
end;

{ TDefConsultaPlanoContabil }

constructor TDefConsultaPlanoContabil.Create(arrCampos: TStringArray);
  Var
    intCnt : Integer;
begin
  inherited Create;

  strMskCon := '';
  if assigned(fMskCon) then
    strMskCon := fMskCon;

  For intCnt := Low(arrCampos) To High(arrCampos) Do
    pIncluiDefMascara(arrCampos[intCnt], pDisplayPlanoContabil);
end;

destructor TDefConsultaPlanoContabil.Destroy;
begin
  inherited Destroy;
end;

procedure TDefConsultaPlanoContabil.pDisplayPlanoContabil(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  AText := FormatMaskText(strMskCon, AText);
end;


Initialization
  objCadastros := Nil;
  fMskCon := Nil;

end.

