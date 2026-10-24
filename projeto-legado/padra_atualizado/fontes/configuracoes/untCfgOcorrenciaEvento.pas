unit untCfgOcorrenciaEvento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, System.StrUtils, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, Vcl.StdCtrls, EditFocus, Vcl.ComCtrls, Vcl.ExtCtrls,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  BitBtnLockedIncrem, Uni, UniDataSetProvider, UniClientDataSet, untTypesSistema,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  untFrameCentroCustoEditFocus;

type
  TfrmCfgOcorrenciaEvento = class(TfrmPai)
    btnGravar: TBitBtnLocked;
    dtsOcorrencia: TDataSource;
    BtnOcorrencia: TBitBtnLocked;
    Panel1: TPanel;
    gpbRetorno: TGroupBox;
    Label1: TLabel;
    edtCodOco: TEditFocus;
    btnConfirma: TBitBtnLocked;
    Panel2: TPanel;
    dbgEventos: TcxGrid;
    dbgEventosView: TcxGridDBTableView;
    dbgEventosViewCODOCO: TcxGridDBColumn;
    dbgEventosViewCODEVE: TcxGridDBColumn;
    dbgEventosViewDESEVE: TcxGridDBColumn;
    dbgEventosLevel1: TcxGridLevel;
    Panel3: TPanel;
    Label4: TLabel;
    fraCentroCusto: TfraCentroCustoEditFocus;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure BtnOcorrenciaClick(Sender: TObject);
  private
    { Private declarations }
    qryOcorrencia: TUniQuery;
    cdsOcorrencia: TUniClientDataSet;
    dspOcorrencia: TUniDataSetProvider;

    function fGravaOcorrencia: Boolean;
    procedure pGravouOcorrencia(Var strCmpAlt: String);
    procedure pCarregaEvento;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  public
    { Public declarations }
    strCodBco: String;
  end;

var
  frmCfgOcorrenciaEvento: TfrmCfgOcorrenciaEvento;

implementation

uses untfuncoesSimples, untConsultas, untConstantes, untMemo;

{$R *.dfm}

{ TfrmCfgOcorrenciaEvento }

procedure TfrmCfgOcorrenciaEvento.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If cdsOcorrencia.Locate('CODOCO', edtCodOco.Text, []) Then
  Begin
    fMensagem('','Ocorrência já cadastrada para este banco!', ['&OK']);
    pSetFocus(edtCodOco);
    Exit;
  End;

  cdsOcorrencia.Insert;

  cdsOcorrencia.FieldByName('CODOCO').AsString := edtCodOco.Text;
  cdsOcorrencia.FieldByName('CODEVE').AsString := fraCentroCusto.edtCodEve.Text;
  cdsOcorrencia.FieldByName('DESEVE').AsString := fraCentroCusto.edtDesEve.Text;

  cdsOcorrencia.Post;

  edtCodOco.Clear;
  fraCentroCusto.edtCodEve.Clear;
  fraCentroCusto.edtDesEve.Clear;

  cdsOcorrencia.ApplyUpdates(0);
  Application.ProcessMessages;

  pSetFocus(edtCodOco);
  dspOcorrencia.DataSet := cdsOcorrencia;
end;

procedure TfrmCfgOcorrenciaEvento.btnGravarClick(Sender: TObject);
var
  strRetAlt: String;
begin
  inherited;
  pGravouOcorrencia(strRetAlt);

  If Not fGravaOcorrencia Then
  Begin
    fMensagem('','Não foi possível gravar as ocorrências!', ['&O K']);
    Exit;
  End
  Else
  Begin
    fMensagem('','Dados gravados com sucesso!',['&O K']);
    btnSair.Click;
  End;
end;

procedure TfrmCfgOcorrenciaEvento.BtnOcorrenciaClick(Sender: TObject);
Var
  strDetalhe : String;
  intCont: Integer;
