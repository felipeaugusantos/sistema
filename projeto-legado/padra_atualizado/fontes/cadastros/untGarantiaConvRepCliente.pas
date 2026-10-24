unit untGarantiaConvRepCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, Data.DB, Datasnap.DBClient, UniClientDataSet, Vcl.Grids, Vcl.DBGrids, DBGridCitel, Uni, System.Generics.Collections,
  untCadLote, Vcl.ComCtrls, cxProgressBar, untAuditoriaGravacaoSaldo, untConstantes;

Type
  TProcQry = reference to procedure(Var UniClientDataSet: TUniClientDataSet);
Type
{$SCOPEDENUMS ON}
  TOpcaoConversao =  (Credito = 1, Reposicao, CancelarOperacao);
{$SCOPEDENUMS OFF}


Type
  TItemConv = class
  public
    strAutIncGad: String;
    strAutIncGer: String;
    strIncOri: String;
    strCodIte: String;
    strNumEnt: String;
    strNumDoc: String;
    strEspDoc: String;
    fltValor: Double;
    strCodMar: String;
    strNumLot: String;
    strEstado: String;
    strDesIte: String;
    strRefere: String;
    strUnidad: String;
    strForIte: String;
    fltQtdIte: Double;
    fltUnitar: Double;
    fltUniOri: Double;
    fltUniVis: Double;
    fltTotIte: Double;
    fltVlrCon: Double;
    strGadNumDoc: String;
    strGadEspDoc: String;
    strGadCodEmp: String;
    dtaGerDtaEnt: TDateTime;
    function fDescricaoHistorico: String;
  end;

Type
  TListaItensConv = TObjectList<TItemConv>;

Type TCliente = class
  Public
    strCodCli: String;
    strNomCon: String;
    strEndCon: String;
    strBaiCon: String;
    strCepCon: String;
    strCidCon: string;
    strEstCon: String;
    strTelCon: String;
    dtaNasCon: TDate;
    strCgcCpf: String;
    strCgcCon: String;
    strIesCon: String;
    strCli_Rg: string;
    procedure Limpar;
end;


