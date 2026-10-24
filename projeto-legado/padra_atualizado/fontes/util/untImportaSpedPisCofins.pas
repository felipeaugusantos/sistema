unit untImportaSpedPisCofins;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Mask,
  FilenameEditFocus, StrUtils, Uni, untFuncFat, ComCtrls, DB, UniClientDataSet,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, cxGraphics, untTypesSistema,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Datasnap.DBClient, cxTextEdit,
  cxMaskEdit, cxButtonEdit;

Type
  VerificacaoException = class(Exception);
  
Type
  TItemNota = class(TObject)
    public
      intNumIte: Integer;
      strCodIte: String;
      strDescri: String;
      fltQtdIte: Double;
      strUnidad: String;
      fltVlrCon: Double;
      fltDescon: Double;
      blnMovEstoque: Boolean;
      strCstIcms: String;
      strCfop: String;
      strCodNat: String;
      fltBaseIcms: Double;
      fltAlqIcms: Double;
      fltValIcms: Double;
      fltBaseST: Double;
      fltAlqST: Double;
      fltValorST: Double;
      strPerApuIpi: String;
      strCstIpi: String;
      strCodEnqIpi: String;
      fltBaseIPI: Double;
      fltAlqIPI: Double;
      fltValorIPI: Double;

      strCstPis: String;
      fltBasePis: Double;
      fltAlqPis: Double;
      fltValorPis: Double;

      strCstCofins: String;
      fltBaseCofins: Double;
      fltAlqCofins: Double;
      fltValorCofins: Double;

      constructor Create(strLinha: String);
  End;

Type
  TNotaFiscal = class(TObject)
    public
      strEntSai: String;
      blnEmiPropria: Boolean;
      strCodCli: String;
      strModelo: String;
      strSituacao: String;
      strSerie: String;
      strNumDoc: String;
      strChaveNfe: String;
      dtaDtaDoc: TDateTime;
      dtaDtaEnt: TDateTime;
      fltValorTotal: Double;
      strIndPagto: String;
      fltDesconto: Double;
      fltAbatNaoTrib: Double;
      fltTotalNota: Double;
      strTipoFrete: String;
      fltValorFrete: Double;
      fltValorSeguro: Double;
      fltDespAcessorias: Double;
      fltBaseIcms: Double;
      fltValorIcms: Double;
      fltBaseST: Double;
      fltValorST: Double;
      fltValorIPI: Double;
      fltValorPIS: Double;
      fltValorCofins: Double;
      fltValorPISST: Double;
      fltValorCOFINSST: Double;

      arrItemNota: Array Of TItemNota;

      constructor Create(strLinha: String);
      destructor Destroy; override;
      procedure pAdicionaItem(strLinha: String);
      function DeSaida: Boolean;
  end;

Type
  TItemCupom = class(TObject)
    fltValorTotal: Double;

    strCstPis: String;
    fltBasePis: Double;
    fltAlqPis: Double;
    fltValorPis: Double;

    strCstCof: String;
    fltBaseCof: Double;
    fltAlqCof: Double;
    fltValorCof: Double;

    strCodIte: String;

    constructor Create(strLinha: String);
    procedure pIncluiDadosCofins(strLinha: String);
  End;

Type
  TReducaoZ = class(TObject)
    public
      dtaData: TDateTime;
      arrItens: Array of TItemCupom;

      constructor Create(strLinha: String);
      destructor Destroy; override;
      procedure pAdicionarPis(strLinha: String);
      procedure pAdicionarCofins(strLinha: String);
  End;

Type
  TECF = class(TObject)
    strModelo: String;
    strNumSer: String;

    arrReducoes: Array Of TReducaoZ;

    constructor Create(strLinha: String);
    destructor Destroy; override;
    function fCriarReducao(strLinha: String): TReducaoZ;
  End;

Type
  TEmpresa = class(TObject)
  private
    function fRetCodEmpresa(strCnpj: String): String;
    public
      strCnpj: String;
      strCodEmp: String;
      arrNotas: Array Of TNotaFiscal;
      arrEcfs: Array Of TECF;

      constructor Create(strLinha: String);
      destructor Destroy; override;
      procedure pAdicionaNota(nota: TNotaFiscal);
      procedure pAdicionaEcf(ecf: TECF);
  end;

type
  TfrmImportaSpedPisCofins = class(TfrmPai)
    Label1: TLabel;
    Label2: TLabel;
    pgbEmpresa: TProgressBar;
    lblDocumentos: TLabel;
    pgbDocumentos: TProgressBar;
    cdsParticipantes: TUniClientDataSet;
    cdsParticipantesCODVEL: TStringField;
    cdsParticipantesCNPJ: TStringField;
    btnImportar: TBitBtnLocked;
    chkBuscaItem: TCheckBox;
    edtArquivo: TFilenameEditFocus;
    procedure btnImportarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    lstEmpresas: TList;
    empresaAtual: TEmpresa;
    ecfAtual: TECF;
    notaAtual: TNotaFiscal;
    reducaoAtual: TReducaoZ;

    strItemEspecial: String;
    strCodEmpresaAtual: String;
    
    procedure pProcessaLinha(strLinha, strLinhaFrente: String);
    procedure pGravarCupomEspecial(empresa: TEmpresa);
    procedure pCarregarCliente(fatVenda: TFatVenda; strCodigo: String; blnCadFor: Boolean);
    procedure pCarregaDadosItem(qryItens: TUniQuery; strCodIte: String; blnCodVel: Boolean);
    function fretItemEspecial: String;
    procedure pAcertaDadosDoDocumento(fatVenda: TFatVenda;
      dtaDtaDoc: TDateTime; blnEmiPropria: Boolean; strAcesso: String);
    procedure pAtualizaDadosCupomNoLivro(fatVenda: TFatVenda; strNumCoo,
      strNumeroSerie: String; dtaDtaDoc: TDateTime);
    procedure pGravarNotaEspecial(empresa: TEmpresa);
    procedure pLiberarTudo;
    function fRetornaCodigoConsumidor: String;
    { Private declarations }
  public
    { Public declarations }
  end;

function fRegistro(strLinha: String): String;
function fGetValorLinhaSped(strLinha: String; intColuna: Integer): String;
function fCampoDataSped(const strLinha: String;
  const intColuna: Integer): TDateTime;
function fCampoValorSped(const strLinha: String;
  const intColuna: Integer): Double;


implementation

uses untFuncoesSimples, untFuncFatTypes, untFuncoes;

{$R *.dfm}

procedure TfrmImportaSpedPisCofins.btnImportarClick(Sender: TObject);
  Var
    stlArquivo: TStringList;
    intContador: Integer;
    strLinhaFrente: String;
    empresa: TEmpresa;
begin
  inherited;
  If Not FileExists(edtArquivo.Text) Then
  Begin
    fMensagem('', 'Este arquivo não existe.', ['&Ok']);
    Exit;
  End;

  cdsParticipantes.EmptyDataSet;

  Try
    stlArquivo := TStringList.Create;
    stlArquivo.LoadFromFile(edtArquivo.Text);
    For intContador := 0 To stlArquivo.Count-1 Do
    Begin
      strLinhaFrente := '';
      If intContador < stlArquivo.Count-1 Then
        strLinhaFrente := stlArquivo[intContador+1];

      pProcessaLinha(stlArquivo[intContador], strLinhaFrente);
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[btnImportarClick]');
      Exit;
    End;
  End;


  btnImportar.Enabled := False;
  btnSair.Enabled := False;
  Screen.Cursor := crHourGlass;
  Application.ProcessMessages; 
