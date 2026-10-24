unit untTGerenciaItegerPermiteEdicao;

interface

  uses untZClient, Uni, untFuncoesSimples, System.SysUtils, UniClientDataSet, Forms, cxProgressBar;

  Type
  TGerIntePerEdiTipoMarcacao = (giptmMarcaTodos, giptmDesmarcaTodos, giptmInverte);


  TGerenciaItegerPermiteEdicao = class
  private
    qryConsulta: TUniQuery;
    FEmpresaSelecionada: String;
    FNomeEmpresa: String;
    procedure pIncui(strField: String; strDescricao: String; blnVisible: Boolean; var  intOrdem: integer);
    function fGetSQL: String;
    procedure pInicia;
    function fPersisteDados(pgbProgresso: TcxProgressBar): Boolean;

  public
    cdsDados: TZClient;
    constructor Create;
    procedure pGerenciaMarcacao(GerIntePerEdiTipoMarcacao: TGerIntePerEdiTipoMarcacao);
    function fSelecionaEmpresa(ASelf: TForm): Boolean;
    procedure pSetaEmpresa(AEmpresa: String; ANomeEmpresa: String = '');
    function fCampoPermiteEdicao(AFieldName: String): Boolean;
    class procedure pAbreEdicao;
    destructor Destroy; override;
    procedure pPersisteDados;
    property EmpresaSelecionada: String read FEmpresaSelecionada;
    property NomeEmpresa: String read FNomeEmpresa;
  End;


implementation

uses untCampoItegerPermiteEdicao, untConsultas, untTypesSistema, untGravando;



{ TGerenciaItegerPermiteEdicao }

constructor TGerenciaItegerPermiteEdicao.Create;
begin
  qryConsulta :=  fCriaQuery;
  FEmpresaSelecionada := '';
end;

destructor TGerenciaItegerPermiteEdicao.Destroy;
begin
  FreeAndNil(qryConsulta);
  If Assigned(cdsDados) Then
    FreeAndNil(cdsDados);
  inherited;
end;

function TGerenciaItegerPermiteEdicao.fCampoPermiteEdicao(
  AFieldName: String): Boolean;
begin
  If cdsDados.Filtered Then
   cdsDados.Filtered := False;

  cdsDados.First;
  Result := True;
  If cdsDados.Locate('PRE_CAMPO_', AFieldName, []) Then
    Result := cdsDados.FieldByName('PRE_ALTERA').AsInteger = 1;
end;

function TGerenciaItegerPermiteEdicao.fGetSQL: String;
begin
  Result := '';
  Result := Result + 'SELECT AUTOINCREM,PRE_CODEMP,PRE_CAMPO_,PRE_DESCRI,PRE_ALTERA, 0 AS ORDEM, 1 AS VISIBLE  FROM REPPRE WHERE PRE_CODEMP = "' +FEmpresaSelecionada+ '" '
end;

class procedure TGerenciaItegerPermiteEdicao.pAbreEdicao;
var GerenciaItegerPermiteEdicao : TGerenciaItegerPermiteEdicao;
begin
   GerenciaItegerPermiteEdicao := TGerenciaItegerPermiteEdicao.Create;

   pCriarFormularios(TfrmCampoItegerPermiteEdicao, frmCampoItegerPermiteEdicao);
   Try
     frmCampoItegerPermiteEdicao.GerenciaItegerPermiteEdicao := GerenciaItegerPermiteEdicao;
     frmCampoItegerPermiteEdicao.dtsDados.DataSet := GerenciaItegerPermiteEdicao.cdsDados;
     frmCampoItegerPermiteEdicao.ShowModal;
   Finally
     FreeAndNil(frmCampoItegerPermiteEdicao);
     FreeAndNil(GerenciaItegerPermiteEdicao);
   End;
end;

procedure TGerenciaItegerPermiteEdicao.pGerenciaMarcacao(
  GerIntePerEdiTipoMarcacao: TGerIntePerEdiTipoMarcacao);
begin
  If Not Assigned(cdsDados) Then
    Exit;
  cdsDados.First;
  while not cdsDados.Eof do
  Begin
    cdsDados.Edit;
    case GerIntePerEdiTipoMarcacao of
      giptmMarcaTodos: cdsDados.FieldByName('PRE_ALTERA').AsInteger:= 1;
      giptmDesmarcaTodos:  cdsDados.FieldByName('PRE_ALTERA').AsInteger:= 0;
      giptmInverte:  cdsDados.FieldByName('PRE_ALTERA').AsInteger := IIf(cdsDados.FieldByName('PRE_ALTERA').AsInteger= 1, 0 ,1);
    End;
    cdsDados.Post;
    cdsDados.Next;
  End;

end;

