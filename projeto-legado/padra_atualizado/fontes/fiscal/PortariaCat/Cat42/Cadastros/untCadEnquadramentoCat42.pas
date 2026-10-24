unit untCadEnquadramentoCat42;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.AppEvnts, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask, MaskEditFocus, Data.DB, StrUtils,
  Vcl.DBCtrls, Uni, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDBEdit,
  frxClass, frxExportCSVTestabilidade, Vcl.Menus, Vcl.ComCtrls,
  BitBtnLockedIncrem;

type
  TfrmCadEnquadramentoCat42 = class(TfrmPaiCad)
    Label270: TLabel;
    mskCfopEnquadramento: TMaskEditFocus;
    Label1: TLabel;
    mskCstEnquadramento: TMaskEditFocus;
    Label247: TLabel;
    dtsTabela: TDataSource;
    lcbDescricaoEnquadramento: TDBLookupComboBox;
    dtsDescricaoEnquadramento: TDataSource;
    btnEnquadramentoVsPeriodoApuracao: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dtsTabelaStateChange(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnEnquadramentoVsPeriodoApuracaoClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
  private
    qryDesEnq: TUniQuery;

    function fRetEnquadramentosCstObrigatorio: string;

    {procedure pCriarTabelaDescricaoEnquadramento;}
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadEnquadramentoCat42: TfrmCadEnquadramentoCat42;

implementation

uses untTypesSistema, untFuncoesConsulta, untTConstantesCfop, untFuncoes,
  untCadEnqVsPeriodoApuracaoCat42;

{$R *.dfm}

procedure TfrmCadEnquadramentoCat42.btnEnquadramentoVsPeriodoApuracaoClick(Sender: TObject);
begin
  if not qryTabela.IsEmpty then
  begin
    pCriarFormularios(TfrmCadEnqVsPeriodoApuracaoCat42, frmCadEnqVsPeriodoApuracaoCat42);
    Try
      frmCadEnqVsPeriodoApuracaoCat42.ShowModal;
    Finally
      frmCadEnqVsPeriodoApuracaoCat42.Free;
    End;
  end
  else
    fMensagem('AVISO', 'Não existe enquadramento p/ processamento!', ['OK']);

end;

procedure TfrmCadEnquadramentoCat42.btnAlterarClick(Sender: TObject);
begin
  inherited;
  btnEnquadramentoVsPeriodoApuracao.Enabled := False;
end;

procedure TfrmCadEnquadramentoCat42.btnCancelaClick(Sender: TObject);
begin
  inherited;
  btnEnquadramentoVsPeriodoApuracao.Enabled := True;
end;

procedure TfrmCadEnquadramentoCat42.btnClick(Sender: TObject);
  var
    qryAux: TUniQuery;
begin
  inherited;
  qryAux := fCriaQuery(nil);
  try
    with qryAux do
    begin
      Close;
      SQL.Clear;
      SQL.Text := 'DELETE FROM CADENQ';
      ExecSQL;
    end;
  finally
    qryAux.Free;
  end;
end;

procedure TfrmCadEnquadramentoCat42.btnGravarClick(Sender: TObject);
  var
    strCfopDupl: string;
    verificaCfopDuplicado: TConstantesCfop;
begin
  qryTabela.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CADENQ', VS_strCodEmp);
  qryTabela.FieldByName('ENQ_CLAFIS').AsString := mskCfopEnquadramento.Text;
  qryTabela.FieldByName('ENQ_CODFIS').AsString := mskCstEnquadramento.Text;

  verificaCfopDuplicado := TConstantesCfop.Create;
  try
    strCfopDupl := verificaCfopDuplicado.fRetEnquadramentosCfopDuplicado(lcbDescricaoEnquadramento.KeyValue, qryTabela.FieldByName('ENQ_CLAFIS').AsString);
    if not fEmptyStr(strCfopDupl) then
    begin
      fMensagem('Atenção', 'O(s) CFOP(s): ' + chr(13) +
                           strCfopDupl + chr(13) + chr(13) +
                           ' constam como duplicados nos Enquadramentos!', ['&Ok']);
      Abort;
    end;
  finally
    verificaCfopDuplicado.Free;
  end;

  btnEnquadramentoVsPeriodoApuracao.Enabled := True;
  inherited;

end;

procedure TfrmCadEnquadramentoCat42.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pSetFocus(lcbDescricaoEnquadramento);
  btnEnquadramentoVsPeriodoApuracao.Enabled := False;
end;

procedure TfrmCadEnquadramentoCat42.btnPesquisarClick(Sender: TObject);
  var
    strSQL: string;
    qryConsulta: TUniQuery;
    arrSel: TConsultasArray;
    arrTitCol: array of string;

  procedure pAddNomeColuna(strNomCol: string);
  begin
    SetLength(arrTitCol, Succ(Length(arrTitCol)));
    arrTitCol[High(arrTitCol)] := strNomCol;
  end;
begin

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  DES.ENQ_DESENQ, ';
  strSQL := strSQL + '  CAD.ENQ_CLAFIS, ';
  strSQL := strSQL + '  CAD.ENQ_CODFIS, ';
  strSQL := strSQL + '  CAD.AUTOINCREM  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADENQ CAD';
  strSQL := strSQL + '  LEFT JOIN DESENQ DES';
  strSQL := strSQL + '    ON DES.AUTOINCREM = CAD.ENQ_CODENQ ';

  qryConsulta := fCriaQuery(nil);
  try
    if fConsulta([strSQL],
                 arrTitCol,
                 ['ENQ_CODENQ'],
                 'AUTOINCREM',
                 'CADENQ',
                 Self.Name,
                 'Cadastro de Configuração de Enquadramento por Cfop',
                 qryConsulta,
                 nil,
                 True,
                 arrSel,
                 'AUTOINCREM',
                 nil) then
    begin
      qryTabela.Locate('AUTOINCREM', qryConsulta.FieldByName('AUTOINCREM').AsString, []);

      mskCfopEnquadramento.Text := qryConsulta.FieldByName('ENQ_CLAFIS').AsString;
      mskCstEnquadramento.Text := qryConsulta.FieldByName('ENQ_CODFIS').AsString;
      pEnabled(Self, False);
      btnAlterar.SetFocus;
    end;
  finally
    FreeAndNil(qryConsulta);
  end;
end;

procedure TfrmCadEnquadramentoCat42.dtsTabelaStateChange(Sender: TObject);
begin
  inherited;

  mskCfopEnquadramento.Text := qryTabela.FieldByName('ENQ_CLAFIS').AsString;
  mskCstEnquadramento.Text := qryTabela.FieldByName('ENQ_CODFIS').AsString;
end;

procedure TfrmCadEnquadramentoCat42.FormCreate(Sender: TObject);
begin
  inherited;

  strNomeTabela := 'CADENQ';
  strNomeCampo  := 'AUTOINCREM';

  blnUsaAutInc := False;

  qryTabela := fCriarQuery('SELECT * FROM CADENQ WHERE FALSE', Self);

  qryDesEnq := fCriarQuery('SELECT * FROM DESENQ', Self);
  dtsDescricaoEnquadramento.DataSet := qryDesEnq;
  qryDesEnq.Open;

  dtsTabela.DataSet := qryTabela;
end;

procedure TfrmCadEnquadramentoCat42.FormShow(Sender: TObject);
begin
  inherited;
  qryTabela.Open;
  pSetFocus(btnIncluir);
end;

function TfrmCadEnquadramentoCat42.fRetEnquadramentosCstObrigatorio: string;
  var
    qryAux: TUniQuery;
begin
  Result := '';

  qryAux := fCriaQuery(nil);
  try
    with qryAux do
    begin
      Close;
      SQL.Clear;
      SQL.Text := ' SELECT AUTOINCREM FROM DESENQ WHERE LOCATE(LEFT(ENQ_DESENQ, 1), "3_4_6") > 0 ';
      Open;

      First;
      while not Eof do
      begin
        Result := Result + FieldByName('AUTOINCREM').AsString + '_';

        Next;
      end;
    end;
  finally
    qryAux.Free;
  end;
end;

function TfrmCadEnquadramentoCat42.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  if (Sender = mskCstEnquadramento) then
  begin
    if (fEmptyStr(mskCstEnquadramento.Text)) and (Pos(qryTabela.FieldByName('ENQ_CODENQ').AsString, fRetEnquadramentosCstObrigatorio) > 0) then
    Begin
      fMensagem('ATENÇÃO!', 'É necessário informar uma ou mais CST para o enquadramento escolhido', ['&OK']);
      pSetFocus(mskCstEnquadramento);
      Result := False;
    End;
  end;

  if not Result then
    pSetFocus(Sender);
end;

{procedure TfrmCadEnquadramentoCat42.pCriarTabelaDescricaoEnquadramento;
  var
    qryAux: TUniQuery;
begin
  if not fTabelaExiste('DESENQ') then
  begin
    qryAux := fCriaQuery(nil);
    try
      with qryAux do
      begin
        Close;
        SQL.Clear;
        SQL.Text := '  CREATE TABLE IF NOT EXISTS DESENQ ( ' +
                    '  AUTOINCREM VARCHAR (20) NOT NULL DEFAULT "", ' +
                    '  ENQ_DESENQ VARCHAR (100) DEFAULT NULL, ' +
                    '  PRIMARY KEY (AUTOINCREM) ' +
                    ') ENGINE = INNODB DEFAULT CHARSET = latin1 ';
        ExecSQL;

        Close;
        SQL.Clear;
        SQL.Text := 'INSERT INTO DESENQ (AUTOINCREM, ENQ_DESENQ) VALUES (:AUTOINCREM, :DESCRICAO); ';
        ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('DESENQ', VS_strCodEmp);;
        ParamByName('DESCRICAO').AsString := '0 - Saída para comercialização subsequente (demais saídas) ';
        ExecSQL;

        Close;
        SQL.Clear;
        SQL.Text := 'INSERT INTO DESENQ (AUTOINCREM, ENQ_DESENQ) VALUES (:AUTOINCREM, :DESCRICAO); ';
        ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('DESENQ', VS_strCodEmp);;
        ParamByName('DESCRICAO').AsString := '1 - Saída a consumidor ou usuário final';
        ExecSQL;

        Close;
        SQL.Clear;
        SQL.Text := 'INSERT INTO DESENQ (AUTOINCREM, ENQ_DESENQ) VALUES (:AUTOINCREM, :DESCRICAO); ';
        ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('DESENQ', VS_strCodEmp);;
        ParamByName('DESCRICAO').AsString := '2 - Fato gerador não realizado';
        ExecSQL;

        Close;
        SQL.Clear;
        SQL.Text := 'INSERT INTO DESENQ (AUTOINCREM, ENQ_DESENQ) VALUES (:AUTOINCREM, :DESCRICAO); ';
        ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('DESENQ', VS_strCodEmp);;
        ParamByName('DESCRICAO').AsString := '3 - Saída ou saída subsequente com isenção ou não incidência';
        ExecSQL;

        Close;
        SQL.Clear;
        SQL.Text := 'INSERT INTO DESENQ (AUTOINCREM, ENQ_DESENQ) VALUES (:AUTOINCREM, :DESCRICAO); ';
        ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('DESENQ', VS_strCodEmp);;
        ParamByName('DESCRICAO').AsString := '4 - Saída para outro estado';
        ExecSQL;

        Close;
        SQL.Clear;
        SQL.Text := 'INSERT INTO DESENQ (AUTOINCREM, ENQ_DESENQ) VALUES (:AUTOINCREM, :DESCRICAO); ';
        ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('DESENQ', VS_strCodEmp);;
        ParamByName('DESCRICAO').AsString := '5 - Devoluções';
        ExecSQL;

        Close;
        SQL.Clear;
        SQL.Text := 'INSERT INTO DESENQ (AUTOINCREM, ENQ_DESENQ) VALUES (:AUTOINCREM, :DESCRICAO); ';
        ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('DESENQ', VS_strCodEmp);;
        ParamByName('DESCRICAO').AsString := '6 - Entradas';
        ExecSQL;
      end;
    finally
      qryAux.Free;
    end;
  end;
end;}

procedure TfrmCadEnquadramentoCat42.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;

  stlCampos.Add('AUTOINCREM');
  stlCampos.Add('ENQ_CODENQ');
  stlCampos.Add('ENQ_CLAFIS');
  stlCampos.Add('ENQ_CODFIS');

  stlCamInd.Add('ENQ_CODENQ');
end;

end.