//  fStartTransaction;
  Try
    pgbEmpresa.Max := lstEmpresas.Count;
    pgbEmpresa.Position := 0;
    
    For intContador := 0 To lstEmpresas.Count-1 Do
    Begin
      empresa := TEmpresa(lstEmpresas[intContador]);
      pSetaEmpresaLogada(empresa.strCodEmp);

      pGravarNotaEspecial(empresa);
      pGravarCupomEspecial(empresa);

      pgbEmpresa.StepBy(1);
      Application.ProcessMessages;
    End;
//    fCommit;

    fMensagem('', 'Importação concluída!', ['&Ok']);
  Except
    On E: Exception Do
    Begin
//      fRollBack;
      pMensagensErro(E.Message, '[btnImportarClick]');
    End;
  End;

  pSetaEmpresaLogada(strCodEmpresaAtual);

  pLiberarTudo;
  btnImportar.Enabled := True;
  btnSair.Enabled := True;
  Screen.Cursor := crDefault;
  Application.ProcessMessages;

  FreeAndNil(stlArquivo);
end;

procedure TfrmImportaSpedPisCofins.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  pSetaEmpresaLogada(strCodEmpresaAtual);
  pLiberarTudo;
  FreeAndNil(lstEmpresas);
end;

procedure TfrmImportaSpedPisCofins.pLiberarTudo;
  Var
    intContador: Integer;
    emp: TEmpresa;
begin
  inherited;
  For intContador := 0 To lstEmpresas.Count-1 Do
  Begin
    emp := lstEmpresas.Items[intContador];
    FreeAndNil(emp);
  End;
  lstEmpresas.Clear;
end;

procedure TfrmImportaSpedPisCofins.FormCreate(Sender: TObject);
begin
  inherited;
  notaAtual := Nil;
  empresaAtual := Nil;
  ecfAtual := Nil;
  reducaoAtual := Nil;

  lstEmpresas := TList.Create;

  strItemEspecial := fretItemEspecial;
  strCodEmpresaAtual := VS_strCodEmp;

  cdsParticipantes.CreateDataSet;

  edtArquivo.Dialog.Dialog.Filter := 'Arquivo Texto|*.txt';
end;

procedure TfrmImportaSpedPisCofins.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtArquivo);
end;

function TfrmImportaSpedPisCofins.fretItemEspecial: String;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('SELECT ITE_CODITE FROM CADITE WHERE ITE_DESITE LIKE "%ITEM ESPECIAL%" ');
  qryAux.Open;
  Result := qryAux.FieldByName('ITE_CODITE').AsString;
  FreeAndNil(qryAux);
end;

procedure TfrmImportaSpedPisCofins.pProcessaLinha(strLinha, strLinhaFrente: String);
  Var
    strRegistro: String;
begin
  strRegistro := fRegistro(strLinha);

  If strRegistro = '0150' Then
  Begin
    cdsParticipantes.Append;
    cdsParticipantes.FieldByName('CODVEL').AsString := fGetValorLinhaSped(strLinha, 2);
    cdsParticipantes.FieldByName('CNPJ').AsString := fGetValorLinhaSped(strLinha, 5);
    If fEmptyStr(cdsParticipantes.FieldByName('CNPJ').AsString) Then
      cdsParticipantes.FieldByName('CNPJ').AsString := fGetValorLinhaSped(strLinha, 6);
      
    cdsParticipantes.Post;
  End
  Else if (strRegistro = 'C010') then
  begin
    empresaAtual := TEmpresa.Create(strLinha);
    lstEmpresas.Add(empresaAtual);
  end
  Else
  If (strRegistro = 'C100') Then
  Begin
    If Not (fEmptyStr(fGetValorLinhaSped(strLinha, 10))) Then
    Begin
      notaAtual := TNotaFiscal.Create(strLinha);
      empresaAtual.pAdicionaNota(notaAtual);
    End;
  End
  Else if (strRegistro = 'C170') Then
  Begin
    notaAtual.pAdicionaItem(strLinha);
  End
  Else If (strRegistro = 'C400') Then
  Begin
    ecfAtual := TECF.Create(strLinha);
    empresaAtual.pAdicionaEcf(ecfAtual);
  End
  Else If (strRegistro = 'C405') Then
  Begin
    reducaoAtual := ecfAtual.fCriarReducao(strLinha);
  End
  Else If (strRegistro = 'C481') Then
  Begin
    reducaoAtual.pAdicionarPis(strLinha);
  End
  Else If (strRegistro = 'C485') Then
  Begin
    reducaoAtual.pAdicionarCofins(strLinha);
  End;
end;

procedure TfrmImportaSpedPisCofins.pGravarCupomEspecial(empresa: TEmpresa);
  Var
    dtaDtaDoc: TDateTime;
    fatVenda: TFatVenda;

    qryDadosItens: TUniQuery;
    forTin: TForTin;

    ecf: TECF;
    reducao: TReducaoZ;
    itemCupom: TItemCupom;

    dadosMadeira: TDadosMadeira;
