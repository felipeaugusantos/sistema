unit untAltValorEntrega;

interface

uses
  Windows, Classes, Controls, Forms, untPai, AppEvnts, Menus, StdCtrls, Buttons,
  ExtCtrls, ComCtrls, EditFocus, Grids, DBGridCitel, DBGrids, DB, Uni, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade;

type
  TfrmAltValorEntrega = class(TfrmPai)
    pnlFundo: TPanel;
    lbl2: TLabel;
    lbl3: TLabel;
    edtCodCid: TEditFocus;
    edtNomCid: TEditFocus;
    edtEstado: TEditFocus;
    dbgGrid: TDBGridCitel;
    btnConfirma: TBitBtnLocked;
    rdgTipVal: TRadioGroup;
    lblValEnt: TLabel;
    edtValEnt: TEditFocus;
    pgbStatus: TProgressBar;
    btnLimparBusca: TBitBtnLocked;
    procedure edtCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rdgTipValClick(Sender: TObject);
    procedure edtValEntEnter(Sender: TObject);
    procedure btnLimparBuscaClick(Sender: TObject);
  private
    { Private declarations }
    qryGrid: TUniQuery;
    dtsGrid: TDataSource;
    procedure pCarregaGrid;
    procedure pLimpaTela;
    procedure pAfterOpen(DataSet: TDataSet);
    procedure pGravaLog(strCodCid : String; fltValAnt, fltValNov : Double);   
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;


implementation

uses SysUtils, untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmAltValorEntrega.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If (fMensagem('','Confirma alteração?',['&Sim', '&Não'], 2) = 1) Then
  Begin
    btnConfirma.Enabled := False;

    Try

      fStartTransaction;    

      With qryGrid Do
      Begin
        DisableControls;
        First;

        If Not IsEmpty Then
        Begin
          pgbStatus.Visible := True;
          pgbStatus.Max     := RecordCount;

          While Not Eof Do
          Begin
            fExecutaSQL(' UPDATE CADCID ' +
                        ' SET    CID_VALENT = ' + fReplaceStr(FieldByName('CID_VALNOV').AsString,',','.') +
                        ' WHERE  CID_CODCID = ' + QuotedStr(Copy(FieldByName('CID_NOMCID').AsString,1,5)));

            pGravaLog(Copy(FieldByName('CID_NOMCID').AsString,1,5),
                      FieldByName('CID_VALENT').AsFloat,
                      FieldByName('CID_VALNOV').AsFloat);

            Next;
            pnlInfo.Caption    := 'Registro: ' + IntToStr(RecNo) + '/' + IntToStr(RecordCount);
            pgbStatus.Position := RecNo;
            Application.ProcessMessages;
          End;

          fMensagem('','Alteração efetuada com sucesso em ' + IntToStr(RecordCount) + ' Cidades!',['&OK']);
        End
        Else
          fMensagem('','Nenhuma cidade foi encontrada com este dados!',['&OK']);

        Close;
        EnableControls;
      End;

      pgbStatus.Visible := False;

      fCommit;

    Except

      On E: Exception Do
      Begin
				pMensagensErro(E.Message, '');
        fRollBack;        
        pgbStatus.Visible := False;
        qryGrid.EnableControls;
        pLimpaTela;
      End;

    End;
    
    btnConfirma.Enabled := True;
  End;
  pnlInfo.Caption := '';
  pLimpaTela;
  SelectFirst;
end;

procedure TfrmAltValorEntrega.btnLimparBuscaClick(Sender: TObject);
begin
  inherited;
  pLimpaTela;
  pSetFocus(edtCodCid);
end;

procedure TfrmAltValorEntrega.edtCodCidKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCidade: TConsultasArray;
begin
  inherited;
  {****************************}
  {* NOVA CONSULTA DE CIDADES *}
  {*************************RV*}
  If fPesqCidade(Self, edtCodCid, edtNomCid, edtEstado, Nil, Key, arrCidade) Then
  Begin
    If fValidaCampos(edtCodCid, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAltValorEntrega.edtValEntEnter(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtValEnt.Text) Then
    edtValEnt.Text := '0,00';
end;

procedure TfrmAltValorEntrega.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryGrid);
  FreeAndNil(dtsGrid);
end;

procedure TfrmAltValorEntrega.FormCreate(Sender: TObject);
begin
  inherited;
  qryGrid            := fCriaQuery;
  dtsGrid            := TDataSource.Create(Self);
  dtsGrid.DataSet    := qryGrid;
  dbgGrid.DataSource := dtsGrid;
  qryGrid.AfterOpen  := pAfterOpen;  
end;