begin
  inherited;
  strDetalhe := '45 - Inclusão';

  For intCont := Low(ARR_OCORRENCIA_SPCBRASIL) to High(ARR_OCORRENCIA_SPCBRASIL) Do
  begin
    strDetalhe := strDetalhe + #13#10 + ARR_OCORRENCIA_SPCBRASIL[intCont][1];
  end;

  strDetalhe := strDetalhe + #13#10 + #13#10 + 'Pressione ESC para voltar à tela de configurações.';

  TfrmMemo.pShowMessage('SPC Brasil - Detalhamento de Ocorrências.' + #13#10 + #13#10 + strDetalhe);
end;

function TfrmCfgOcorrenciaEvento.fGravaOcorrencia: Boolean;
Var
  qryAux: TUniQuery;
begin
  Result := True;

  Try
    fStartTransaction;
    qryAux := fCriaQuery(Nil);

    With qryAux Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' DELETE FROM OCORET WHERE RET_CODBCO = :CODBCO AND RET_CODEMP = :CODEMP ');
      ParamByName('CODBCO').AsString := LeftStr(strCodBco, 3);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ExecSQL;
    End;

    if Not cdsOcorrencia.IsEmpty then
    begin
      cdsOcorrencia.First;

      While Not cdsOcorrencia.Eof Do
      Begin
        With qryAux Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(' INSERT INTO OCORET (RET_CODOCO, RET_CODEVE, RET_CODBCO, RET_CODEMP) ');
          SQL.Add(' VALUES (:CODOCO, :CODEVE, :CODBCO, :CODEMP) ');
          ParamByName('CODOCO').AsString := cdsOcorrencia.FieldByName('CODOCO').AsString;
          ParamByName('CODEVE').AsString := cdsOcorrencia.FieldByName('CODEVE').AsString;
          ParamByName('CODBCO').AsString := LeftStr(strCodBco, 3);
          ParamByName('CODEMP').AsString := VS_strCodEmp;
          ExecSQL;
        End;

        cdsOcorrencia.Next;
      End;
    end;

    fCommit;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'TfrmCfgOcorrenciaEvento.fGravaOcorrencia');
      fRollBack;
      Result := False;
    End;
  End;

  FreeAndNil(qryAux);
end;

procedure TfrmCfgOcorrenciaEvento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryOcorrencia);
  FreeAndNil(cdsOcorrencia);
  FreeAndNil(dspOcorrencia);
end;

procedure TfrmCfgOcorrenciaEvento.FormCreate(Sender: TObject);
begin
  inherited;
  cdsOcorrencia := TUniClientDataSet.Create(Self);
  dspOcorrencia := TUniDataSetProvider.Create(Self);
  cdsOcorrencia.Close;
end;

procedure TfrmCfgOcorrenciaEvento.FormShow(Sender: TObject);
VAR
  strSQL: String;
begin
  pSetFocus(edtCodOco);
  qryOcorrencia := fCriaQuery(Nil);

  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE        ';
  strSQL := strSQL + '   RET_CODOCO AS CODOCO,    ';
  strSQL := strSQL + '   RET_CODEVE AS CODEVE,    ';
  strSQL := strSQL + '   EVE_DESEVE AS DESEVE     ';
  strSQL := strSQL + ' FROM                       ';
  strSQL := strSQL + '   OCORET,                  ';
  strSQL := strSQL + '   CADEVE                   ';
  strSQL := strSQL + ' WHERE                      ';
  strSQL := strSQL + '   EVE_CODEVE = RET_CODEVE  ';
  strSQL := strSQL + '   AND RET_CODBCO = :CODBCO ';
  strSQL := strSQL + '   AND RET_CODEMP = :CODEMP ';


  With qryOcorrencia Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODBCO').AsString := LeftStr(strCodBco, 3);
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;

    pSetaClient(qryOcorrencia);
    First;
  end;

  dspOcorrencia.DataSet := qryOcorrencia;
  cdsOcorrencia.SetProvider(dspOcorrencia);
  cdsOcorrencia.Open;

  dtsOcorrencia.DataSet := cdsOcorrencia;
  dbgEventosView.DataController.DataSource := dtsOcorrencia;
end;

function TfrmCfgOcorrenciaEvento.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
var
  intCont: Integer;
  blnAchouOcorrencia: Boolean;