begin
  FillChar(forTin, SizeOf(TForTin), #0);
  FillChar(dadosMadeira, SizeOf(TDadosMadeira), #0);

  itemCupom := nil;

  For ecf in empresa.arrEcfs Do
  Begin

    lblDocumentos.Caption := 'Gravando cupons ECF: ' + ecf.strNumSer;
    pgbDocumentos.Position := 0;
    pgbDocumentos.Max := Length(ecf.arrReducoes);

    For reducao in ecf.arrReducoes Do
    Begin
      dtaDtaDoc := reducao.dtaData;

      pCriarCdsVenda(Self);
      qryDadosItens := fCriaQuery(Self);

      fatVenda := TFatVenda.CreateInstance('VN', False);
      fatVenda.strOpcDocTrue := 'SP';
      fatVenda.strMen001 := 'IMPORTAÇÃO SPED';
      fatVenda.blnComTansacao := False;
      fatVenda.strNomeForm := 'frmFatVendas';
      fatVenda.strEspDoc := 'IF';
      fatVenda.blnCupEsp := True;
      fatVenda.strCodVen := strLoginUsuarioLogado;
      fatVenda.strCodDig := strLoginUsuarioLogado;
      fatVenda.strConPag := '01000';
      pCarregarCliente(fatVenda, '', False);

      If fEmptyStr(fatVenda.strTabPre) then
        fatVenda.strTabPre := '1';

      For itemCupom In reducao.arrItens Do
      Begin
        pCarregaDadosItem(qryDadosItens, itemCupom.strCodIte, True);
        If (qryDadosItens.IsEmpty) Then
        Begin
          If (chkBuscaItem.Checked) Then
            pCarregaDadosItem(qryDadosItens, itemCupom.strCodIte, False);

          If (Not chkBuscaItem.Checked) Or (qryDadosItens.IsEmpty) Then
          Begin
            pCarregaDadosItem(qryDadosItens, strItemEspecial, False);
            itemCupom.strCodIte := strItemEspecial;
          End;
        End
        Else
        Begin
          itemCupom.strCodIte := qryDadosItens.FieldByName('ITE_CODITE').AsString;
        End;

        If (qryDadosItens.IsEmpty) Then
        Begin
          Raise Exception.Create('Não foi encontrado o item ' + itemCupom.strCodIte + ' ou Item Especial.');
        End;

        fatVenda.pAdicionaRegistroTemporaria(cdsVenda,
          Nil, 'NOR',
          qryDadosItens.FieldByName('ITE_CODGRU').AsString,
          itemCupom.strCodIte,
          qryDadosItens.FieldByName('ITE_DESITE').AsString,
          qryDadosItens.FieldByName('ITE_DESITE').AsString,
          '',
          qryDadosItens.FieldByName('ITE_CODUNI').AsString,
          qryDadosItens.FieldByName('ITE_CODUNI').AsString,
          qryDadosItens.FieldByName('ITE_CODMAR').AsString,
          qryDadosItens.FieldByName('ITE_CODFOR').AsString,
          '',
          itemCupom.fltValorTotal,
          itemCupom.fltValorTotal,
          itemCupom.fltValorTotal,
          itemCupom.fltValorTotal,
          0,
          1.0,
          itemCupom.fltValorTotal,
          'S',
          itemCupom.fltValorTotal,
          itemCupom.fltValorTotal,
          'N',
          0,
          0,
          itemCupom.fltValorTotal,
          itemCupom.fltValorTotal,
          itemCupom.fltValorTotal,
          itemCupom.fltValorTotal,
          itemCupom.fltValorTotal,
          itemCupom.fltValorTotal,
          itemCupom.fltValorTotal,
          0,
          0,
          qryDadosItens.FieldByName('ITE_INCPIS').AsString,
          0,
          0,
          0,
          '',
          '',
          '',
          0,
          0,
          '',
          0,
          0,
          0,
          0,
          qryDadosItens.FieldByName('ITE_CLAIPI').AsString,
          '',
          '',
          '',
          '',
          0,
          '',
          0,
          0,
          0,
          0,
          0,
          '',
          '',
          0,
          0,
          qryDadosItens.FieldByName('ITE_CODABF').AsString,
          0,
          0,
          'N',
          0,
          0,
          0,
          0,
          '',
          0,
          '',
          0,
          0,
          '',
          '',
          '',
          0,
          0,
          0,
          '',
          '',
          0,
          0,
          '',
          '',
          '',
          0,
          '',
          '',
          '',
          0,
          0,
          0,
          '',
          '',
          'N',
          '',
          '',
          '',
          0,
          0,
          '',
          '',
          '',
          False,
          '',
          '',
          '',
          0,
          0,
          0,
          0,
          0,
          0,
          '',
          '',
          '',
          '1',
          0,
          0,
          '',
          0,
          '',
          0,
          '',
          '',
          'N',
          '',
          0,
          0,
          0,
          0,
          'N',
          '',
          itemCupom.fltValorTotal,
          itemCupom.fltValorTotal,
          0,
          0,
          0,
          0,
          0,
          0,
          forTin,
          '',
          '',
          '',
          '',
          '',
          False,
          '',
          '',
          0,
          '',
          '',
          '',
          0,
          0,
          0,
          '',
          0,
          False,
          '',
          '',
          '',
          0,
          0,
          '',
          '',
          dadosMadeira,
          0,
          0,
          0,
          '',
          0,
          '',
          '',
          0,
          0,
          '',
          '',
          0,
          '',
          'N',
          0,
          0,
          0,
          False,
          False,
          'N',
          '',
          0,
          0,
          '',
          'N',
          0,
          '',
          '',
          '',
          '',
          qryDadosItens.FieldByName('ITE_EXCIPI').AsString);
      End;

      Try
        fatVenda.blnComTansacao := False;
        fatVenda.pPreencheMatrizFechamento;
        fatVenda.pCalculaTotGer;

        If fatVenda.fGravaArquivos Then
        Begin
          pAtualizaDadosCupomNoLivro(fatVenda, '', ecf.strNumSer, dtaDtaDoc);
          pAcertaDadosDoDocumento(fatVenda, dtaDtaDoc, True, '');
        End
        Else
          Raise Exception.Create('Não foi possível gravar o cupom.');
      Except
        On E: Exception Do
        Begin
          Raise Exception.Create('Houve um erro ao gerar a nota especial(' +
            DateToStr(reducao.dtaData) + '-' + itemCupom.strCodIte + '): ' + E.Message);
        End;
      End;

      FreeAndNil(fatVenda);

      pgbDocumentos.StepBy(1);
      Application.ProcessMessages;
    End;

  End;
end;

procedure TfrmImportaSpedPisCofins.pGravarNotaEspecial(empresa: TEmpresa);
  Var
    dtaDtaDoc: TDateTime;
    fatVenda: TFatVenda;

    qryDadosItens: TUniQuery;
    forTin: TForTin;

    nota: TNotaFiscal;
    itemNota: TItemNota;

    dadosMadeira: TDadosMadeira;
    strOpcDoc: String;
    intIndItem: Integer;
begin
  FillChar(forTin, SizeOf(TForTin), #0);
  FillChar(dadosMadeira, SizeOf(TDadosMadeira), #0);

  lblDocumentos.Caption := 'Gravando notas...';
  pgbDocumentos.Position := 0;
  pgbDocumentos.Max := Length(empresa.arrNotas);

  For nota in empresa.arrNotas Do
  Begin
    If (nota.strSituacao <> '02') And (Length(nota.arrItemNota) > 0) Then
    Begin
      dtaDtaDoc := nota.dtaDtaEnt;

      pCriarCdsVenda(Self);
      qryDadosItens := fCriaQuery(Self);

      If (nota.DeSaida) Then
      Begin
        If nota.blnEmiPropria Then
          strOpcDoc := 'VN'
        Else
          strOpcDoc := 'OF';
      End
      Else
      Begin
        strOpcDoc := 'OE';
      End;

      fatVenda := TFatVenda.CreateInstance(IIF(nota.blnEmiPropria, 'VN', 'OF'), False);
      fatVenda.dicDesEspItens := TDicionario.Create;
      fatVenda.fltDesEsp := nota.fltDesconto;
      fatVenda.strMen001 := 'IMPORTAÇÃO SPED';
      fatVenda.blnComTansacao := False;
      fatVenda.strNomeForm := 'frmFatVendas';
      fatVenda.strNumDoc := nota.strNumDoc;
      fatVenda.strEspDoc := 'NF';
      fatVenda.blnNotEsp := True;
      fatVenda.strCodVen := strLoginUsuarioLogado;
      fatVenda.strCodDig := strLoginUsuarioLogado;
      fatVenda.strConPag := '01000';
      fatVenda.blnNovoSequencial := False;
      fatVenda.blnImportacaoSpedPisCofins := True;
      pCarregarCliente(fatVenda, nota.strCodCli, Not nota.blnEmiPropria);
      fatVenda.dicDesEspItens.Limpar;

      If fEmptyStr(fatVenda.strTabPre) then
        fatVenda.strTabPre := '1';

      For itemNota In nota.arrItemNota Do
      Begin
        pCarregaDadosItem(qryDadosItens, itemNota.strCodIte, True);
        If (qryDadosItens.IsEmpty) Then
        Begin
          If (chkBuscaItem.Checked) Then
            pCarregaDadosItem(qryDadosItens, itemNota.strCodIte, False);

          If (Not chkBuscaItem.Checked) And (qryDadosItens.IsEmpty) Then
          Begin
            pCarregaDadosItem(qryDadosItens, strItemEspecial, False);
            itemNota.strCodIte := strItemEspecial;
          End;
        End
        Else
        Begin
          itemNota.strCodIte := qryDadosItens.FieldByName('ITE_CODITE').AsString;
        End;

        If (qryDadosItens.IsEmpty) Then
        Begin
          Raise Exception.Create('Não foi encontrado o item ' + itemNota.strCodIte + ' ou Item Especial.');
        End;

        fatVenda.pAdicionaRegistroTemporaria(cdsVenda,
          Nil, 'NOR',
          qryDadosItens.FieldByName('ITE_CODGRU').AsString,
          itemNota.strCodIte,
          qryDadosItens.FieldByName('ITE_DESITE').AsString,
          qryDadosItens.FieldByName('ITE_DESITE').AsString,
          '',
          qryDadosItens.FieldByName('ITE_CODUNI').AsString,
          qryDadosItens.FieldByName('ITE_CODUNI').AsString,
          qryDadosItens.FieldByName('ITE_CODMAR').AsString,
          qryDadosItens.FieldByName('ITE_CODFOR').AsString,
          '',
          itemNota.fltVlrCon / itemNota.fltQtdIte,
          itemNota.fltVlrCon / itemNota.fltQtdIte,
          itemNota.fltVlrCon / itemNota.fltQtdIte,
          itemNota.fltVlrCon / itemNota.fltQtdIte,
          0,
          itemNota.fltQtdIte,
          itemNota.fltVlrCon,
          'S',
          itemNota.fltVlrCon / itemNota.fltQtdIte,
          itemNota.fltVlrCon,
          'N',
          0,
          0,
          itemNota.fltVlrCon / itemNota.fltQtdIte,
          itemNota.fltVlrCon / itemNota.fltQtdIte,
          itemNota.fltVlrCon / itemNota.fltQtdIte,
          itemNota.fltVlrCon / itemNota.fltQtdIte,
          itemNota.fltVlrCon / itemNota.fltQtdIte,
          itemNota.fltVlrCon / itemNota.fltQtdIte,
          itemNota.fltVlrCon / itemNota.fltQtdIte,
          0,
          0,
          qryDadosItens.FieldByName('ITE_INCPIS').AsString,
          0,
          0,
          0,
          '',
          '',
          '',
          0,
          0,
          '',
          0,
          0,
          0,
          0,
          qryDadosItens.FieldByName('ITE_CLAIPI').AsString,
          '',
          '',
          '',
          '',
          0,
          '',
          0,
          0,
          0,
          0,
          0,
          '',
          '',
          0,
          0,
          qryDadosItens.FieldByName('ITE_CODABF').AsString,
          0,
          0,
          'N',
          0,
          0,
          0,
          0,
          '',
          0,
          '',
          0,
          0,
          '',
          '',
          '',
          0,
          0,
          0,                    
          '',
          '',
          0,
          0,
          '',
          '',
          '',
          0,
          '',
          '',
          '',
          0,
          0,
          0,
          '',
          '',
          'N',
          '',
          '',
          '',
          0,
          0,
          '',
          '',
          '',
          False,
          '',
          '',
          '',
          0,
          0,
          0,
          0,
          0,
          0,
          '',
          '',
          '',
          '1',
          0,
          0,
          '',
          0,
          '',
          0,
          '',
          '',
          'N',
          '',
          0,
          0,
          0,
          0,
          'N',
          '',
          itemNota.fltVlrCon,
          itemNota.fltVlrCon,
          0,
          0,
          0,
          0,
          0,
          0,
          forTin,
          '',
          '',
          '',
          '',
          '',
          False,
          '',
          '',
          0,
          '',
          '',
          '',
          0,
          0,
          0,
          '',
          0,
          False,
          '',
          '',
          '',          
          0,
          0,
          '',
          '',          
          dadosMadeira,
          0,
          0,
          0,
          '',
          0,
          '',
          '',
          0,
          0,
          '',
          '',
          0,
          '',
          'N',
          0,
          0,
          0,
          False,
          False,
          'N',
          '',
          0,
          0,
          '',
          'N',
          0,
          '',
          '',
          '',
          '',
          qryDadosItens.FieldByName('ITE_EXCIPI').AsString);

        cdsVenda.Edit;
        cdsVenda.FieldByName('AUTOINCREM').AsString := IntToStr(itemNota.intNumIte);
        cdsVenda.Post;

        fatvenda.dicDesEspItens[IntToStr(itemNota.intNumIte)] := itemNota.fltDescon;
      End;

      fatVenda.blnComTansacao := False;
      fatVenda.pPreencheMatrizFechamento;

      intIndItem := 0;
      For itemNota In nota.arrItemNota Do
      Begin
        fatVenda.arrMatItens[intIndItem].strCodFis := itemNota.strCstIcms;
        Inc(intIndItem);
      End;

      fatVenda.pCalculaTotGer;

      If NOt nota.blnEmiPropria Then
      Begin
        fatVenda.strCodFor := fatVenda.strCodCli;
        fatVenda.strCodCli := '';
      End;

      For itemNota In nota.arrItemNota Do
      Begin
        For intIndItem := Low(fatVenda.arrMatItens) To High(fatVenda.arrMatItens) Do
        Begin
          If fatVenda.arrMatItens[intIndItem].intAutInc = itemNota.intNumIte Then
          Begin
            fatVenda.arrMatItens[intIndItem].strCodFis := itemNota.strCstIcms;
            fatVenda.arrMatItens[intIndItem].strClaFis := itemNota.strCfop;
            fatVenda.arrMatItens[intIndItem].fltBasIpi := itemNota.fltBaseIPI;
            fatVenda.arrMatItens[intIndItem].fltAlqIpi := itemNota.fltAlqIPI;
            fatVenda.arrMatItens[intIndItem].fltValipi := itemNota.fltValorIPI;
            fatVenda.arrMatItens[intIndItem].fltBasRet := itemNota.fltBaseST;
            fatVenda.arrMatItens[intIndItem].fltAlqRet := itemNota.fltAlqST;
            fatVenda.arrMatItens[intIndItem].fltValRet := itemNota.fltValorST;
            fatVenda.arrMatItens[intIndItem].fltBasIcm := itemNota.fltBaseIcms;
            fatVenda.arrMatItens[intIndItem].fltAlqIcm := itemNota.fltAlqIcms;
            fatVenda.arrMatItens[intIndItem].fltValIcm := itemNota.fltValIcms;
            Break;
          End;
        End;
      End;

      Try
        If fatVenda.fGravaArquivos Then
        Begin
          pAcertaDadosDoDocumento(fatVenda, dtaDtaDoc, nota.blnEmiPropria, nota.strChaveNfe);
        End
        Else
          Raise Exception.Create('Não foi possível gravar o cupom.');
      Except
        On E: Exception Do
        Begin
          Raise Exception.Create('Houve um erro ao gerar a nota especial: ' + E.Message);
        End;
      End;

      FreeAndNil(fatVenda);

      pgbDocumentos.StepBy(1);
      Application.ProcessMessages;
    End;

  End;

end;

procedure TfrmImportaSpedPisCofins.pAtualizaDadosCupomNoLivro(fatVenda: TFatVenda;
  strNumCoo, strNumeroSerie: String; dtaDtaDoc: TDateTime);
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('UPDATE CADFIS SET ');
  qryAux.SQL.Add('  FIS_DTAENT = :DTAENT, ');
  qryAux.SQL.Add('  FIS_DTADOC = :DTAENT, ');
  qryAux.SQL.Add('  FIS_NUMSER = :NUMSER, ');
  qryAux.SQL.Add('  FIS_NUMCOO = :NUMCOO ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  FIS_NUMDOC = :NUMDOC AND ');
  qryAux.SQL.Add('  FIS_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  FIS_CODEMP = :CODEMP AND ');
  qryAux.SQL.Add('  FIS_FORCLI = :CODCLI AND ');
  qryAux.SQL.Add('  FIS_TIP_FC = "C" AND ');
  qryAux.SQL.Add('  IFNULL(FIS_SERIE_, "") = :SERIE_ ');

  qryAux.ParamByName('DTAENT').AsDateTime := dtaDtaDoc;
  qryAux.ParamByName('NUMSER').AsString := strNumeroSerie;
  qryAux.ParamByName('NUMCOO').AsString := strNumCoo;

  qryAux.ParamByName('NUMDOC').AsString := fatVenda.strNumDoc;
  qryAux.ParamByName('ESPDOC').AsString := fatVenda.strEspDoc;
  qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryAux.ParamByName('CODCLI').AsString := fatVenda.strCodCli;
  qryAux.ParamByName('SERIE_').AsString := fatVenda.strSerFsc;

  qryAux.ExecSQL;

  FreeAndNil(qryAux);
end;

procedure TfrmImportaSpedPisCofins.pAcertaDadosDoDocumento(fatVenda: TFatVenda;
  dtaDtaDoc: TDateTime; blnEmiPropria: Boolean; strAcesso: String);
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('UPDATE NOTGER SET ');
  qryAux.SQL.Add('  GER_DTAENT = :DTAENT, ');
  qryAux.SQL.Add('  GER_IMPRES = 1, ');
  qryAux.SQL.Add('  GER_ORIDOC = :ORIDOC ');
//  qryAux.SQL.Add('  GER_CODFOR = IF(:ORIDOC = "", GER_CODCLI, NULL), ');
//  qryAux.SQL.Add('  GER_CODCLI = IF(:ORIDOC = "", NULL, GER_CODCLI) ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
  qryAux.SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  GER_CODEMP = :CODEMP AND ');
  qryAux.SQL.Add('  IF(GER_TIP_FC="C", GER_CODCLI, GER_CODFOR) = :CODCLI AND ');
  qryAux.SQL.Add('  IFNULL(GER_SERIE_, "") = :SERIE_ ');

  qryAux.ParamByName('DTAENT').AsDateTime := dtaDtaDoc;
  iF blnEmiPropria Then
  Begin
    qryAux.ParamByName('ORIDOC').AsString := 'V';
  End
  Else
  Begin
    qryAux.ParamByName('ORIDOC').AsString := '';
  End;

  qryAux.ParamByName('NUMDOC').AsString := fatVenda.strNumDoc;
  qryAux.ParamByName('ESPDOC').AsString := fatVenda.strEspDoc;
  qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryAux.ParamByName('CODCLI').AsString := IIF(Not fEmptyStr(fatVenda.strCodCli),
                                               fatVenda.strCodCli,
                                               fatVenda.strCodFor);
  qryAux.ParamByName('SERIE_').AsString := fatVenda.strSerFsc;

  qryAux.ExecSQL;

  qryAux.SQL.Clear;
  qryAux.SQL.Add('UPDATE NOTDET SET ');
  qryAux.SQL.Add('  DET_DTAENT = :DTAENT, ');
  qryAux.SQL.Add('  DET_IMPRES = 1, ');
  qryAux.SQL.Add('  DET_ORIDOC = :ORIDOC ');
//  qryAux.SQL.Add('  DET_CODFOR = IF(:ORIDOC = "", DET_CODCLI, NULL), ');
//  qryAux.SQL.Add('  DET_CODCLI = IF(:ORIDOC = "", NULL, DET_CODCLI) ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  DET_NUMDOC = :NUMDOC AND ');
  qryAux.SQL.Add('  DET_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  DET_CODEMP = :CODEMP AND ');
  qryAux.SQL.Add('  IF(DET_TIP_FC="C", DET_CODCLI, DET_CODFOR) = :CODCLI AND ');
  qryAux.SQL.Add('  IFNULL(DET_SERIE_, "") = :SERIE_ ');

  qryAux.ParamByName('DTAENT').AsDateTime := dtaDtaDoc;
  iF blnEmiPropria Then
  Begin
    qryAux.ParamByName('ORIDOC').AsString := 'V';
  End
  Else
  Begin
    qryAux.ParamByName('ORIDOC').AsString := '';
  End;

  qryAux.ParamByName('NUMDOC').AsString := fatVenda.strNumDoc;
  qryAux.ParamByName('ESPDOC').AsString := fatVenda.strEspDoc;
  qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryAux.ParamByName('CODCLI').AsString := IIF(Not fEmptyStr(fatVenda.strCodCli),
                                               fatVenda.strCodCli,
                                               fatVenda.strCodFor);
  qryAux.ParamByName('SERIE_').AsString := fatVenda.strSerFsc;

  qryAux.ExecSQL;

  qryAux.SQL.Clear;
  qryAux.SQL.Add('UPDATE CADFIS SET ');
  qryAux.SQL.Add('  FIS_DTAENT = :DTAENT, ');
  qryAux.SQL.Add('  FIS_DTADOC = :DTAENT, ');
  qryAux.SQL.Add('  FIS_ORIDOC = :ORIDOC, ');
  qryAux.SQL.Add('  FIS_ACESSO = :ACESSO ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  FIS_NUMDOC = :NUMDOC AND ');
  qryAux.SQL.Add('  FIS_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  FIS_CODEMP = :CODEMP AND ');
  qryAux.SQL.Add('  FIS_FORCLI = :CODCLI AND ');
  qryAux.SQL.Add('  IFNULL(FIS_SERIE_, "") = :SERIE_ ');

  qryAux.ParamByName('DTAENT').AsDateTime := dtaDtaDoc;
  iF blnEmiPropria Then
  Begin
    qryAux.ParamByName('ORIDOC').AsString := 'V';
  End
  Else
  Begin
    qryAux.ParamByName('ORIDOC').AsString := '';
  End;
  qryAux.ParamByName('ACESSO').AsString := strAcesso;

  qryAux.ParamByName('NUMDOC').AsString := fatVenda.strNumDoc;
  qryAux.ParamByName('ESPDOC').AsString := fatVenda.strEspDoc;
  qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryAux.ParamByName('CODCLI').AsString := IIF(Not fEmptyStr(fatVenda.strCodCli),
                                               fatVenda.strCodCli,
                                               fatVenda.strCodFor);
  qryAux.ParamByName('SERIE_').AsString := fatVenda.strSerFsc;

  qryAux.ExecSQL;

  FreeAndNil(qryAux);
end;

procedure TfrmImportaSpedPisCofins.pCarregarCliente(fatVenda: TFatVenda;
  strCodigo: String; blnCadFor: Boolean);
  Var
    qryCli: TUniQuery;
begin
  qryCli := fCriaQuery(Self);
  If Not fEmptyStr(strCodigo) Then
    If Not cdsParticipantes.Locate('CODVEL', strCodigo, []) Then
      Raise Exception.Create('Participante ' + strCodigo + ' não mencionado no registro 0150.');
  
  qryCli.SQL.Add('SELECT ');
  qryCli.SQL.Add('  CLI_CODCLI ');
  qryCli.SQL.Add('FROM ');
  qryCli.SQL.Add('  CADCLI ');
  qryCli.SQL.Add('WHERE ');

  If fEmptyStr(strCodigo) Then
    qryCli.SQL.Add('  CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" LIMIT 1')
  Else
  Begin
    qryCli.SQL.Add('  CLI_C_G_C_ = :CODVEL ');
    qryCli.ParamByName('CODVEL').AsString := cdsParticipantes.FieldByName('CNPJ').AsString;
  End;

  qryCli.Open;

  If (qryCli.IsEmpty) And (Not fEmptyStr(strCodigo)) Then
  Begin
    qryCli.SQL.Add('SELECT ');
    qryCli.SQL.Add('  CLI_CODCLI ');
    qryCli.SQL.Add('FROM ');
    qryCli.SQL.Add('  CADCLI ');
    qryCli.SQL.Add('WHERE ');
    qryCli.SQL.Add('  CLI_CODVEL = :CODVEL ');
    qryCli.ParamByName('CODVEL').AsString := cdsParticipantes.FieldByName('CNPJ').AsString;
    qryCli.Open;
  End;

  If Not qryCli.IsEmpty Then
  Begin
    fatVenda.pCarregaDadosClienteBaixa(qryCli.FieldByName('CLI_CODCLI').AsString);
  End
  Else
  Begin
    qryCli.SQL.Clear;
    qryCli.SQL.Add('SELECT ');
    qryCli.SQL.Add('  FOR_CODFOR, FOR_NOMFOR, FOR_ENDNUM, FOR_ENDCOM, ');
    qryCli.SQL.Add('  FOR_ENDERE, FOR_BAIRRO, FOR_C_E_P_, ');
    qryCli.SQL.Add('  FOR_CODCID, FOR_FONE01, FOR_EMAIL_, FOR_EMAIL2, ');
    qryCli.SQL.Add('  FOR_CODATI, FOR_C_G_C_, ');
    qryCli.SQL.Add('  FOR_OBSERV ');
    qryCli.SQL.Add('FROM ');
    qryCli.SQL.Add('  CADFOR ');
    qryCli.SQL.Add('WHERE ');
    qryCli.SQL.Add('  FOR_C_G_C_ = :CODVEL ');

    qryCli.ParamByName('CODVEL').AsString := cdsParticipantes.FieldByName('CNPJ').AsString;
    qryCli.Open;

    If Not qryCli.IsEmpty Then
    Begin
      fatVenda.strCodCli := qryCli.FieldByName('FOR_CODFOR').AsString;
      fatVenda.strCliOri := qryCli.FieldByName('FOR_NOMFOR').AsString;
      fatVenda.strCliNom := qryCli.FieldByName('FOR_NOMFOR').AsString;
      fatVenda.strCliEnd := qryCli.FieldByName('FOR_ENDERE').AsString + ', ' +
                            qryCli.FieldByName('FOR_ENDNUM').AsString;
      fatVenda.strCliNum := qryCli.FieldByName('FOR_ENDNUM').AsString;
      fatVenda.strCliCom := qryCli.FieldByName('FOR_ENDCOM').AsString;
      fatVenda.strCliBai := qryCli.FieldByName('FOR_BAIRRO').AsString;
      fatVenda.strCliCep := qryCli.FieldByName('FOR_C_E_P_').AsString;
      fatVenda.strCodCid := qryCli.FieldByName('FOR_CODCID').AsString;
      fatVenda.strCliCid := fRetNomCidade(qryCli.FieldByName('FOR_CODCID').AsString);
      fatVenda.strCliEst := fRetNomCidade(qryCli.FieldByName('FOR_CODCID').AsString, 1);
      fatVenda.strCliTel := qryCli.FieldByName('FOR_FONE01').AsString;
      fatVenda.strCli_Rg := '';
      fatVenda.strCliCgc := qryCli.FieldByName('FOR_C_G_C_').AsString;
      fatVenda.strObserv := qryCli.FieldByName('FOR_OBSERV').AsString;
      fatVenda.strCliAti := '';
      fatVenda.strCliEma := qryCli.FieldByName('FOR_EMAIL_').AsString;
      fatVenda.strCliEm2 := '';
    End
    Else
    Begin
      qryCli.SQL.Clear;
      qryCli.SQL.Add('SELECT ');
      qryCli.SQL.Add('  CON_CODCON, CON_NOMCON, "" AS CON_ENDNUM, CON_ENDERE, ');
      qryCli.SQL.Add('  CON_ENDERE, CON_BAIRRO, CON_C_E_P_, ');
      qryCli.SQL.Add('  CON_CODCID, CON_FONE01, "" AS CON_EMAIL_, "" AS CON_EMAIL2, ');
      qryCli.SQL.Add('  CON_C_P_F_ ');
      qryCli.SQL.Add('FROM ');
      qryCli.SQL.Add('  CLICON ');
      qryCli.SQL.Add('WHERE ');
      qryCli.SQL.Add('  CON_C_P_F_ = :CODVEL ');

      qryCli.ParamByName('CODVEL').AsString := cdsParticipantes.FieldByName('CNPJ').AsString;
      qryCli.Open;

      If qryCli.IsEmpty Then
      Begin
        Raise VerificacaoException.Create('Cliente / Fornecedor / Consumidor' + cdsParticipantes.FieldByName('CNPJ').AsString + ' não cadastrado. ' +
          'Favor cadastrar antes de continuar.');
      End
      Else
      Begin
        fatVenda.strCodCli := fRetornaCodigoConsumidor;
        fatVenda.strCliOri := qryCli.FieldByName('CON_NOMCON').AsString;
        fatVenda.strCliNom := qryCli.FieldByName('CON_NOMCON').AsString;
        fatVenda.strCliEnd := qryCli.FieldByName('CON_ENDERE').AsString;
        fatVenda.strCliNum := '';
        fatVenda.strCliCom := qryCli.FieldByName('CON_ENDERE').AsString;
        fatVenda.strCliBai := qryCli.FieldByName('CON_BAIRRO').AsString;
        fatVenda.strCliCep := qryCli.FieldByName('CON_C_E_P_').AsString;
        fatVenda.strCodCid := qryCli.FieldByName('CON_CODCID').AsString;
        fatVenda.strCliCid := fRetNomCidade(qryCli.FieldByName('CON_CODCID').AsString);
        fatVenda.strCliEst := fRetNomCidade(qryCli.FieldByName('CON_CODCID').AsString, 1);
        fatVenda.strCliTel := qryCli.FieldByName('CON_FONE01').AsString;
        fatVenda.strCli_Rg := '';
        fatVenda.strCliCgc := qryCli.FieldByName('CON_C_P_F_').AsString;
        fatVenda.strObserv := '';
        fatVenda.strCliAti := '';
        fatVenda.strCliEma := '';
        fatVenda.strCliEm2 := '';
      End;
    End;
  End;

  FreeAndNil(qryCli);
end;

procedure TfrmImportaSpedPisCofins.pCarregaDadosItem(qryItens: TUniQuery;
  strCodIte: String; blnCodVel: Boolean);
  Var
    strTamCod: String;
begin
  qryItens.SQL.Clear;
  qryItens.SQL.Add('SELECT ');
  qryItens.SQL.Add('  ITE_CODITE, ');
  qryItens.SQL.Add('  ITE_CODGRU, ');
  qryItens.SQL.Add('  ITE_DESITE, ');
  qryItens.SQL.Add('  ITE_CODUNI, ');
  qryItens.SQL.Add('  ITE_CODMAR, ');
  qryItens.SQL.Add('  ITE_CODFOR, ');
  qryItens.SQL.Add('  ITE_INCPIS, ');
  qryItens.SQL.Add('  ITE_CLAIPI, ');
  qryItens.SQL.Add('  ITE_EXCIPI, ');
  qryItens.SQL.Add('  ITE_CODABF ');
  qryItens.SQL.Add('FROM ');
  qryItens.SQL.Add('  CADITE ');
  qryItens.SQL.Add('WHERE ');
  If blnCOdVel Then
  Begin
    qryItens.SQL.Add('  ITE_CODVEL = :CODITE ');
    qryItens.ParamByName('CODITE').AsString := strCodIte;
  End
  Else
  Begin
    qryItens.SQL.Add('  ITE_CODITE = :CODITE ');
    If StrToIntDef(strCodIte, -1) = -1 Then
      qryItens.ParamByName('CODITE').AsString := strCodIte
    Else
      qryItens.ParamByName('CODITE').AsInteger := StrToIntDef(strCodIte, -1);
  End;


  qryItens.Open;

  If qryItens.IsEmpty Then
  Begin
    strTamCod := IntToStr(Length(strCodIte));

    qryItens.SQL.Clear;
    qryItens.SQL.Add('SELECT ');
    qryItens.SQL.Add('  ITE_CODITE, ');
    qryItens.SQL.Add('  ITE_CODGRU, ');
    qryItens.SQL.Add('  ITE_DESITE, ');
    qryItens.SQL.Add('  ITE_CODUNI, ');
    qryItens.SQL.Add('  ITE_CODMAR, ');
    qryItens.SQL.Add('  ITE_CODFOR, ');
    qryItens.SQL.Add('  ITE_INCPIS, ');
    qryItens.SQL.Add('  ITE_CLAIPI, ');
    qryItens.SQL.Add('  ITE_EXCIPI, ');
    qryItens.SQL.Add('  ITE_CODABF ');
    qryItens.SQL.Add('FROM ');
    qryItens.SQL.Add('  CADITE ');
    qryItens.SQL.Add('WHERE ');
    If blnCodVel Then
      qryItens.SQL.Add('  LPAD(ITE_CODVEL, ' + strTamCod + ', "0") = :CODITE ')
    Else
      qryItens.SQL.Add('  LPAD(ITE_CODITE, ' + strTamCod + ', "0") = :CODITE ');

    qryItens.ParamByName('CODITE').AsString := strCodIte;
    qryItens.Open;
  End;
end;

function fRegistro(strLinha: String): String;
begin
  Result := fGetValorLinhaSped(strLinha, 1);
end;

function fGetValorLinhaSped(strLinha: String; intColuna: Integer): String;
begin
  Result := fGetValorLinha(strLinha, '|', intColuna, True);
end;

function fCampoDataSped(
  const strLinha: String; const intColuna: Integer): TDateTime;
  Var
    strData: String;
    strDia: String;
    strMes: String;
    strAno: String;
begin
  strData := fGetValorLinhaSped(strLinha, intColuna);
  strDia := LeftStr(strData, 2);
  strMes := Copy(strData, 3, 2);
  strAno := RightStr(strData, 4);

  Result := EncodeDate(StrToInt(strAno), StrToInt(strMes), StrToInt(strDia));
end;

function fCampoValorSped(const strLinha: String;
  const intColuna: Integer): Double;
Begin
  Result := fStrToFloat(fGetValorLinhaSped(strLinha, intColuna));
End;

{ TNotaFiscal }

constructor TNotaFiscal.Create(strLinha: String);
begin
  SetLength(arrItemNota, 0);

  strSituacao := fGetValorLinhaSped(strLinha, 6);
  If strSituacao = '02' Then
  Begin
    Exit;
  End;

  strEntSai := IIF(fGetValorLinhaSped(strLinha, 2)='0', 'E', 'S');
  blnEmiPropria := IIF(fGetValorLinhaSped(strLinha, 3)= '0', True, False);
  strCodCli := fGetValorLinhaSped(strLinha, 4);
  strModelo := fGetValorLinhaSped(strLinha, 5);
  strSerie := fGetValorLinhaSped(strLinha, 7);
  strNumDoc := fGetValorLinhaSped(strLinha, 8);
  strChaveNfe := fGetValorLinhaSped(strLinha, 9);
  dtaDtaDoc := fCampoDataSped(strLInha, 10);
  dtaDtaEnt := fCampoDataSped(strLInha, 11);
  fltValorTotal := fCampoValorSped(strLinha, 12);
  strIndPagto := fGetValorLinhaSped(strLinha, 13);
  fltDesconto := fCampoValorSped(strLinha, 14);
  fltAbatNaoTrib := fCampoValorSped(strLinha, 15);
  fltTotalNota := fCampoValorSped(strLinha, 16);
  strTipoFrete := fGetValorLinhaSped(strLinha, 17);
  fltValorFrete := fCampoValorSped(strLinha, 18);
  fltValorSeguro := fCampoValorSped(strLinha, 19);
  fltDespAcessorias := fCampoValorSped(strLinha, 20);
  fltBaseIcms := fCampoValorSped(strLinha, 21);
  fltValorIcms := fCampoValorSped(strLinha, 22);
  fltBaseST := fCampoValorSped(strLinha, 23);
  fltValorST := fCampoValorSped(strLinha, 24);
  fltValorIPI := fCampoValorSped(strLinha, 25);
  fltValorPIS := fCampoValorSped(strLinha, 26);
  fltValorCofins := fCampoValorSped(strLinha, 27);
  fltValorPISST := fCampoValorSped(strLinha, 28);
  fltValorCOFINSST := fCampoValorSped(strLinha, 29);
end;

function TNotaFiscal.DeSaida: Boolean;
  Var
    intContador: Integer;
begin
  Result := False;
  For intContador := Low(arrItemNota) To High(arrItemNota) Do
  Begin
    If arrItemNota[intContador].strCfop > '5000' Then
    Begin
      Result := True;
      Break;
    End;
  End;
end;

destructor TNotaFiscal.Destroy;
  Var
    intContador: Integer;
begin
  For intContador := Low(arrItemNota) To High(arrItemNota) Do
  Begin
    FreeAndNil(arrItemNota[intContador]);
  End;
  SetLength(arrItemNota,0);
  inherited;
end;

procedure TNotaFiscal.pAdicionaItem(strLinha: String);
  Var
    intTamMat: Integer;
    item: TItemNota;
begin
  item := TItemNota.Create(strLinha);

  If Pos(item.strCfop, '5929_6929_') <= 0 Then
  Begin
    intTamMat := Length(arrItemNota);
    SetLength(arrItemNota, intTamMat+1);
    arrItemNota[intTamMat] := item;
  End;
end;

{ TItemNota }

constructor TItemNota.Create(strLinha: String);
begin
  intNumIte := StrToInt(fGetValorLinhaSped(strLinha, 2));
  strCodIte := fGetValorLinhaSped(strLinha, 3);
  strDescri := fGetValorLinhaSped(strLinha, 4);
  fltQtdIte := fCampoValorSped(strLinha, 5);
  strUnidad := fGetValorLinhaSped(strLinha, 6);
  fltVlrCon := fCampoValorSped(strLinha, 7);
  fltDescon := fCampoValorSped(strLinha, 8);
  blnMovEstoque := IIF(fGetValorLinhaSped(strLinha, 9)='0', True, False);
  strCstIcms := fGetValorLinhaSped(strLinha, 10);
  strCfop := fGetValorLinhaSped(strLinha, 11);
  strCodNat := fGetValorLinhaSped(strLinha, 12);
  fltBaseIcms := fCampoValorSped(strLinha, 13);
  fltAlqIcms := fCampoValorSped(strLinha, 14);
  fltValIcms := fCampoValorSped(strLinha, 15);
  fltBaseST := fCampoValorSped(strLinha, 16);
  fltAlqST := fCampoValorSped(strLinha, 17);
  fltValorST := fCampoValorSped(strLinha, 18);
  strPerApuIpi := fGetValorLinhaSped(strLinha, 19);
  strCstIpi := fGetValorLinhaSped(strLinha, 20);
  strCodEnqIpi := fGetValorLinhaSped(strLinha, 21);
  fltBaseIPI := fCampoValorSped(strLinha, 22);
  fltAlqIPI := fCampoValorSped(strLinha, 23);
  fltValorIPI := fCampoValorSped(strLinha, 24);

  strCstPis := fGetValorLinhaSped(strLinha, 25);
  fltBasePis := fCampoValorSped(strLinha, 26);
  fltAlqPis := fCampoValorSped(strLinha, 27);
  fltValorPis := fCampoValorSped(strLinha, 30);

  strCstCofins := fGetValorLinhaSped(strLinha, 31);
  fltBaseCofins := fCampoValorSped(strLinha, 32);
  fltAlqCofins := fCampoValorSped(strLinha, 33);
  fltValorCofins := fCampoValorSped(strLinha, 36);
end;

{ TEmpresa }

constructor TEmpresa.Create(strLinha: String);
begin
  strCnpj := fGetValorLinhaSped(strLinha, 2);
  strCodEmp := fRetCodEmpresa(strCnpj);

  SetLength(arrNotas, 0);
  SetLength(arrEcfs, 0);
end;

function TEmpresa.fRetCodEmpresa(strCnpj: String): String;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT EMP_CODEMP FROM CADEMP WHERE EMP_C_G_C_ = :CGCEMP');
  qryAux.ParamByName('CGCEMP').AsString := strCnpj;
  qryAux.Open;

  If qryAux.IsEmpty Then
  Begin
    Raise Exception.Create('CNPJ ' + strCnpj + ' não encontrado no cadastro de empresas.');
  End;

  Result := qryAux.FieldByName('EMP_CODEMP').AsString;

  FreeAndNil(qryAux);
end;

destructor TEmpresa.Destroy;
  Var
    intContador: Integer;
begin
  For intContador := Low(arrNotas) To High(arrNotas) Do
  Begin
    FreeAndNil(arrNotas[intContador]);
  End;
  SetLength(arrNotas, 0);

  For intContador := Low(arrEcfs) To High(arrNotas) Do
  Begin
    FreeAndNil(arrEcfs[intContador]);
  End;
  SetLength(arrEcfs, 0);
  inherited;
end;

procedure TEmpresa.pAdicionaEcf(ecf: TECF);
  Var
    intTamMat: Integer;
begin
  intTamMat := Length(arrEcfs);
  SetLength(arrEcfs, intTamMat+1);
  arrEcfs[intTamMat] := ecf;
end;

procedure TEmpresa.pAdicionaNota(nota: TNotaFiscal);
  Var
    intTamMat: Integer;
begin
  intTamMat := Length(arrNotas);
  SetLength(arrNotas, intTamMat+1);
  arrNotas[intTamMat] := nota;
end;

{ TECF }

constructor TECF.Create(strLinha: String);
begin
  strModelo := fGetValorLinhaSped(strLinha, 3);
  strNumSer := fGetValorLinhaSped(strLinha, 4);
end;

destructor TECF.Destroy;
  Var
    intContador: Integer;
begin
  For intContador := Low(arrReducoes) To High(arrReducoes) Do
  Begin
    FreeAndNil(arrReducoes[intContador]);
  End;
  SetLength(arrReducoes, 0);
  inherited;
end;

function TECF.fCriarReducao(strLinha: String): TReducaoZ;
  Var
    intTamMat: Integer;
begin
  intTamMat := Length(arrReducoes);
  SetLength(arrReducoes, intTamMat+1);
  arrReducoes[intTamMat] := TReducaoZ.Create(strLinha);

  Result := arrReducoes[intTamMat];
end;

{ TReducaoZ }

constructor TReducaoZ.Create(strLinha: String);
begin
  dtaData := fCampoDataSped(strLinha, 2);
end;

destructor TReducaoZ.Destroy;
  Var
    intContador: Integer;
begin
  For intContador := Low(arrItens) To High(arrItens) Do
  Begin
    FreeAndNil(arrItens[intContador]);
  End;
  SetLength(arrItens,0);
  inherited;
end;

procedure TReducaoZ.pAdicionarCofins(strLinha: String);
  Var
    strCodIte: String;
    item: TItemCupom;
    intContador: Integer;
begin
  strCodIte := fGetValorLinhaSped(strLinha, 9);
  For intContador := Low(arrItens) To High(arrItens) Do
  Begin
    item := arrItens[intContador];
    If (item.strCodIte = strCodIte) Then
    Begin
      item.pIncluiDadosCofins(strLinha);
    End;
  End;
end;

procedure TReducaoZ.pAdicionarPis(strLinha: String);
  Var
    intTamMat: Integer;
begin
  intTamMat := Length(arrItens);
  SetLength(arrItens, intTamMat+1);
  arrItens[intTamMat] := TItemCupom.Create(strLinha);
end;

{ TItemCupom }

constructor TItemCupom.Create(strLinha: String);
begin
  fltValorTotal := fCampoValorSped(strLinha, 3);

  strCstPis := fGetValorLinhaSped(strLinha, 2);
  fltBasePis := fCampoValorSped(strLinha, 4);
  fltAlqPis := fCampoValorSped(strLinha, 5);
  fltValorPis := fCampoValorSped(strLinha, 8);

  strCodIte := fGetValorLinhaSped(strLinha, 9);
end;

procedure TItemCupom.pIncluiDadosCofins(strLinha: String);
begin
  strCstCof := fGetValorLinhaSped(strLinha, 2);
  fltBaseCof := fCampoValorSped(strLinha, 4);
  fltAlqCof := fCampoValorSped(strLinha, 5);
  fltValorCof := fCampoValorSped(strLinha, 8);
end;

function TfrmImportaSpedPisCofins.fRetornaCodigoConsumidor: String;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('SELECT CLI_CODCLI FROM CADCLI WHERE CLI_NOMCLI LIKE "%CONSUMIDOR%" LIMIT 1');
  qryAux.Open;

  Result := qryAux.FieldByName('CLI_CODCLI').AsString;

  FreeAndNil(qryAux);
end;

end.