function TfrmAltValorEntrega.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  {************************}
  {* VALIDA CIDADE        *}
  {*********************RV*}
  If (Sender = edtCodCid) Then
  Begin

    If Not fEmptyStr(edtCodCid.Text) Then
    Begin
      edtNomCid.Text := fRetNomCidade(edtCodCid.Text);
      edtEstado.Text := fRetNomCidade(edtCodCid.Text, 1);
      If fEmptyStr(edtNomCid.Text) Then
      Begin
        fMensagem('AVISO', 'Cidade não cadastrada!', ['&O k']);
        Result := False;
      End
      Else
        edtEstado.Enabled := False;
    End
    Else
    Begin
      edtNomCid.Text    := 'TODAS';
      edtEstado.Enabled := True;      
      edtEstado.Clear;
    End;

  End

  {************************}
  {* VALIDA VALOR ENTREGA *}
  {*********************RV*}
  Else If (Sender = edtValEnt) Then
  Begin

    If Not fEmptyStr(edtValEnt.Text) Then
    Begin
      If (fStrToFloat(edtValEnt.Text) < 0) Then
      Begin
        fMensagem('AVISO','Valor da Entrega não pode ser negativo!',['&Ok']);
        Result := False;
      End
      Else
        pCarregaGrid;
    End
    Else
    Begin
      fMensagem('AVISO','Informe o Valor da Entrega!',['&OK']);
      Result := False;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmAltValorEntrega.pAfterOpen(DataSet: TDataSet);
begin
  TFloatField(DataSet.FieldByName('CID_VALENT')).DisplayFormat := '#,#0.00';
  TFloatField(DataSet.FieldByName('CID_VALNOV')).DisplayFormat := '#,#0.00';  
end;

procedure TfrmAltValorEntrega.pCarregaGrid;
  Var
    strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT        ';
    strSQL := strSQL + '  CONCAT(CID_CODCID," - ",CID_NOMCID) AS CID_NOMCID, ';
    strSQL := strSQL + '  IFNULL(CID_VALENT,0)                AS CID_VALENT, ';

    Case rdgTipVal.ItemIndex Of
      0: strSQL := strSQL + ' ' + fReplaceStr(edtValEnt.Text,',','.') + ' AS CID_VALNOV ';
      1: strSQL := strSQL + ' IFNULL(' + fReplaceStr(edtValEnt.Text,',','.') + ' * CID_VALENT, 0) AS CID_VALNOV ';
    End;

    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  CADCID ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  TRUE   ';

    If Not fEmptyStr(edtCodCid.Text) Then
      strSQL := strSQL + '  AND CID_CODCID = :CODCID ';

    If Not fEmptyStr(edtEstado.Text) Then
      strSQL := strSQL + '  AND CID_ESTADO = :ESTADO ';

    strSQL := strSQL + ' ORDER BY CID_NOMCID ';      

    With qryGrid Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If Not fEmptyStr(edtCodCid.Text) Then
        ParamByName('CODCID').AsString := edtCodCid.Text;

      If Not fEmptyStr(edtEstado.Text) Then
        ParamByName('ESTADO').AsString := edtEstado.Text;        

      Open;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
      pgbStatus.Visible := False;
    End;
  End;
end;

procedure TfrmAltValorEntrega.pGravaLog(strCodCid : String; fltValAnt, fltValNov : Double);
  Var
    qryGravaLog: TUniQuery;
    strSQL: String;
begin
  Try

    qryGravaLog := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' INSERT INTO LOGCID ( ';
    strSQL := strSQL + '   AUTOINCREM, ';
    strSQL := strSQL + '   LOG_DTAALT, ';
    strSQL := strSQL + '   LOG_HRAALT, ';
    strSQL := strSQL + '   LOG_CODEMP, ';
    strSQL := strSQL + '   LOG_OPEALT, ';
    strSQL := strSQL + '   LOG_CODCID, ';
    strSQL := strSQL + '   LOG_VALANT, ';
    strSQL := strSQL + '   LOG_VALNOV) ';
    strSQL := strSQL + ' VALUES ( ';
    strSQL := strSQL + '   :AUTOIN, ';
    strSQL := strSQL + '   :DTAALT, ';
    strSQL := strSQL + '   :HRAALT, ';
    strSQL := strSQL + '   :CODEMP, ';
    strSQL := strSQL + '   :OPEALT, ';
    strSQL := strSQL + '   :CODCID, ';
    strSQL := strSQL + '   :VALANT, ';
    strSQL := strSQL + '   :VALNOV) ';

    With qryGravaLog Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('AUTOIN').AsString := fRetAutoIncrem('LOGVEN', VS_strCodEmp);
      ParamByName('DTAALT').AsDate   := VS_Date;
      ParamByName('HRAALT').AsTime   := fTime();
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('OPEALT').AsString := strLoginUsuarioLogado;
      ParamByName('CODCID').AsString := strCodCid;
      ParamByName('VALANT').AsFloat  := fltValAnt;
      ParamByName('VALNOV').AsFloat  := fltValNov;

      ExecSQL;
      Close;

    End;

    FreeAndNil(qryGravaLog);

  Except

    On E : Exception do
    Begin
      FreeAndNil(qryGravaLog);
      pMensagensErro(E.Message, '[Erro ao Gravar o Log]');
    End;

  End;
end;

procedure TfrmAltValorEntrega.pLimpaTela;
begin
  edtCodCid.Clear;
  edtNomCid.Clear;
  edtEstado.Enabled := True;  
  edtEstado.Clear;
  edtValEnt.Clear;
  qryGrid.Close;
end;

procedure TfrmAltValorEntrega.rdgTipValClick(Sender: TObject);
begin
  inherited;
  Case rdgTipVal.ItemIndex Of
    0:lblValEnt.Caption := 'Novo Valor de Entrega:';
    1:lblValEnt.Caption := 'Fator para aplicar no Valor de Entrega:';
  End;
end;

end.