procedure TGerenciaItegerPermiteEdicao.pIncui(strField: String; strDescricao: String; blnVisible: Boolean; var intOrdem: integer);
Begin
  cdsDados.First;
  If cdsDados.Locate('PRE_CAMPO_', strField, []) Then
    cdsDados.Edit
  Else
  Begin
    cdsDados.Insert;
    cdsDados.FieldByName('AUTOINCREM').AsString := '';
    cdsDados.FieldByName('PRE_CODEMP').AsString := FEmpresaSelecionada;
    cdsDados.FieldByName('PRE_CAMPO_').AsString := strField;
    cdsDados.FieldByName('PRE_DESCRI').AsString := strDescricao;
    cdsDados.FieldByName('PRE_ALTERA').AsString :=  IIf(blnVisible, 1, 0);

  End;
  cdsDados.FieldByName('PRE_DESCRI').AsString := strDescricao;
  cdsDados.FieldByName('ORDEM').AsInteger :=  intOrdem;
  cdsDados.FieldByName('VISIBLE').AsInteger :=  IIf(blnVisible, 1, 0);


  cdsDados.Post;
  inc(intOrdem);
End;


procedure TGerenciaItegerPermiteEdicao.pInicia;
var intOrdem: integer;
    blnSufram: Boolean;

    strTabPrcAtivas: String;
    i: integer;
    blnTabAtiva: Boolean;
    blmPcmProDif2: Boolean;
    strMarMkp: String;
    intTabela: String;
begin
  If Assigned(cdsDados) Then
    FreeAndNil(cdsDados);

  cdsDados :=  TZClient.Create(Nil, fGetSQL);
  cdsDados.fAbreClient(False, '[TGerenciaItegerPermiteEdicao.Create]');

  blnSufram := (fCfgSis('SUFRAM', varBoolean, FEmpresaSelecionada)) and (fCfgSis('FRMCUS', varString, FEmpresaSelecionada) = '4');
  intOrdem := 0;
  blmPcmProDif2 :=  fCfgSis('PCMPRO', varString, FEmpresaSelecionada) <> '2';
  strMarMkp := fCfgSis('MARMKP', varString, FEmpresaSelecionada);

  pIncui('ITE_PRECOM', 'Preço Compra', True, intOrdem);
  pIncui('ITE_DESF01', 'Desconto 01 (-)', True, intOrdem);
  pIncui('ITE_DESF02', 'Desconto 02 (-)', True, intOrdem);
  pIncui('ITE_DESF03', 'Desconto 03 (-)', True, intOrdem);
  pIncui('ITE_DESF04', 'Desconto 04 (-)', True, intOrdem);
  pIncui('ITE_DESF05', 'Desconto 05 (-)', True, intOrdem);
  pIncui('ITE_DESF06', 'Desconto 06 (-)', True, intOrdem);
  pIncui('ITE_ICMENT', 'ICMS Entrada (-)', True, intOrdem);
  pIncui('ITE_SUBFED', 'Impostos Federais (-)', True, intOrdem);
  pIncui('ITE_IPIENT', 'IPI Entrada (+)', True, intOrdem);
  pIncui('ITE_FREENT', 'Frete (+)', True, intOrdem);
  pIncui('ITE_VALFRE', 'Valor Frete (+)', True, intOrdem);
  pIncui('ITE_ACRFIN', 'Acréscimo Finan. (+)', True, intOrdem);
  pIncui('ITE_SUBSTI', 'Sub. Tributária (+)', True, intOrdem);
  pIncui('ITE_DESADB', fCfgSis('DESADI', varString, FEmpresaSelecionada) + ' (' + fCfgSis('OPEADI', varString, FEmpresaSelecionada) + ')', True, intOrdem);
  pIncui('ITE_TCIFCU', 'TCIF (+)', blnSufram, intOrdem);
  pIncui('ITE_TSCUST', 'TS (+)', blnSufram, intOrdem);
  pIncui('ITE_DEPICO', 'Desconto PIS/COFINS (-)', blnSufram, intOrdem);
  pIncui('ITE_DEICMS', 'Desconto ICMS (-)', blnSufram, intOrdem);
  pIncui('ITE_FATREG', 'Fator Regional (+)', blnSufram, intOrdem);
  pIncui('ITE_OUTVAL', fCfgSis('DOVCPP', varString, FEmpresaSelecionada) + ' (+):', True, intOrdem);
  pIncui('ITE_ICMSAI', 'ICMS Saída (+)', True, intOrdem);
  pIncui('ITE_IMPFED', 'Impostos Federais (+)', True, intOrdem);
  pIncui('ITE_DESOPE', 'Desp. Operacionais (+)', True, intOrdem);

  strTabPrcAtivas := VS_strTabPrc;
  while Length(strTabPrcAtivas) < 7 Do
    strTabPrcAtivas := strTabPrcAtivas + 'N';

  For i := 1 To Length(strTabPrcAtivas) do
  Begin
    intTabela := i.ToString;
    blnTabAtiva:= strTabPrcAtivas[i] = 'S';
    If Pos(strMarMkp, '1_5_') = 0 Then
      pIncui('ITE_MARBR' + intTabela, 'Markup ' + intTabela, blnTabAtiva, intOrdem)
    Else
      pIncui('ITE_MARBR' + intTabela, 'Margem Bruta ' + intTabela, blnTabAtiva, intOrdem);

    If blmPcmProDif2 Then
      pIncui('ITE_COMTB' + intTabela, fCfgSis('TCOMTB', varString, FEmpresaSelecionada ) + ' ' +  intTabela, blnTabAtiva, intOrdem)
    Else
      pIncui('ITE_COMTB' + intTabela, 'Comissão ' + intTabela, blnTabAtiva, intOrdem);
    pIncui('ITE_PREVE' + intTabela, 'Preço de Venda ' + intTabela, blnTabAtiva, intOrdem);
  End;

  cdsDados.Filtered := False;
  cdsDados.Filter := 'VISIBLE = 1';
  cdsDados.Filtered := True;