begin
  Result := True;
  blnAchouOcorrencia := False;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = fraCentroCusto.edtCodEve) Then
    Begin
      If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
      Begin
        pCarregaEvento;

        If fEmptyStr(fraCentroCusto.edtDesEve.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Centro de Custos não está cadastrado!', ['&O K']);
          Result := False;
        End;

        btnConfirma.Enabled := Result;
      End
      Else
      Begin
        fMensagem('', 'O campo Centro de Custos deve ser preenchido!', ['&O K']);
        fraCentroCusto.edtDesEve.Clear;
        Result := False;
      End;
    End

    Else If (Sender = edtCodOco) Then
    Begin
      If fEmptyStr(edtCodOco.Text) Then
      Begin
        fMensagem('', 'O Código da ocorrência deve ser preenchido!', ['&O K']);
        Result := False;
      End
      else
      begin
        for intCont := Low(ARR_OCORRENCIA_SPCBRASIL) To High(ARR_OCORRENCIA_SPCBRASIL) do
        begin
          if (ARR_OCORRENCIA_SPCBRASIL[intCont][0] = edtCodOco.Text) or
             (edtCodOco.Text = '45') Then
          begin
            blnAchouOcorrencia := True;
          end;
        end;

        if Not blnAchouOcorrencia Then
        begin
          fMensagem('', 'O Código da ocorrência é inválido!', ['&O K']);
          Result := False;
        end;
      end;
    End;
  end;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCfgOcorrenciaEvento.pCarregaEvento;
begin
  If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
    fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.edtCodEve)
  Else
    fraCentroCusto.edtDesEve.Clear;
end;

procedure TfrmCfgOcorrenciaEvento.pGravouOcorrencia(var strCmpAlt: String);
Var
  strSQL : String;
  qryAux : TUniQuery;
begin
  qryAux := fCriaQuery;

  if Not cdsOcorrencia.IsEmpty then
  begin
    strSQL := '';
    strSQL := strSQL + ' SELECT RET_CODOCO, ';
    strSQL := strSQL + '        RET_CODEVE, ';
    strSQL := strSQL + '        EVE_DESEVE  ';
    strSQL := strSQL + ' FROM OCORET        ';
    strSQL := strSQL + ' LEFT JOIN CADEVE ON EVE_CODEVE = RET_CODEVE ';
    strSQL := strSQL + ' WHERE RET_CODBCO = :CODBCO ';
    strSQL := strSQL + '   AND RET_CODEMP = :CODEMP ';

    With qryAux Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODBCO').AsString := LeftStr(strCodBco, 3);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
    End;

    cdsOcorrencia.DisableControls;
    strCmpAlt := '';
    cdsOcorrencia.First;

    While Not cdsOcorrencia.Eof Do
    Begin
      If Not qryAux.Locate('RET_CODOCO;RET_CODEVE', VarArrayOf([cdsOcorrencia.FieldByName('CODOCO').AsString,cdsOcorrencia.FieldByName('CODEVE').AsString]), []) Then
      begin
        strCmpAlt := strCmpAlt + 'Ocorrência ' + cdsOcorrencia.FieldByName('CODOCO').AsString + ' - ' +
                     'Centro de Custos ' + cdsOcorrencia.FieldByName('CODEVE').AsString + ' - ' +
                                 cdsOcorrencia.FieldByName('DESEVE').AsString + ' *** ADICIONADO ***' + #13+#10;
      end;

      cdsOcorrencia.Next;
    End;

    qryAux.First;

    While Not qryAux.Eof Do
    Begin
      If Not cdsOcorrencia.Locate('CODOCO;CODEVE', VarArrayOf([qryAux.FieldByName('RET_CODOCO').AsString,qryAux.FieldByName('RET_CODEVE').AsString]), []) Then
      begin
        strCmpAlt := strCmpAlt + 'Ocorrência ' + qryAux.FieldByName('RET_CODOCO').AsString + ' - ' +
                     'Centro de Custos ' + qryAux.FieldByName('RET_CODEVE').AsString + ' - ' +
                                 qryAux.FieldByName('EVE_DESEVE').AsString + ' *** EXCLUIDO ***' + #13+#10;
      end;

      qryAux.Next;
    End;
  end;

  FreeAndNil(qryAux);
end;

end.