type
  TfrmGarantiaConvRepCliente = class(TfrmPai)
    pnlTopo: TPanel;
    pnlDados: TPanel;
    edtCodCli: TEditFocus;
    lblCliente: TLabel;
    edtNomCli: TEditFocus;
    cdsDados: TUniClientDataSet;
    dbgDados: TDBGridCitel;
    dtsDados: TDataSource;
    btnConfirmar: TBitBtnLocked;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmarcarTodos: TBitBtnLocked;
    cdsDadosSELECIONADO: TStringField;
    cdsDadosAUTOINCREM: TStringField;
    cdsDadosGAD_CODITE: TStringField;
    cdsDadosGAD_CODFAB: TStringField;
    cdsDadosGAD_QTDREQ: TFloatField;
    cdsDadosGAD_REPOST: TStringField;
    cdsDadosGAD_SCREDI: TIntegerField;
    cdsDadosGAG_NUMENT: TStringField;
    cdsDadosGAG_DTAENT: TDateTimeField;
    cdsDadosITE_CODUNI: TStringField;
    cdsDadosITE_DESITE: TStringField;
    cdsDadosITE_REFERE: TStringField;
    cdsDadosDET_NUMDOC: TStringField;
    cdsDadosDET_ESPDOC: TStringField;
    cdsDadosDET_TOTCRE: TFloatField;
    cdsDadosDET_SEQGER: TStringField;
    cdsDadosDET_AUTINC: TStringField;
    cdsDadosNUMLOTE: TStringField;
    cdsDadosUSALOTE: TStringField;
    cdsDadosGAE_SALDO_: TFloatField;
    pnlBotoesEnt: TPanel;
    btnSair_: TBitBtnLocked;
    btnCarregar: TBitBtnLocked;
    cdsDadosNUMENT: TStringField;
    cdsDadosDET_DTAENT: TDateTimeField;
    cdsDadosGAD_NUMDOC: TStringField;
    cdsDadosGAD_ESPDOC: TStringField;
    cdsDadosGAD_CODEMP: TStringField;
    cdsDadosGER_DTAENT: TDateTimeField;
    cdsDadosUNI_DESUNI: TStringField;
    procedure btnCarregarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnDesmarcarTodosClick(Sender: TObject);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure dbgDadosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgDadosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmarClick(Sender: TObject);
    procedure cdsDadosAfterPost(DataSet: TDataSet);
    procedure cdsDadosBeforeDelete(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cdsDadosBeforePost(DataSet: TDataSet);
    procedure btnSairClick(Sender: TObject);
    procedure cdsDadosNUMLOTEValidate(Sender: TField);
    procedure FormShow(Sender: TObject);
    procedure btnSair_Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure edtCodCliExit(Sender: TObject);
    procedure dbgDadosKeyPress(Sender: TObject; var Key: Char);
  private
    strCodCli: String;
    strPortad: String;
    intDecUni: integer;
    pgbProgresso: TcxProgressBar;
    objCadLot : TCadLot;
    intQtdCasasDecimaisValorUnitario: Integer;
    objAuditoriaSaldo: IAuditoriaGravacaoSaldo;

    { Private declarations }
    function fValidarCliente(Const strCodCli: String; Out strNomCli: String): Boolean;
    function fScriptCarregarGarantias: String;
    function fCarregarGarantias(Const strCodCli, strCodEmp: String): Integer;
    function fDefinirCliente(const strCodCliNovo: String):Boolean;
    function fMensagemOpcaoCreditoReposicao: TOpcaoConversao;
    function fMensagemContinuarOperacao: Boolean;
    function fGravarCredito(ItensCredito: TListaItensConv): Boolean;
    function fAtualizarGarantia(Const strAutIncGad: String; Const Opcao: TOpcaoConversao; fltQtdDev: Double = 0): Boolean;
    function fScriptAtualizarGarantia: String;
    function fObterItem: TItemConv;
    function fInserirMovDet(Const strAutIncMovGer, strNumDoc,  strEspDoc: String; Item: TItemConv): Boolean;
    function fInserirMovGer(var strAutInc: String; strNumMovGer, strEspDoc, strCodCli: String; const strObs: String): Boolean;
    procedure pCriaTabelaDados;

    procedure pMarcarDesmarcar(blnMarcar: Boolean; blnTodos: Boolean = False);
    function fConverterParaCredito: Boolean;
    function fGravando(pgbProgresso: TcxProgressBar): Boolean;
    function fConverter(Opcao: TOpcaoConversao): Boolean;
    procedure pAvaliarUsoLote(Const strCodIte: String);
    function fGeraSaidaEstoque: boolean;
    function fCriaDocumentoSaida(Const Lista: TListaItensConv): Boolean;
    function fEfetivarSaidaEstoque(Const Lista: TListaItensConv): Boolean;
    function fValidarNumeroLote(Const strNumLot: String): Boolean;
    function fRetSequencialReposicao: String;
    function fAtuSequencial(strValor: String): Boolean;
    function fFaltaInformarLote:Boolean;
    function fObterLote(Const strCodIte: String): String;
    function fTemItemSelecionado: Boolean;
    function fObterHistoricoCredito(Const Lista: TListaItensConv): TStringList;
    procedure AtribuirLote;
    procedure pConfigurar;

  private const
    OP_SIM = 1;
    OP_NAO = 2;

    VB_SIM: String = '1';
    VB_NAO: String = '0';

    MARCADO: String = '1';
    DESMARCADO: String = '0';
    GARANTIA_REPOSICAO_CLIENTE: String = 'GC';


  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmGarantiaConvRepCliente: TfrmGarantiaConvRepCliente;

implementation

uses
  untFuncoesSimples, System.StrUtils, untTypesSistema, untConsultas, untMovGer, untGarant, untCadRec, untCadIte, untFuncoes, untGravando,
  System.Math;

{$R *.dfm}

{ TfrmGarantiaConvRepCliente }

procedure TfrmGarantiaConvRepCliente.btnConfirmarClick(Sender: TObject);

begin
  inherited;

  if cdsDados.isEmpty then
  begin
    fMensagem('Atenção!','Não há garantias para conversão.',['&Ok']);
    Exit;
  end;

  if Not fTemItemSelecionado then
  begin
    fMensagem('Atenção!','Selecione um item de garantia antes de continuar.',['&Ok']);
    Exit;
  end;

  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao  := fGravando;
    frmGravando.ShowModal;
  Finally
    if Assigned(frmGravando) then
    begin
      pFreeAndNil(frmGravando);
    end;
  End;

end;

procedure TfrmGarantiaConvRepCliente.btnDesmarcarTodosClick(Sender: TObject);
begin
  inherited;
  pMarcarDesmarcar(false, True);
end;

procedure TfrmGarantiaConvRepCliente.btnMarcarTodosClick(Sender: TObject);
begin
  pMarcarDesmarcar(True, True);
end;

procedure TfrmGarantiaConvRepCliente.btnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmGarantiaConvRepCliente.btnSair_Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmGarantiaConvRepCliente.cdsDadosAfterPost(DataSet: TDataSet);
begin
  inherited;
  btnConfirmar.enabled := Not DataSet.IsEmpty;
end;

procedure TfrmGarantiaConvRepCliente.cdsDadosBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  btnConfirmar.enabled := Not DataSet.IsEmpty;
end;

procedure TfrmGarantiaConvRepCliente.cdsDadosBeforePost(DataSet: TDataSet);
begin
  inherited;
  if cdsDados.State in [dsInsert]then
  begin
    pAvaliarUsoLote(cdsDados.FieldByName('GAD_CODITE').AsString);
  end;
end;

procedure TfrmGarantiaConvRepCliente.cdsDadosNUMLOTEValidate(Sender: TField);
begin
  Try
    cdsDadosNUMLOTE.OnValidate := Nil;
    if Sender.AsString = '/' then
    begin
      AtribuirLote;
    end;
  Finally
    cdsDadosNUMLOTE.OnValidate := cdsDadosNUMLOTEValidate;
  End;
end;

function TfrmGarantiaConvRepCliente.fConverter(Opcao: TOpcaoConversao): Boolean;
Var
  Transacao: Boolean;
  Falha: Boolean;
  strCodErrosAuditoria: String;
begin
  Falha := False;
  Transacao := False;
//  pProgresso(intProgresso: Integer; intMaximo: Integer; pgbStatus: TcxProgressBar)
  pProgresso(0, 2, pgbProgresso);

  Try
    btnConfirmar.Enabled := False;
    Try
      cdsDados.DisableControls;
      cdsDados.Filtered := False;
      cdsDados.Filter := 'SELECIONADO = ''1''';
      cdsDados.Filtered := True;

      if Not cdsDados.IsEmpty then
      begin
        objAuditoriaSaldo.Limpar;

        Transacao := fStartTransaction;

        case Opcao of
          TOpcaoConversao.Credito:
          begin
            Falha := Not fConverterParaCredito;
          end;

          TOpcaoConversao.Reposicao:
          begin
            if fFaltaInformarLote then
            begin
              fMensagem('Atenção!','Falta informar lote! Revise o documento.',['&Ok']);
              Falha := True;
            end;

            if Not Falha then
            begin
              Falha := Not fGeraSaidaEstoque;
            end;
          end;
          TOpcaoConversao.CancelarOperacao: Falha := True ;
        end;
      end;

      pProgresso(1, 2, pgbProgresso);

      If (Not Falha) And (Transacao) And (Not objAuditoriaSaldo.fValidouTodas(strCodErrosAuditoria)) Then
      Begin
        Falha := True;
        fRollBack;
        pMostraErrosAuditoria(strCodErrosAuditoria);
      End;

      if Not Falha then
      begin
        if Transacao then
        begin
          fCommit;
        end;
      end;
    Except
     On E : Exception do
     Begin
       Falha := True;
       pMensagensErro(E.Message, 'TfrmGarantiaConvRepCliente.btnConfirmarClick');
     End;
    End;
  Finally

    cdsDados.Filtered := False;
    cdsDados.Filter := EmptyStr;
    cdsDados.EnableControls;

    btnConfirmar.Enabled := Not btnConfirmar.Enabled;

    if Falha then
    begin
      if Transacao then
        fRollBack;

      fMensagem('Atenção!',
                'Falha ao tentar converter a garantia. '+SlineBreak+
                'O processo não foi concluído. ',['&Ok']);
    end
    else
    begin
      fMensagem('Informação!',
                'O processo concluído com sucesso.',['&Ok']);

      fDefinirCliente('');
    end;
  End;
  pProgresso(2, 2, pgbProgresso);
  Result := Not Falha;
end;

function TfrmGarantiaConvRepCliente.fConverterParaCredito: Boolean;
Var
  strGarantia: String;
  blnQuebra: Boolean;
  Lista: TListaItensConv;
begin
  Lista := TListaItensConv.Create();
  lista.Clear;
  cdsDados.First;
  Result := True;
  Try
    while Not cdsDados.Eof do
    begin
      strGarantia := cdsDadosGAG_NUMENT.AsString;
      Repeat
        Lista.Add(fObterItem);

        cdsDados.Next;
        blnQuebra := (strGarantia <> cdsDadosGAG_NUMENT.AsString);

        if Not blnQuebra then
        begin
          blnQuebra := cdsDados.Eof;
        end;

        if (blnQuebra) then
        begin
          Result := fGravarCredito(Lista);
          if Not Result then
            Break;
        end;

      Until (blnQuebra);

      lista.Clear;

      if Not Result  then
        Break;
    end;
  Finally
    if Assigned(Lista) then
      FreeAndNil(Lista);
  End;

end;

function TfrmGarantiaConvRepCliente.fCriaDocumentoSaida(const Lista: TListaItensConv): Boolean;
Var
  strNumero: string;
  strAutIncGer: String;
  strObs: String;
  Item: TItemConv;
begin
  strNumero := fRetSequencialReposicao;
  strObs:= 'Conversão garantia em reposição.';

  Result :=  fInserirMovGer(strAutIncGer,strNumero,GARANTIA_REPOSICAO_CLIENTE, strCodCli, strObs );

  for Item in Lista do
  Begin
    Result := fInserirMovDet(strAutIncGer, strNumero,GARANTIA_REPOSICAO_CLIENTE,Item);
    if Not Result then
      Break;
  End;
end;

procedure TfrmGarantiaConvRepCliente.dbgDadosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  if cdsDadosSELECIONADO.AsString = MARCADO then
  begin
    dbgDados.Canvas.Font.Color := clBlue;
    dbgDados.DefaultDrawDataCell(Rect,dbgDados.Columns[DataCol].Field, State);
  end;
end;

procedure TfrmGarantiaConvRepCliente.dbgDadosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
Var
  blnMarcar: Boolean;

begin
  inherited;

  case Key of
    VK_RETURN :
    begin
      if Not cdsDados.IsEmpty then
      begin
        blnMarcar := (cdsDadosSELECIONADO.AsString = DESMARCADO);
        pMarcarDesmarcar(blnMarcar);
      end;
    end;
    VK_SPACE:
    begin
      if Not cdsDados.IsEmpty then
      begin
        blnMarcar := (cdsDadosSELECIONADO.AsString = DESMARCADO);
        pMarcarDesmarcar(blnMarcar);
      end;
    end;

  end;
end;

procedure TfrmGarantiaConvRepCliente.dbgDadosKeyPress(Sender: TObject; var Key: Char);
 Var
    blnNumLote: Boolean;
begin
  inherited;

  blnNumLote := dbgDados.SelectedField.FieldName = 'NUMLOTE';

  if blnNumLote then
  begin
    if  fEntraCons(Key) Then
      AtribuirLote;
  end;

end;

procedure TfrmGarantiaConvRepCliente.edtCodCliExit(Sender: TObject);
begin
  inherited;
  fDefinirCliente(edtCodCli.Text);
end;

procedure TfrmGarantiaConvRepCliente.edtCodCliKeyPress(Sender: TObject; var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    strCodCli := edtCodCli.Text;
    If fValidaCampos(edtCodCli, True) Then
    begin
      SelectNext((ActiveControl), True, True);
    end;
  End;
end;

function TfrmGarantiaConvRepCliente.fAtualizarGarantia(const strAutIncGad: String; const Opcao: TOpcaoConversao; fltQtdDev: Double): Boolean;
Const
 SIM: String = 'S';
 NAO: String = 'N';
 REPOSTO = 0;
 AGUARDANDO_GERAR_CREDITO = 1;
 CREDITO_GERADO = 2;
Var
  SituacaoCredito: Integer;
  Reposicao: String;
  Data, Hora : TDateTime;
  Operador: Variant;
  Qry: TUniQuery;

begin
  Qry := nil;
  SituacaoCredito := 0;
  Data := 0;
  Hora := 0;

  case Opcao of
    TOpcaoConversao.Credito:
    begin
      Reposicao := NAO;
      SituacaoCredito := CREDITO_GERADO;
      Data := VS_Date;
      Hora := fNow;
      Operador := strLoginUsuarioLogado;
    end ;
    TOpcaoConversao.Reposicao:
    begin
      Reposicao := SIM;
      SituacaoCredito := REPOSTO;
      Data := 0;
      Hora := 0;
      Operador := null;
    end ;
  end;

  Try
    Result := True;
    Try
      Qry := fCriaQuery();
      Qry.Close;
      Qry.Sql.Clear;
      Qry.Sql.Add(fScriptAtualizarGarantia);
      Qry.ParamByName('AUTOINCREM').AsString := strAutIncGad;
      Qry.ParamByName('REPOST').AsString     := Reposicao;
      Qry.ParamByName('SCREDI').AsInteger    := SituacaoCredito;
      Qry.ParamByName('DTACRE').AsDateTime   := Data;
      Qry.ParamByName('HRACRE').AsDateTime   := Hora;
      Qry.ParamByName('OPECRE').Value        := Operador;
      Qry.ParamByname('QTDDEV').AsFloat      := fltQtdDev;
      Qry.Execute;
    Except
      On E: Exception do
      begin
        Result := False;
      end
    End;
  Finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  End;
end;

function TfrmGarantiaConvRepCliente.fAtuSequencial(strValor: String): Boolean;
  Var
    strSQL   : String;
    qryGenCfg: TUniQuery;
begin
  Try

    Result := True;

    qryGenCfg := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  CFGSIS ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '   SIS_VALCFG = :VALOR ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   SIS_CODCFG = ' + QuotedStr('CFG_PROGEC') + ' AND ';
    strSQL := strSQL + '   SIS_CODEMP = ' + QuotedStr(VS_strCodEmp);

    Try
      qryGenCfg.Close;
      qryGenCfg.SQL.Clear;
      qryGenCfg.SQL.Add(strSQL);
      qryGenCfg.ParamByName('VALOR').AsString  := strValor;
      qryGenCfg.ExecSQL;
      qryGenCfg.Close;
    Except
      On E: Exception Do
      Begin
        Result := False;
      End;
    End;

  Finally
    FreeAndNil(qryGenCfg);
  End;

end;

procedure TfrmGarantiaConvRepCliente.AtribuirLote;
Var
  strNumLot: String;
begin
  strNumLot := fObterLote(cdsDadosGAD_CODITE.AsString);
  if Not fValidarNumeroLote(strNumLot) then
  begin
    strNumLot := EmptyStr;
  end;
  cdsdados.Edit;
  cdsDadosNUMLOTE.AsString := strNumLot;
  cdsDados.Post;
end;

procedure TfrmGarantiaConvRepCliente.btnCarregarClick(Sender: TObject);
Var
  aWinControl: TWinControl;
begin
  inherited;
  aWinControl := edtCodCli;
  if fValidaCampos(aWinControl) then
  begin
    fCarregarGarantias(edtCodCli.Text, VS_strCodEmp);
  end;
end;

function TfrmGarantiaConvRepCliente.fCarregarGarantias(const strCodCli, strCodEmp: String): Integer;
Var
  Qry: TUniQuery;

begin
  if cdsDados.Active then
    cdsDados.EmptyDataSet;
  Try
    Result := 0;
    Qry := fCriaQuery();
    Qry.Close;
    Qry.Sql.Clear;
    Qry.Sql.Add(fScriptCarregarGarantias);
    Qry.ParamByName('CODCLI').AsString := strCodCli;
    Qry.ParamByName('CODEMP').AsString := strCodEmp;
    Qry.Open;
    if Qry.Active then
    begin
      if Not Qry.IsEmpty then
      begin
        Qry.First;
        while Not Qry.Eof do
        begin
          cdsDados.Append;
          cdsDadosSELECIONADO.AsString   := '0';
          cdsDadosAUTOINCREM.AsString    := Qry.FieldByName('AUTOINCREM').AsString;
          cdsDadosGAD_CODITE.AsString    := Qry.FieldByName('GAD_CODITE').AsString;
          cdsDadosGAD_CODFAB.AsString    := Qry.FieldByName('GAD_CODFAB').AsString;
          cdsDadosGAD_QTDREQ.AsFloat     := Qry.FieldByName('GAD_QTDREQ').AsFloat;
          cdsDadosGAD_REPOST.AsString    := Qry.FieldByName('GAD_REPOST').AsString;
          cdsDadosGAD_SCREDI.AsString    := Qry.FieldByName('GAD_SCREDI').AsString;
          cdsDadosGAG_NUMENT.AsString    := Qry.FieldByName('GAG_NUMENT').AsString;
          cdsDadosGAG_DTAENT.AsDateTime  := Qry.FieldByName('GAG_DTAENT').AsDateTime;
          cdsDadosITE_DESITE.AsString    := Qry.FieldByName('ITE_DESITE').AsString;
          cdsDadosITE_REFERE.AsString    := Qry.FieldByName('ITE_REFERE').AsString;
          cdsDadosITE_CODUNI.AsString    := Qry.FieldByName('ITE_CODUNI').AsString;
          cdsDadosDET_NUMDOC.AsString    := Qry.FieldByName('DET_NUMDOC').AsString;
          cdsDadosDET_ESPDOC.AsString    := Qry.FieldByName('DET_ESPDOC').AsString;
          cdsDadosDET_TOTCRE.AsString    := Qry.FieldByName('DET_TOTCRE').AsString;
          cdsDadosDET_SEQGER.AsString    := Qry.FieldByName('DET_SEQGER').AsString;
          cdsDadosDET_AUTINC.AsString    := Qry.FieldByName('DET_AUTINC').AsString;
          cdsDadosGAE_SALDO_.AsString    := Qry.FieldByName('GAE_SALDO_').AsString;
          cdsDadosUSALOTE.AsString       := Qry.FieldByName('USALOTE').AsString;
          cdsDadosNumEnt.AsString        := Qry.FieldByName('NUMENT').AsString;
          CDSDADOSDET_DTAENT.AsDateTime  := Qry.FieldByName('DET_DTAENT').AsDateTime;
          cdsDadosNUMLOTE.AsString       := Qry.FieldByName('NUMLOTE').AsString;
          cdsDAdosGad_NumDoc.AsString    := Qry.FieldByName('GAD_NUMDOC').AsString;
          cdsDAdosGad_EspDoc.AsString    := Qry.FieldByName('GAD_ESPDOC').AsString;
          cdsDadosGad_CodEmp.AsString    := Qry.FieldByName('GAD_CODEMP').AsString;
          cdsDadosGER_DTAENT.AsString    := Qry.FieldByName('GER_DTAENT').AsString;
          cdsDadosUNI_DESUNI.AsString    := Qry.FieldByName('UNI_SIGUNI').AsString;
          cdsDados.Post;
          Qry.Next;
        end;
        Result := cdsDados.RecordCount;
      end
      else
      begin
        fMensagem('Atenção!','Não foram encontradas garantias aptas para conversão.',['&Ok']);
      end;
      Qry.Close;
    end;
  Finally
    if Assigned(Qry) then
    begin
      if Qry.Active then
        qry.close;
      FreeAndNil(Qry);
    end;
  End;
end;

function TfrmGarantiaConvRepCliente.fDefinirCliente(const strCodCliNovo: String): Boolean;
Var
  blnTroca: Boolean;
  strNomCli: String;
begin
  blnTroca := strCodCli <> strCodCliNovo;

  if blnTroca then
  begin
    strCodCli := strCodCliNovo;
    edtNomCli.clear;
    cdsDados.EmptyDataSet;
    btnConfirmar.Enabled := False;
  end;

  Result := fValidarCliente(strCodCliNovo, strNomCli);
  if Result then
  begin
    edtNomCli.Text := strNomCli;
  end;
end;

function TfrmGarantiaConvRepCliente.fEfetivarSaidaEstoque(const Lista: TListaItensConv): Boolean;
Var
  Item: TItemConv;
begin
  Result := false;
  for Item In Lista do
  begin
    Result := fAtualizarGarantia(Item.strAutIncGad, TOpcaoConversao.reposicao, Item.fltQtdIte);

    if Not Result then
      Break;
  end;

  if Result then
  begin
    Result := fCriaDocumentoSaida(Lista);
  end;
end;

function TfrmGarantiaConvRepCliente.fFaltaInformarLote: Boolean;
begin
  Result := False;
  while Not cdsdados.eof do
  begin
    if cdsDadosUSALOTE.AsString = VB_SIM then
    begin
      Result := fEmptyStr(cdsDadosNUMLOTE.AsString);
      if Result then
      begin
        Break;
      end;
    end;
    cdsDados.next;
  end;
end;

function TfrmGarantiaConvRepCliente.fMensagemContinuarOperacao: Boolean;
Var
  Msg: String;
begin
  Msg := ' Esta rotina irá transformar as garantias selecionadas em Reposição = SIM. '+sLineBreak;
  Msg := Msg + ' Estas mercadorias já foram enviadas para o fornecedor e manterão o processo de retorno. '+sLineBreak;
  Msg := Msg + ' Neste momento, somente a posição com o Cliente será modificada. '+sLineBreak;
  Msg := Msg + ' Deseja confirmar?';

  Result := fMensagem('Atenção!',         //strTitulo: String;
                    Msg,                //strTexto: String;
                    ['&Sim','&Não'],    //arrOpcoes: Array Of String;,
                    OP_NAO,             //intFocoBotao: Integer      = 1;
                    False,              //blnSaiComEsc: Boolean      = False;
                    1,                  //intEstFon: Integer         = 1;
                    0,                  //intWidBut: Integer         = 0;
                    False,              //blnAutosize: Boolean       = False;
                    0,                  //intSomarTop: Integer       = 0;
                    False,              //blnObrigaEsc: Boolean      = False;
                    False,              //blnOcultPainelBtn: Boolean = False;
                    false,               //blnBtnSemImg : Boolean     = False;
                    0,                  //intHeightOpc: Integer      = 0;
                    0) = OP_SIM;    //intFormWidth: Integer      = 0;

end;

function TfrmGarantiaConvRepCliente.fMensagemOpcaoCreditoReposicao: TOpcaoConversao;
Const
  LARGURA_BTN: Integer = 250;
begin
  if fMensagemContinuarOperacao then
  begin
    Result := TopcaoConversao(fMensagem('',                                                      //strTitulo: String;
                                        'Escolha uma oção:',                                     //strTexto: String;
                                        ['&Gerar crédito para cliente','&Reposição dos itens'],  //arrOpcoes: Array Of String;,
                                        ord(TOpcaoConversao.Reposicao),                          //intFocoBotao: Integer      = 1;
                                        False,                                                   //blnSaiComEsc: Boolean      = False;
                                        1,                                                       //intEstFon: Integer         = 1;
                                        LARGURA_BTN,                                             //intWidBut: Integer         = 0;
                                        False,                                                   //blnAutosize: Boolean       = False;
                                        0,                                                       //intSomarTop: Integer       = 0;
                                        False,                                                   //blnObrigaEsc: Boolean      = False;
                                        False,                                                   //blnOcultPainelBtn: Boolean = False;
                                        True,                                                   //blnBtnSemImg : Boolean     = False;
                                        0,                                                       //intHeightOpc: Integer      = 0;
                                        ((LARGURA_BTN*2)+100)));                                 //intFormWidth: Integer      = 0;



  end
  else
  begin
    Result := TOpcaoConversao.CancelarOperacao;
  end;
end;

procedure TfrmGarantiaConvRepCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  objCadLot.Free;
end;

procedure TfrmGarantiaConvRepCliente.FormCreate(Sender: TObject);
begin
  intQtdCasasDecimaisValorUnitario := fCfgSis('DECUNI',varInteger);
  pgbProgresso := nil;
  inherited;
  objCadLot := TCadLot.Create(Self);
  pConfigurar;

  objAuditoriaSaldo := TAuditoriaGravacaoSaldo.New;
end;

procedure TfrmGarantiaConvRepCliente.FormDestroy(Sender: TObject);
begin

  if Assigned(pgbProgresso) then
    pgbProgresso := nil;

  if cdsDados.Active then
    cdsDados.close;

  inherited;

end;

procedure TfrmGarantiaConvRepCliente.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_F10: btnConfirmar.Click;
    Vk_F5: btnCarregar.click;
    VK_F6: btnMarcarTodos.Click;
    VK_F7: btnDesmarcarTodos.click;
    VK_ESCAPE: btnSair_.Click;
  end;
end;

procedure TfrmGarantiaConvRepCliente.FormShow(Sender: TObject);
begin
  inherited;
  btnSair.Enabled := True;
end;

function TfrmGarantiaConvRepCliente.fRetSequencialReposicao: String;
  Var
    strSQL   : String;
    qryCadGen: TUniQuery;
begin
  Try
    qryCadGen := fCriaQuery(nil);

    Try
      strSQL := '';
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   SIS_VALCFG AS VALOR ';
      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + '   CFGSIS ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   SIS_CODCFG = ' + QuotedStr('CFG_PROGEC') + ' AND ';
      strSQL := strSQL + '   SIS_CODEMP = ' + QuotedStr(VS_strCodEmp);

      qryCadGen.Close;
      qryCadGen.SQL.Clear;
      qryCadGen.SQL.Add(strSQL);
      qryCadGen.Open;

      If qryCadGen.FieldByName('VALOR').IsNull Then
        strSQL := '0'
      Else
        strSQL := qryCadGen.FieldByName('VALOR').AsString;

      qryCadGen.Close;
    Except
      On E: Exception Do
      Begin
        Raise Exception.Create('Não consegui pegar o proximo sequencial. Tente novamente!');
      End;
    End;

    Result := fStrZero(strSQL, fTamDocCadRec);
    If StrToInt(Result) = 0 Then
      Result := fStrZero(IntToStr(StrToInt(Result)+1), fTamDocCadRec);

    fAtuSequencial(fStrZero(IntToStr(StrToInt(Result)+1), fTamDocCadRec));

  Finally
    FreeAndNil(qryCadGen);
  End;
end;

function TfrmGarantiaConvRepCliente.fScriptAtualizarGarantia: String;
begin
  Result := ' UPDATE MOVGAD ';
  Result := Result + ' SET GAD_REPOST = :REPOST, GAD_SCREDI = :SCREDI, GAD_DTACRE = :DTACRE, GAD_HRACRE = :HRACRE, GAD_OPECRE = :OPECRE, ';
  Result := Result + ' GAD_QTDDEV = (GAD_QTDDEV + :QTDDEV) ';
  Result := Result + ' WHERE AUTOINCREM = :AUTOINCREM ';
end;

function TfrmGarantiaConvRepCliente.fTemItemSelecionado: Boolean;
Var
  Reg: TBookMark;
begin
  Result := False;
  if cdsDados.IsEmpty then
    Exit(Result);
  Try
    cdsDados.DisableControls;
    Reg := cdsDados.GetBookMark;
    cdsDados.First;
    while Not cdsDados.Eof do
    begin
      Result := (cdsDadosSELECIONADO.AsString = VB_SIM);
      if Result then
      begin
        Break;
      end;
      cdsDados.Next;
    end;
  Finally
    if Assigned(Reg) then
    begin
      if cdsDados.BookMarkValid(Reg) then
      begin
        cdsDados.GotoBookMark(Reg);
      end;
      cdsDados.FreeBookMark(Reg);
    end;
    cdsDados.EnableControls;
  End;
end;

function TfrmGarantiaConvRepCliente.fScriptCarregarGarantias: String;
begin
  Result :=          ' SELECT D.AUTOINCREM,  D.GAD_CODITE, D.GAD_NUMDOC, D.GAD_ESPDOC, D.GAD_CODEMP, ';
  Result := Result +        ' IFNULL(D.GAD_CODFAB,I.ITE_CODFAB) AS "GAD_CODFAB", ';
  Result := Result +        ' D.GAD_QTDREQ, D.GAD_REPOST, D.GAD_SCREDI, ';
  Result := Result +        ' G.GAG_NUMENT, G.GAG_DTAENT, ';
  Result := Result +        ' I.ITE_DESITE, I.ITE_REFERE, I.ITE_CODUNI, U.UNI_SIGUNI, ';
  Result := Result +        ' D1.DET_NUMDOC, D1.DET_ESPDOC, (D1.DET_TOTITE  + D1.DET_DESACE) AS  DET_TOTCRE, D1.DET_SEQGER, D1.AUTOINCREM AS DET_AUTINC, ';
  Result := Result +        ' SUM(IFNULL(E.GAE_QTDENV,0) - (IFNULL(E.GAE_QTDREF,0) + IFNULL(E.GAE_QTDRET,0))) AS GAE_SALDO_, ';
  Result := Result +        ' ''0'' AS SELECIONADO, ''0'' AS USALOTE, '''' AS NUMLOTE, ';
  Result := Result +        ' CONCAT(D1.DET_NUMDOC,"-", D1.DET_ESPDOC) AS NUMENT, D1.DET_DTAENT, CAST(IFNULL(G1.GER_DTAENT,"") AS DATE) AS GER_DTAENT ';

  Result := Result + ' FROM MOVGAG G ';
  Result := Result + ' INNER JOIN MOVGAD D ON D.GAD_SEQGAG = G.AUTOINCREM AND D.GAD_REPOST = ''N'' AND D.GAD_SCREDI IN (0,1) ';
  Result := Result + ' INNER JOIN MOVGRC C ON C.GRC_SEQGAD = D.AUTOINCREM AND C.GRC_OPCDOC IN (''DV'',''OE'',''NE'',''GA'') ';
  Result := Result + ' INNER JOIN MOVDET D1 ON D1.AUTOINCREM = C.GRC_SEQDET ';
  Result := Result + ' INNER JOIN MOVGAE E ON E.GAE_SEQGAD = D.AUTOINCREM ';
  Result := Result + ' INNER JOIN CADITE I ON I.ITE_CODITE = D.GAD_CODITE ';
  Result := Result + ' INNER JOIN CADUNI U ON U.UNI_CODUNI = I.ITE_CODUNI ';
  Result := Result + '  LEFT JOIN MOVGER G1 ON G1.GER_NUMDOC = D.GAD_NUMDOC AND G1.GER_ESPDOC = D.GAD_ESPDOC AND G1.GER_CODEMP = D.GAD_CODEMP ';
  Result := Result + ' WHERE G.GAG_CODCLI = :CODCLI AND G.GAG_CODEMP = :CODEMP ';
  Result := Result +       ' AND ((E.GAE_QTDENV - (E.GAE_QTDREF + E.GAE_QTDRET)) > 0) ';
  Result := Result + ' GROUP BY D.AUTOINCREM ';
  Result := Result + ' ORDER BY G.GAG_NUMENT';
end;

function TfrmGarantiaConvRepCliente.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    if Sender = edtCodCli then
    begin
      fDefinirCliente(edtCodCli.Text);
      If fEmptyStr(edtNomCli.Text) Then
      Begin
        fMensagem('','Cliente não encontrado!',['&OK']);
        Result := False;
      End
      Else If Not fEmptyStr(fRetCodEmpClienteFilial(edtCodCli.Text)) Then
      Begin
        fMensagem('','Cliente Filial não é permitido!',['&OK']);
        Result := False;
      End
      Else
        Result := True;
    end;
  End;

  If Not (Result) Then
    pSetFocus(Sender);
end;

procedure TfrmGarantiaConvRepCliente.pAvaliarUsoLote(const strCodIte: String);
begin
  if objCadLot.fExisteLote(strCodIte, VS_strCodEmp, '', False, False) then
  begin
    cdsDadosUSALOTE.AsString := VB_SIM;
  end
  Else
  begin
    cdsDadosUSALOTE.AsString := VB_NAO;
  end;
end;

procedure TfrmGarantiaConvRepCliente.pConfigurar;
begin
  intDecUni := fCfgSis('DECUNI');
  strPortad := fCfgSis('PORGAR', varString);
  pCriaTabelaDados;
end;

procedure TfrmGarantiaConvRepCliente.pCriaTabelaDados;

begin
  if cdsDados.Active then
  begin
    cdsDados.EmptyDataSet;
  end
  else begin
    cdsDadosITE_REFERE.Size := fTamRefere;
    cdsDados.CreateDataSet;
    cdsDados.Open;
  end;
end;

function TfrmGarantiaConvRepCliente.fGeraSaidaEstoque: Boolean;
Var
  Lista: TListaItensConv;
  strGarantia: String;
  blnQuebra: Boolean;
begin
  Result := False;
  Try
    Lista := TListaItensConv.Create;

    cdsDados.First;
    while Not cdsDados.Eof do
    begin
      strGarantia := cdsDadosGAG_NUMENT.AsString;
      Repeat
        Lista.Add(fObterItem);

        cdsDados.Next;

        blnQuebra := strGarantia <> cdsDadosGAG_NUMENT.AsString;

        if Not blnQuebra then
        begin
          blnQuebra := cdsDados.Eof;
        end;

        if blnQuebra then
        begin
          Result :=  fEfetivarSaidaEstoque(Lista);
          if Not REsult then          
            Break;
        end;

      Until (blnQuebra) ;

      Lista.Clear;

      if Not Result  then
        Break;

    end;
  Finally
    if Assigned(Lista) then
    begin
      Lista.Clear;
      FreeAndNil(Lista);
    end;
  End;
end;

procedure TfrmGarantiaConvRepCliente.pMarcarDesmarcar(blnMarcar, blnTodos: Boolean);
begin
  if blnTodos then
  begin
    Try
      cdsDados.DisableControls;
      cdsDados.First;
      While Not cdsDados.Eof Do
      Begin
        pMarcarDesmarcar(blnMarcar);
        cdsDados.Next;
      End;
    Finally
      cdsDados.First;
      cdsDados.EnableControls;
    End;
  end
  else
  begin
    cdsDados.Edit;
    cdsDadosSELECIONADO.AsString := ifthen(blnMarcar,MARCADO,DESMARCADO);
    cdsDados.post;
  end;
end;

function TfrmGarantiaConvRepCliente.fValidarCliente(const strCodCli: String; Out strNomCli: String): Boolean;
begin
  Result := Not fEmptyStr(strCodcli);

  if Result then
  begin
    strNomCli := fRetNomCliente(strCodCli);
  end;

  Result := Not fEmptyStr(strNomCli);
end;

function TfrmGarantiaConvRepCliente.fValidarNumeroLote(const strNumLot: String): Boolean;
Var
  strCodIte : String;
begin
  strCodIte := cdsDadosGAD_CODITE.AsString;
  If fEmptyStr(strNumLot) Then
  Begin
    fMensagem('ATENÇÃO!', 'Informe o número do lote!', ['&Ok']);
    Result := False;
  End
  Else if not objCadLot.fExisteLote(strCodIte,VS_strCodEmp, strNumLot) Then
  Begin
    fMensagem('ATENÇÃO!', 'Lote não encontrado!', ['&Ok']);
    Result := False;
  End
  Else If SameText(strNumLot,'A DEFINIR') Then
  Begin
    fMensagem('ATENÇÃO!', 'Esse lote somente pode ser utilizado com entrega Futura!', ['&Ok']);
    Result := False;
  End
  else
  begin
    Result := True;
  end;
end;

function TfrmGarantiaConvRepCliente.fObterHistoricoCredito(const Lista: TListaItensConv): TStringList;
Var
  Item: TItemConv;
begin
  Result := TStringList.Create;
  Result.Add('REF. LANC. CREDITO (CONVESAO DE GARANTIA)');
  for Item in Lista do
  begin
    Result.Add(Item.fDescricaoHistorico);
  end;
end;

function TfrmGarantiaConvRepCliente.fObterItem: TItemConv;
Var
  fltCredito: Double;
begin

  fltCredito := (cdsDadosDET_TOTCRE.ASFLOAT/cdsDadosGAD_QTDREQ.AsFloat) * cdsDadosGAE_SALDO_.AsFloat;
  fltCredito := RoundTo(fltCredito, - intQtdCasasDecimaisValorUnitario);
  Result := TItemConv.Create;
  Result.strAutIncGad :=  cdsDadosAUTOINCREM.AsString;
  Result.strNumEnt    :=  cdsDadosGAG_NUMENT.AsString;
  Result.strNumDoc    :=  cdsDadosDET_NUMDOC.Asstring;
  Result.strEspDoc    :=  cdsDadosDET_ESPDOC.AsString;
  Result.fltValor     :=  fltCredito;
  Result.strAutIncGer :=  cdsDadosDET_SEQGER.AsString;
  Result.strIncOri    :=  cdsDadosDET_AUTINC.AsString;
  Result.strCodIte    :=  cdsDadosGAD_CODITE.AsString ;
  Result.strCodMar    :=  '';
  Result.strNumLot    :=  cdsDadosNUMLOTE.AsString;
  Result.strEstado    :=  '';
  Result.strDesIte    :=  cdsDadosITE_DESITE.AsString;
  Result.strRefere    :=  '';
  Result.strUnidad    :=  cdsDadosIte_CodUni.AsString;
  Result.strForIte    :=  '';
  Result.fltQtdIte    :=  cdsDadosGAE_SALDO_.AsFloat;
  Result.fltUnitar    :=  0.0;
  Result.fltUniOri    :=  0.0;
  Result.fltUniVis    :=  0.0;
  Result.fltTotIte    :=  0.0;
  Result.fltVlrCon    :=  0.0;
  Result.strGadNumDoc :=  cdsDadosGad_NumDoc.AsString;
  Result.strGadEspDoc :=  cdsDAdosGad_EspDoc.AsString;
  Result.dtaGerDtaEnt :=  cdsDadosGer_DtaEnt.AsDateTime;
  Result.strGadCodEmp :=  cdsDadosGad_CodEmp.AsString;
end;

function TfrmGarantiaConvRepCliente.fObterLote(const strCodIte: String): String;
Var
  AuxEdit: TEditFocus;
  Key: Char;
  arrNumLot : TConsultasArray;
begin
  Key := '/';
  AuxEdit := Nil;
  Try
    AuxEdit := TEditFocus.Create(Nil);
    if fPesqLoteItens(Self, AuxEdit, nil, intDecUni, Nil, Key, arrNumLot, True, strCodIte) then
    begin
      Result := AuxEdit.Text;
    end
    else
    begin
      Result := AuxEdit.Text;
    end;
  Finally
    if Assigned(AuxEdit) then
    begin
      FreeAndNil(AuxEdit);
    end;
  End;
end;

function TfrmGarantiaConvRepCliente.fGravando(pgbProgresso: TcxProgressBar): Boolean;
Var
  Opcao: TOpcaoConversao;

begin
  Opcao := fMensagemOpcaoCreditoReposicao;

  Self.pgbProgresso := pgbProgresso;

  if Opcao in [TOpcaoConversao.Credito, TOpcaoConversao.Reposicao] then
  begin
    Result :=  fConverter(Opcao);
  end
  else
    Result := False;

  Self.pgbProgresso := nil;
end;

function TfrmGarantiaConvRepCliente.fGravarCredito(ItensCredito: TListaItensConv): Boolean;
Var
  fltTotCre: Double;
  Item: TItemConv;
  strNumDup : String;
  Erros: Integer;
  strEspDoc: String;
  HistoricoCredito: TStringList;
begin
  Erros := 0;
  fltTotCre := 0;
  if ItensCredito.First.strEspDoc = 'GA' then
  begin
    strNumDup := fRetSequencial('PROCCO', VS_strCodEmp, fTamDocCadRec);
    strEspDoc := 'CC';
  end
  else
  begin
    strNumDup := Format('%s-%s',[ItensCredito.First.strNumDoc, ItensCredito.First.strEspDoc]);
    strEspDoc := 'NF';
  end;

  for Item in ItensCredito do
  begin
    fltTotCre := fltTotCre + item.fltValor;
    if Not  fAtualizarGarantia(item.strAutIncGad, TOpcaoConversao.Credito, item.fltQtdIte) then
      Inc(Erros);
  end;

  Result := (Erros = 0);

  {$Region 'Gravar Crédito'}
  if Result then
  begin
    Try
      HistoricoCredito := fObterHistoricoCredito(ItensCredito);

      Result := fGravaCadRec(Self.Name,                                                                  //    strNomFrmLogCtr,
                             'INCLUSÃO',                                                                //    strDescriLogCtr,
                             strNumDup,   // Duplicata                                                  //       strNumDup,
                             'A',                                                                       //       strParcel: String;
                             0,                                                                         //       intSeqBai: Integer;
                             strEspDoc,        // Espécie                                                  //        strEspDoc,
                             strCodCli,                                                                 //       strCodCli,
                             VS_strCodEmp,                                                              //       strCodEmp,
                             strLoginUsuarioLogado,                                                                 //       strCodVen,
                             strLoginUsuarioLogado,                                                                 //       strCodDig,
                             strPortad,                                                                 //      strCodPor: String;
                             VS_Date,                                                                   //      dtaDtaCad,
                             VS_Date,                                                                   //      dtaDtaVen: TDateTime;
                             -fltTotCre,                                                                 //      fltValDup,
                             -fltTotCre,                                                                 //      fltValOri,
                             0.0,                                                                       //      fltDesCob: Double;
                             'N',                                                                       //      strDescon,
                             HistoricoCredito.Text, // Histórico 1                                      //       strHist01,
                             '', // Histórico 2                                                         //       strHist02,
                             '',                                                                        //      strPorBai,
                             '',                                                                        //      strCtaBai,
                             '',                                                                        //      strOpeBai,
                             '',                                                                        //      strDocBai: String;
                             0.0,                                                                       //      fltValRec: Double;
                             0,                                                                         //      dtaDtaRec: TDateTime;
                             'N',                                                                       //      strAdtCli,
                             '',                                                                        //      strCodEve,
                             '',                                                                        //      strCodVel,
                             '',                                                                        //      strTipFor,
                             '',                                                                        //      strCodCnd: String;
                             False,                                                                     //      blnConApr: Boolean;
                             '',                                                                        //      strCodCta: String;
                             0,                                                                         //      intSeqCon: Integer;
                             0,                                                                         //      fltGrvOri: Double;
                             '',                                                                        //      strObsAg1: String = '';
                             '',                                                                        //      strObsAg2: String = '';
                             '',                                                                        //      strObsAg3: String = '';
                             '',                                                                        //      strCtaSer: String = '';
                             0,                                                                         //      fltValSer: Double = 0;
                             0,                                                                         //      intResCai: Integer = 0;
                             0,                                                                         //      fltVlrCom: Double = 0;
                             0,                                                                         //      fltFatCom: Double = 0;
                             '',                                                                        //      strEmpBai: String = '';
                             '',                                                                        //      strEmp_PD: String = '';
                             '',                                                                        //      strDocDiv: String = '';
                             '',                                                                        //      strEspDiv: String = '';
                             '',                                                                        //      strEmpDiv: String = '';
                             '',                                                                        //      strCliDiv: String = '';
                             0,                                                                         //      fltVlrRep: Double = 0;
                             0,                                                                         //      fltFatRep: Double = 0;
                             '',                                                                        //      strCodRep: String = '';
                             0,                                                                         //      fltValIPI: Double = 0;
                             0,                                                                         //      fltValRet: Double = 0;
                             'N',                                                                       //      strOriF11: String = 'N';
                             0,                                                                         //      fltDesSuj: Double = 0;
                             0,                                                                         //      fltJurSuj: Double = 0;
                             0,                                                                         //      fltValCqP: Double = 0;
                             0,                                                                         //      fltValCqV: Double = 0;
                             0,                                                                         //      fltValDin: Double = 0;
                             0,                                                                         //      fltValCar: Double = 0;
                             0,                                                                         //      fltValOrd: Double = 0;
                             0,                                                                         //      fltValFin: Double = 0;
                             '',                                                                        //      strBarCon: String = '';
                             0,                                                                         //      fltPerDPo: Double = 0;
                             0,                                                                         //      intQtdDAV: Integer = 0;
                             0,                                                                         //      fltVrTrDv: Double = 0;
                             '',                                                                        //      strHisBai: String = '';
                             0,                                                                         //      fltValAce: Double = 0;
                             0,                                                                         //      fltValFre: Double = 0;
                             0,                                                                         //      fltDifOri: Double = 0;
                             0,                                                                         //      fltValAnt: Double = 0;
                             0,                                                                         //      fltComDiv: Double = 0;
                             0,                                                                         //      fltFatDiv: Double = 0;
                             '',                                                                        //      strCodDiv: String = '';
                             0,                                                                         //      fltValFCP: Double = 0;
                             'INCLUSÃO', //     strStatusDEPS:                                          //       strStatusDEPS: String = 'INCLUSÃO';
                             '',  //    strOpcDoc:                                                      //      strOpcDoc: String = '';
                             '',  //     strAutincMovGerFC:                                             //      strAutincMovGerFC: String = '';
                             ItensCredito.First.strAutIncGer); //   strINCDOC:                                              //      strINCDOC: String = ''): Boolean;
    Finally
      if Assigned(HistoricoCredito) then
      begin
        FreeAndNil(HistoricoCredito);
      end;
    End;
  end;
{$Endregion}
end;

function TfrmGarantiaConvRepCliente.fInserirMovDet(Const strAutIncMovGer, strNumDoc,  strEspDoc: String; Item: TItemConv): Boolean;
Var
  strAutIncDet: String;
begin
{$Region 'Grava MovDet'}
  Result := fGravaMovDet(strAutIncDet,                                                                            //       Var strAutInc: String;
                         strAutIncMovGer,                                                                               //       strSeqGer: String;
                         strNumDoc,                                                                               //       strNumDoc,
                         GARANTIA_REPOSICAO_CLIENTE,                                                              //       strEspDoc,
                         VS_strCodEmp,                                                                     //       strCodEmp,
                         Item.strCodIte,                                                                          //       strCodIte,
                         strLoginUsuarioLogado,                                                                     //       strCodVen,
                         '',                                                                                      //       strCodDiv,
                         fRetMarcaItem(Item.strCodIte),                                                           //       strCodMar,
                         '',                                                                                      //       strCodFor,
                         strCodCli,                                                                               //       strCodCli: String;
                         VS_Date,                                                                                 //       dtaDtaEnt,
                         fTime(),                                                                                 //       dtaHorEnt,
                         VS_Date,                                                                                 //       dtaDtaDoc: TDateTime;
                         '',                                                                                      //       strConPag,
                         'C',                                                                                     //       strTip_Fc,
                         '',                                                                                      //       strEstado,
                         Item.strDesIte,                                                                          //       strDescri,
                         Item.strRefere,                                                                          //       strRefere,
                         fRetUnidadeItem(Item.strCodIte),                                                         //       strUnidad,
                         '', //objMovGag.strCodFor,                                                               //       strForIte: String;
                         Item.fltQtdIte,                                                                           //       fltQtdIte,
                         Item.fltUniTar,                                                                           //       fltUnitar,
                         Item.fltUniOri,                                                                           //       fltUniOri,
                         Item.fltUniVis,                                                                           //       fltUniVis,
                         Item.fltTotIte,                                                                           //       fltTotIte,
                         Item.fltVlrCon,                                                                           //       fltVlrCon,
                         0.0,                                                                                     //       fltTotCus,
                         0.0,                                                                                     //       fltTotMed,
                         0.0,                                                                                     //       fltDesCon,
                         0.0,                                                                                     //       fltTotFre,
                         0.0,                                                                                     //       fltDesEsp: Double;
                         '',                                                                                      //       strCodRep,
                         '',                                                                                      //       strCodVe2: String;
                         0.0,                                                                                     //       fltPerCom,
                         0.0,                                                                                     //       fltTotCom,
                         0.0,                                                                                     //       fltTotCo2: Double;
                         '5999',                                                                                  //       strClaFis,
                         '',                                                                                      //       strCodFis: String;
                         0.0,                                                                                     //       fltValIpi,
                         0.0,                                                                                     //       fltAlqIpi,
                         0.0,                                                                                     //       fltBasIpi,
                         0.0,                                                                                     //       fltValIcm,
                         0.0,                                                                                     //       fltAlqIcm,
                         0.0,                                                                                     //       fltBasIcm,
                         0.0,                                                                                     //       fltValRet,
                         0.0,                                                                                     //       fltAlqRet,
                         0.0,                                                                                     //       fltBasRet,
                         0.0,                                                                                     //       fltTotPes,
                         0.0,                                                                                     //       fltPerBas,
                         0.0,                                                                                     //       fltPerRed: Double;
                         False,                                                                                   //       blnJafatu: Boolean;
                         '',                                                                                      //       strTipFat,
                         '',                                                                                      //       strNumFat,
                         '', // Empresa do Faturamento                                                            //       strEmpFat: String;
                         0,                                                                                       //       dtaDtaFat: TDateTime;
                         '',                                                                                      //       strVenFat,
                         '',                                                                                      //       strCndFat: String;
                         0.0,                                                                                     //       fltValFat: Double;
                         'NOR',                                                                                   //       strIdePro,
                         '',                                                                                      //       strIncPis,
                         '',                                                                                      //       strSerie: String;
                         0.0,                                                                                     //       fltDesAce: Double;
                         'N',                                                                                     //       strNotEsp,
                         '',                                                                                      //       strDocDev,
                         '',                                                                                      //       strEspDev,
                         '',                                                                                      //       strEmpDev,
                         '',                                                                                      //       strIteCha,
                         '',                                                                                      //       strIteTin,
                         '',                                                                                      //       strDesCor,
                         '',                                                                                      //       strTipEmb: String;
                         0.0,                                                                                     //       fltQtdEmb,
                         0.0,                                                                                     //       fltPreEmb: Double;
                         '',                                                                                      //       strTipPre: String;
                         0.0,                                                                                     //       fltPrvTin,
                         0.0,                                                                                     //       fltPrcTin,
                         0,                                                                                       //       fltFatTin: Double;
                         '',                                                                                      //       strProEmb,
                         '',                                                                                      //       strCodDig,
                         '',                                                                                      //       strCodCnd,
                         '',                                                                                      //       strCodFpg,
                         '',                                                                                      //       strIteEmb,
                         '',                                                                                      //       strGruEmb: String;
                         0,                                                                                       //       intLazQua: Integer;
                         'N',                                                                                     //       strPromoc,
                         '',                                                                                      //       strSeqTin: String;
                         0.0,                                                                                     //       fltQtdPul: Double;
                         '',                                                                                      //       strPedCom,
                         '',                                                                                      //       strOriDoc,
                         '',                                                                                      //       strNum_Pd,
                         '',                                                                                      //       strEsp_Pd,
                         '',                                                                                      //       strEmp_Pd: String;
                         0,                                                                                       //       intInd_Pd: Integer;
                         '',                                                                                      //       strOrdPro,
                         '',                                                                                      //       strDesNes,
                         '',                                                                                      //       strCliFat: String;
                         0,                                                                                       //       fltBcaMin,
                         0,                                                                                       //       fltBcaCom,
                         0.0,                                                                                     //       fltVolPro: Double;
                         '',                                                                                      //       strCodAca,
                         '',                                                                                      //       strEmpAca: String;
                         False,                                                                                   //       blnProAca,
                         False,                                                                                   //       blnFilKar: Boolean;
                         '',                //  Especie da Entrega Fututa                                         //       strEspFut,
                         '',                //  Documento da Entrega Fututa                                       //       strDocFut,
                         '',                                                                                      //       strEmpFut,
                         '',                //  Empresa da Entrega Fututa                                         //       strTabPre,
                         '',                                                                                      //       strEmpCom: String;
                         '',                                                                                      //       strLinha: String;
                         '',                                                                                      //       strCatali: String;
                         '',                                                                                      //       strCodDil: String;
                         0.0,                                                                                     //       fltPorDil: Double;
                         '',                                                                                      //       strDilCon: String;
                         0.0,                                                                                     //       fltPorCat: Double;
                         0.0,                                                                                     //       fltUniDig: Double;
                         0,                                                                                       //       fltQtdPon: Double;
                         'N',                                                                                     //       strEntFut,
                         '',                                                                                      //       strMotFut: String;
                         0,                                                                                       //       dtaDtaFut: TDateTime;
                         0,                                                                                       //       fltTotCu2: Double;
                         0,                                                                                       //       fltComRep,
                         0,                                                                                       //       fltPerRep: Double;
                         '',                                                                                      //       strKey_EP,
                         Item.strNumLot,   // strNumLot ** RL **                            //       strNumLot,
                         'N',  // strPigBas                                                                       //          strPigBas: String;
                         0,                                                                                       //       fltVaEIpi,
                         0,                                                                                       //       fltAlEIpi,
                         0,                                                                                       //       fltBaEIpi,
                         0,                                                                                       //       fltTotUlt,
                         0,                                                                                       //       fltImpUlt,
                         0,                                                                                       //       fltBaRtSP,
                         0,                                                                                       //       fltVaRtSP,
                         0,                                                                                       //       fltIcOpPr: Double;
                         0,                                                                                       //       intSeqCcr: Integer;
                         0,                                                                                       //       fltEmbala,
                         0,                                                                                       //       fltAlqPis,
                         0,                                                                                       //       fltBasPis,
                         0,                                                                                       //       fltValPis: Double;
                         '',                                                                                      //       strCSTPis: String;
                         0,                                                                                       //       fltAlqCof,
                         0,                                                                                       //       fltBasCof,
                         0,                                                                                       //       fltValCof: Double;
                         '',                                                                                      //       strCSTCof,
                         '',                                                                                      //       strCSTIpi,
                         '',                                                                                      //       strEnqIpi: String;
                         0,                                                                                       //       fltVaERet,
                         0,                                                                                       //       fltAlERet,
                         0,                                                                                       //       fltBaERet: Double;
                         0,                                                                                       //       fltPesLiq: Double;
                         0,                                                                                       //       fltUniTab: Double = 0;
                         '',                                                                                      //       strLot_TA: String = '';
                         0,                                                                                       //       fltConFre: Double = 0;
                         0,                                                                                       //       fltBasAnt: Double = 0;
                         0,                                                                                       //       fltIcmAnt: Double = 0;
                         0,                                                                                       //       fltVendor: Double = 0;
                         0,                                                                                       //       fltOutDes: Double = 0;
                         0,                                                                                       //       fltVlGnre: Double = 0;
                         'P',                                                                                     //       strGnrOri: String = 'P';
                         0,                                                                                       //       fltOutIcm: Double = 0;
                         0,                                                                                       //       fltIseIcm: Double = 0;
                         0,                                                                                       //       fltFreSug: Double = 0;
                         '',                                                                                      //       strCodMot: String = '';
                         '',                                                                                      //       strNatPis: String = '';
                         '',                                                                                      //       strNatCof: string = '';
                         Item.strAutIncGad);                                                                      //       strSeqGad: string = '';

{$EndRegion}
  if Result then
  begin
    Result := fAtualizaEstoqueCadIte(item.strCodIte,
                                     'S',
                                     item.fltQtdIte,
                                     fRetPreUve(vs_strCodEmp, item.strCodIte),
                                     Trim(item.strNumLot));
  end;

  if Result then
  begin
    TMovGag.fInsereMovGrc(Item.strAutIncGad, strAutIncDet, GARANTIA_REPOSICAO_CLIENTE, 'G', Item.strIncOri);
  end;

end;

function TfrmGarantiaConvRepCliente.fInserirMovGer(var strAutInc: String; strNumMovGer, strEspDoc, strCodCli: String; const strObs: String): Boolean;
Var
  arrDuplic  : TarrDuplicata;
  recServicos : TDadosServicos;
  Cliente: Tcliente;
begin
  Cliente := Nil;
  Try

    recservicos.fltValS01 := 0;
    recservicos.fltValS02 := 0;
    recservicos.fltValS03 := 0;
    recservicos.fltValS04 := 0;
    recservicos.fltValS05 := 0;
    recservicos.fltValS06 := 0;
    recservicos.intPraEnt := 0;
    recservicos.fltTotSer := 0;
    recservicos.fltPerIss := 0;
    recservicos.fltRedIss := 0;
    recservicos.fltBasIss := 0;
    recservicos.fltValIss := 0;



    Cliente := TCliente.Create;
    Cliente.limpar;
    Cliente.strCodCli := strcodCli;
    {$Region 'Grava MovGer'}
    Result := fGravaMovGer(strAutInc,                                                                //       Var strAutInc: String;
                           strNumMovGer,                                                                   //       strNumDoc,
                           GARANTIA_REPOSICAO_CLIENTE,                                                  //       strEspDoc,
                           VS_strCodEmp,                                                                //       strCodEmp,
                           '',                                                                          //       strCodTra,
                           strLoginUsuarioLogado,                                                       //       strCodVen,
                           '', //objMovGag.strCodFor,                                                   //       strCodFor,
                           Cliente.strCodCli,                                                           //       strCodCli,
                           'C',                                                                         //       strTip_Fc: String;
                           VS_Date,                                                                     //       dtaDtaEnt,
                           fTime(),                                                                     //       tmrHorEnt,
                           VS_Date,                                                                     //       dtaDtaDoc: TDateTime;
                           '',                                                                          //       strConPag,
                           '',                                                                          //       strEstado,
                           Cliente.strNomCon,                                                           //       strNomCon,
                           Cliente.strEndCon,                                                           //       strEndCon,
                           Cliente.strBaiCon,                                                           //       strBaiCon,
                           Cliente.strCepCon,                                                           //       strCepCon,
                           Cliente.strCidCon,                                                           //       strCidCon,
                           Cliente.strEstCon,                                                           //       strEstCon,
                           Cliente.strTelCon,                                                           //       strTelCon: String;
                           0,                                                                           //       dtaNasCon: TDate;
                           Cliente.strCgcCpf,                                                 //       strCgcCpf,
                           Cliente.strCgcCon,                                                           //       strCgcCon,
                           Cliente.strIesCon,                                                           //       strIesCon,
                           Cliente.strCli_Rg,                                                           //       strCli_Rg: String;
                           0.0,                                                                         //       fltBasSim,
                           0.0,                                                                         //       fltBasIpi,
                           0.0,                                                                         //       fltAlqIpi,
                           0.0,                                                                         //       fltTotIpi,
                           0.0,                                                                         //       fltBasIcm,
                           0.0,                                                                         //       fltAlqIcm,
                           0.0,                                                                         //       fltTotIcm,
                           0.0,                                                                         //       fltTotRet,
                           0.0,                                                                         //       fltAlqRet,
                           0.0,                                                                         //       fltBasRet,
                           0.0,                                                                         //       fltRet_SP,
                           0.0,                                                                         //       fltDesEsp,
                           0.0,                                                                         //       fltVlrCon,
                           0.0,                                                                         //       fltTotPro,
                           0.0,                                                                         //       fltTotCus,
                           0.0,                                                                         //       fltTotMed: Double;
                           '',                                                                          //       strTipFre: String;
                           0.0,                                                                         //       fltTotFre,
                           0.0,                                                                         //       fltPesBru,
                           0.0,                                                                         //       fltPesLiq,
                           0,                                                                           //       fltVolume: Double;
                           '',                                                                          //       strEspeci,
                           '',                                                                          //       strMarca,
                           '',                                                                          //       strMen001,
                           '',                                                                          //       strMen002,
                           '',                                                                          //       strMen003,
                           '',                                                                          //       strMen004,
                           '',                                                                          //       strMen005: String;
                           False,                                                                       //       blnJafatu: Boolean;
                           '',                                                                          //       strTipFat,
                           '',                                                                          //       strNumFat,
                           '', // Empresa do Faturamento                                                //       strEmpFat: String;
                           0,                                                                           //       dtaDtaFat: TDateTime;
                           '',                                                                          //       strVenFat,
                           '',                                                                          //       strCndFat: String;
                           False,                                                                       //       blnDevEsp: Boolean;
                           0.0,                                                                         //       fltValFat,
                           0.0,                                                                         //       fltVPar01,
                           0.0,                                                                         //       fltVPar02,
                           0.0,                                                                         //       fltVPar03,
                           0.0,                                                                         //       fltVPar04,
                           0.0,                                                                         //       fltVPar05,
                           0.0,                                                                         //       fltVPar06,
                           0.0,                                                                         //       fltVPar07,
                           0.0,                                                                         //       fltVPar08,
                           0.0,                                                                         //       fltVPar09,
                           0.0,                                                                         //       fltVPar10,
                           0.0,                                                                         //       fltVPar11,
                           0.0,                                                                         //       fltVPar12: Double;
                           arrDuplic,                                                                   //       arrDuplic: TarrDuplicata;
                           '',                                                                          //       strSerie,
                           'N',                                                                         //       strNotEsp,
                           '5999',                                                                      //       strClaFis,
                           '',                                                                          //       strClaFi2,
                           '',                                                                          //       strClaFi3,
                           '',                                                                          //       strNatOpe: String;
                           0.0,                                                                         //       fltPorDes: Double;
                           '',                                                                          //       strCodDig,
                           '',                                                                          //       strCodCnd,
                           '',                                                                          //       strCodFpg: String;
                           0.0,                                                                         //       fltFatNot: Double;
                           recServicos,                                                                 //       recServicos: TDadosServicos;
                           0.0,                                                                         //       fltDesAce: Double;
                           '',                                                                          //       strOriDoc,
                           '',                                                                          //       strConEnt,
                           '',                                                                          //       strCodRep: String;
                           0.0,                                                                         //       fltAlqIrf,
                           0.0,                                                                         //       fltValIrf,
                           0.0,                                                                         //       fltAlqPis,
                           0.0,                                                                         //       fltValPis,
                           0.0,                                                                         //       fltAlqCof,
                           0.0,                                                                         //       fltValCof,
                           0.0,                                                                         //       fltAlqCsl,
                           0.0,                                                                         //       fltValCsL,
                           0.0,                                                                         //       fltIrfRet,
                           0.0,                                                                         //       fltPisRet,
                           0.0,                                                                         //       fltCofRet,
                           0.0,                                                                         //       fltCslRet: Double;
                           '',                                                                          //       strNotRet: String;
                           0.0,                                                                         //       fltAlIrfP,
                           0.0,                                                                         //       fltAlPisP,
                           0.0,                                                                         //       fltAlCofP,
                           0.0,                                                                         //       fltAlCslP,
                           0.0,                                                                         //       fltSerRet: Double;
                           '',                                                                          //       strNoReSe: String;
                           0.0,                                                                         //       fltPeSgSo,
                           0.0,                                                                         //       fltVlSgSo,
                           0.0,                                                                         //       fltIrPrRt,
                           0.0,                                                                         //       fltIrPrDv,
                           0.0,                                                                         //       fltIrSeRt,
                           0.0,                                                                         //       fltIrSeDv,
                           0.0,                                                                         //       fltPiPrRt,
                           0.0,                                                                         //       fltPiPrDv,
                           0.0,                                                                         //       fltPiSeRt,
                           0.0,                                                                         //       fltPiSeDv,
                           0.0,                                                                         //       fltCoPrRt,
                           0.0,                                                                         //       fltCoPrDv,
                           0.0,                                                                         //       fltCoSeRt,
                           0.0,                                                                         //       fltCoSeDv,
                           0.0,                                                                         //       fltCsPrRt,
                           0.0,                                                                         //       fltCsPrDv,
                           0.0,                                                                         //       fltCsSeRt,
                           0.0,                                                                         //       fltCsSeDv: Double;
                           '',                                                                          //       strOrdPro: String;
                           0.0,                                                                         //       fltBasOrg,
                           0.0,                                                                         //       fltIcmOrg: Double;
                           0,                                                                           //       intNConhe: Integer;
                           '',                                                                          //       strConsum,                     // Consumidor final
                           'N',                                                                         //       strEntFat,
                           '',                                                                          //       strCliFat,
                           '',      // Operador da Expedição                                          //       strOpeExp,
                           '',      // Separador da Expedição                                         //       strSepExp,
                           '',                                                                          //       strTabPre,
                           '',                                                                          //       strNum_Pr,
                           'N',     // Entrega Futura                                                          strEntFut: String;
                           FALSE,  // Baixa de Entrega Futura                                                  blnBaiFut: Boolean;
                           0,      // Margem de Lucro                                                          fltMargem: Double;
                           0.0,    // Base do retido (caso tivesse) com ipi e frete de entrada                 fltBaRtSp,
                           0.0,    // Valor do retido considerando a base acima.                               fltVlRtSp: Double;
                           'N',    // Gerar produção fora da loja                                            strOprFlj,
                           '',     // Numero do Registro - Correios ou Transportadora                          strNumReg: String;
                           VS_Date,// Data de Entrega no Romaneio                                              dtaDtEntr: TDateTime;
                           '',     // Classificação fiscal 4                                                 strClaFi4,
                           'N',    // AUTO-SERVIÇO                                                            strAutSer,
                           '',     // Evento                                                                   strCodEve,
                           '',     // AUTINC ENDEREÇO DE ENTREGA                                              strAutEnt,
                           '',     // Conteúdo do CNFNFE                                                      strObsNfe,
                           '',     // Motivo da Devolução                                                    strCodOco: String;
                           '',                                                                           //      strFasObr: String;
                           True,  // Imprime Duplicatas na NF-e                                          //      blnIpDpNf: Boolean;
                           0,                                                                            //      fltValCre: Double    = 0;
                           0,                                                                            //      dtadtlBex: TDateTime = 0;
                           '',                                                                           //      strEmlCon: String    = '';
                           0,                                                                            //      dtaDtESNf: TDateTime = 0;
                           0,                                                                            //      tmrHrESNf: TDateTime = 0;
                           Nil,                                                                          //      objFinanc: Pointer = Nil;
                           '',                                                                           //      strDocCon: String = '';            // Conhecimento de Frete
                           '',                                                                           //      strCodObr: String = '';
                           '',                                                                           //      strCodArt: String = '';
                          'N',                                                                           //      strPermut: String = 'N'; // Permuta para isenção de pagamento de comissão
                           '',                                                                           //      strRetIss: String = '';
                           '',                                                                           //      strOpcDoc: String = '';
                           0,                                                                            //      fltFreSug: Double = 0;
                           '',                                                                           //      strNumAde: String = '';
                           0,                                                                            //      fltBasAnt: Double = 0;            //BASE DE ICMS ANTECIPADO
                           0,                                                                            //      fltValAnt: Double = 0;            //VALOR DE ICMS ANTECIPADO
                           '',                                                                           //      strNaoAtu: String = '';
                           '',                                                                           //      strEntUrg: String = '';
                           '',                                                                           //      strMenExp: String = '';
                           '',                                                                           //      strMenEx2: String = '';
                           '',                                                                           //      strMenEx3: String = '';
                           '',                                                                           //      strMenEx4: String = '';
                           0,                                                                            //      fltDupRec: Double = 0;
                           0,                                                                            //      fltValAdt: Double = 0;
                           0,                                                                            //      fltDeDVCf: Double = 0;
                           '',                                                                           //      strPlaVei: String = '';
                           '',                                                                           //      strKm_Vei: String = '';
                           '',                                                                           //      strCliOri: String = '';
                           '',                                                                           //      strCodMot: String = '';
                           '',                                                                           //      strBetone: String = '';
                           '',                                                                           //      strLacre_: String = '';
                           '',                                                                           //      strTipMps: String = '';
                           '',                                                                           //      strAbatim: String = '';
                           '',                                                                           //      strBrita_: String = '';
                           '',                                                                           //      strConBom: String = '';
                           0,                                                                            //      intFckDia: Integer = 0;
                           0,                                                                            //      fltImpPag: Double = 0;
                           0,                                                                            //      intPrzMed: integer = 0;
                           False,                                                                        //      blnImpPdv: Boolean = False;
                           True);                                                                        //      blnDTEXREP: Boolean = False;
    {$EndRegion}

    If Result Then
      objAuditoriaSaldo.Adicionar(strAutInc, 'MOVGER');
  Finally
    if Assigned(Cliente) then
      FreeAndNil(Cliente);
  end;
end;

{ TCliente }
procedure TCliente.Limpar;
begin
    strCodCli:= '';
    strNomCon  := '';
    strEndCon:= '';
    strBaiCon:= '';
    strCepCon:= '';
    strCidCon:= '';
    strEstCon:= '';
    strTelCon:= '';
    dtaNasCon:= 0;
    strCgcCpf:= '0';
    strCgcCon:= '';
    strIesCon:= '';
    strCli_Rg:= '';
end;

{ TItemConv }

function TItemConv.fDescricaoHistorico: String;
Var
  LstrDocVenda: String;
  LstrDtaVenda: String;
  LintNumDoc: Integer;
  LstrNumDoc: String;
  LstrProduto: String;
  LstrDocumento: String;
begin
  if TryStrToInt(Self.strGadNumDoc,LintNumDoc) then
  begin
    LstrNumDoc := intToStr(lIntNumDoc);
  end
  else
  begin
    LstrNumDoc := Self.strGadNumDoc;
  end;

  LstrDocVenda := Format('NF VENDA: %0:s-%1:s-%2:s',[LstrNumDoc,
                                                     Self.strGadEspDoc,
                                                     Self.strGadCodEmp]);

  LstrDtaVenda := Format('DT. VENDA: %s',[FormatDateTime('dd/mm/yyyy',self.dtaGerDtaEnt)]);

  LstrProduto := Format('PRODUTO: %0:s-%1:s-%2:s-Qtd: %3:s',[Self.strCodIte, Self.strDesIte, Self.strUnidad, FormatFloat('0',Self.fltQtdIte)]);

  LstrDocumento := Format('Documento: %0:s-GA-%1:s',[Self.strNumEnt,Self.strGadCodEmp]);

  Result := Format('%0:s - %1:s - %2:s - %3:s', [LstrDtaVenda, LstrDocVenda, LstrDocumento, LstrProduto]);
end;

end.