end;

function TGerenciaItegerPermiteEdicao.fPersisteDados(pgbProgresso: TcxProgressBar): Boolean;
begin
  pgbProgresso.Properties.Max := cdsDados.RecordCount;
  while not cdsDados.Eof do
  Begin
    If cdsDados.FieldByName('AUTOINCREM').AsString <> '' Then
    Begin
      qryConsulta.SQL.Clear;
      qryConsulta.SQL.Add('UPDATE REPPRE SET PRE_ALTERA = "'+cdsDados.FieldByName('PRE_ALTERA').AsString+'",');
      qryConsulta.SQL.Add('                  PRE_DESCRI = "'+cdsDados.FieldByName('PRE_DESCRI').AsString+'"');
      qryConsulta.SQL.Add('        WHERE AUTOINCREM = "'+cdsDados.FieldByName('AUTOINCREM').AsString+'"');
    End
    Else
    Begin
      qryConsulta.SQL.Clear;
      qryConsulta.SQL.Add('INSERT INTO REPPRE(AUTOINCREM,PRE_CODEMP,PRE_CAMPO_,PRE_DESCRI,PRE_ALTERA)VALUES(');
      qryConsulta.SQL.Add('"' + fRetAutoIncrem('REPPRE', VS_StrCodEmp) + '",');
      qryConsulta.SQL.Add('"' + cdsDados.FieldByName('PRE_CODEMP').AsString + '",');
      qryConsulta.SQL.Add('"' + cdsDados.FieldByName('PRE_CAMPO_').AsString + '",');
      qryConsulta.SQL.Add('"' + cdsDados.FieldByName('PRE_DESCRI').AsString + '",');
      qryConsulta.SQL.Add('"' + cdsDados.FieldByName('PRE_ALTERA').AsString + '");');
    End;
    qryConsulta.ExecSQL;
    pgbProgresso.Position := cdsDados.RecNo;

    Application.ProcessMessages;

    cdsDados.Next;
  End;

  qryConsulta.SQL.Clear;
  qryConsulta.SQL.Add('DELETE FROM CADINT WHERE INT_NOMFRM LIKE "frmAltPrecoIndividual"');
  qryConsulta.ExecSQL;

  Result := True;
End;


procedure TGerenciaItegerPermiteEdicao.pPersisteDados;
var frmGravando: TfrmGravando;
begin
  cdsDados.DisableControls;
  cdsDados.First;
  cdsDados.Filtered := False;
  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    frmGravando.fExecutarAcao := fPersisteDados;
    frmGravando.lblGravando.Caption := 'Aguarde... Gravando';
    frmGravando.ShowModal;
  Finally
    FreeAndNil(frmGravando);
    cdsDados.Filtered := True;
    cdsDados.EnableControls;
  End;
end;

procedure TGerenciaItegerPermiteEdicao.pSetaEmpresa(AEmpresa: String; ANomeEmpresa: String = '');
begin
  FEmpresaSelecionada := AEmpresa;
  FNomeEmpresa := ANomeEmpresa;
  pInicia;
end;

function TGerenciaItegerPermiteEdicao.fSelecionaEmpresa(ASelf: TForm): Boolean;
var arrSel: TConsultasArray;
    KeyChar: Char;
begin
  KeyChar := '/';
  qryConsulta.SQL.Clear;
  Result := False;
  If fPesqEmpresa(conEmpSimples, ASelf, nil, nil, qryConsulta, KeyChar, arrSel) Then
  Begin

    { Removido conforme solicitado - Req: 282182
    If qryConsulta.FieldByName('EMP_PREMAT').AsString = 'N' Then
      Result := True
    Else If Not fPreMat(qryConsulta.FieldByName('EMP_CODEMP').AsString, qryConsulta.FieldByName('EMP_CODEMP').AsString) Then
      Result := True
    Else
    Begin
      pMensagemOk('A Empresa selecionada não gerência preços!, não pode ser definido os campos');
      Exit(False);
    End;
      If Result Then
    }
    Result := True;
    pSetaEmpresa(qryConsulta.FieldByName('EMP_CODEMP').AsString,qryConsulta.FieldByName('EMP_NOMEMP').AsString );
  End;
end;

end.

