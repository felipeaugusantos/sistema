unit untManutCustoProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask, MaskEditFocus, DBEditFocus,
  Vcl.DBCtrls, EditFocus, untZClient, DB, Uni, untCalculoPrecoMedio;

type
  TfrmManutCustoProdutos = class(TfrmPaiConfirma)
    pnlTopo: TPanel;
    lblProduto: TLabel;
    dbeDesPro: TDBEditFocus;
    pnlInfProduto: TPanel;
    dbeCodGru: TDBEditFocus;
    lblLinhaGrupo: TLabel;
    dbeDesGru: TDBEditFocus;
    Bevel1: TBevel;
    Label1: TLabel;
    dbeRefere: TDBEditFocus;
    Label2: TLabel;
    dbeDesUni: TDBEditFocus;
    Label3: TLabel;
    dbeCodMar: TDBEditFocus;
    dbeDesMar: TDBEditFocus;
    Label4: TLabel;
    dbeCodFor: TDBEditFocus;
    dbeNomFor: TDBEditFocus;
    Bevel2: TBevel;
    Panel1: TPanel;
    Label9: TLabel;
    Bevel3: TBevel;
    dbeCodEmp: TDBEditFocus;
    dbeNomEmp: TDBEditFocus;
    pnlPreMed: TPanel;
    Bevel4: TBevel;
    Label5: TLabel;
    Label6: TLabel;
    DBEditFocus1: TDBEditFocus;
    Label7: TLabel;
    dbeNewPreMed: TDBEditFocus;
    pnlImpUlt: TPanel;
    Bevel5: TBevel;
    Label8: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    DBEditFocus3: TDBEditFocus;
    dbeNewImpUlt: TDBEditFocus;
    pnlPreUlt: TPanel;
    Bevel6: TBevel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    DBEditFocus5: TDBEditFocus;
    dbeNewPreUlt: TDBEditFocus;
    edtCodPro: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodProKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    cdsDados : TZClient;

    function fGetSql : String;
    function fGetUpdateIteGer : String;
    function fGetInsertLogCus : String;
    function fGravaDados : Boolean;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean):Boolean; Override;
  end;

var
  frmManutCustoProdutos: TfrmManutCustoProdutos;

implementation

{$R *.dfm}

uses  untTConfiguracao, untFuncoesSimples, untConsultas, untTypesSistema;

{ TfrmManutCustoProdutos }

procedure TfrmManutCustoProdutos.edtCodProKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrProduto : TConsultasArray;
begin
  inherited;
  If fPesqItem(conIteSimples, Self, edtCodPro, nil, nil, Key, arrProduto, False, nil, 'Consulta de Itens', '1') Then
  Begin
    If fvalidaCampos(edtCodPro,True) Then
      self.SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmManutCustoProdutos.fGetInsertLogCus: String;
begin
  Result := '';
  Result := Result + '  INSERT INTO LOGCUS ( ';
  Result := Result + '  AUTOINCREM,  ';
  Result := Result + '  LOG_CODITE,  ';
  Result := Result + '  LOG_CODEMP,  ';
  Result := Result + '  LOG_DTAENT,  ';
  Result := Result + '  LOG_HRAENT,  ';
  Result := Result + '  LOG_CODOPE,  ';
  Result := Result + '  LOG_MEDATU,  ';
  Result := Result + '  LOG_MEDNEW,  ';
  Result := Result + '  LOG_ULTATU,  ';
  Result := Result + '  LOG_ULTNEW,  ';
  Result := Result + '  LOG_IMPATU,  ';
  Result := Result + '  LOG_IMPNEW   ';
  Result := Result + '  ) VALUES (   ';
  Result := Result + '   :AUTOIN,    ';
  Result := Result + '   :CODITE,    ';
  Result := Result + '   :CODEMP,    ';
  Result := Result + '   :DTAENT,    ';
  Result := Result + '   :HRAENT,    ';
  Result := Result + '   :CODOPE,    ';
  Result := Result + '   :MEDATU,    ';
  Result := Result + '   :MEDNEW,    ';
  Result := Result + '   :ULTATU,    ';
  Result := Result + '   :ULTNEW,    ';
  Result := Result + '   :IMPATU,    ';
  Result := Result + '   :IMPNEW     ';
  Result := Result + '   )           ';

end;

function TfrmManutCustoProdutos.fGetUpdateIteGer: String;
begin
  Result := '';
  Result := Result + ' UPDATE ITEGER                ';
  Result := Result + '    SET ITE_PREMED = :PREMED, ';
  Result := Result + '        ITE_PREULT = :PREULT, ';
  Result := Result + '        ITE_IMPULT = :IMPULT  ';
  Result := Result + ' WHERE ITE_CODITE = :CODITE   ';
  Result := Result + '   AND ITE_CODEMP = :CODEMP   ';

end;

function TfrmManutCustoProdutos.fGetSql: String;
begin
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE  ';
  Result := Result + '        I.ITE_CODITE, ';
  Result := Result + '        I.ITE_DESITE, ';
  Result := Result + '        I.ITE_CODGRU, ';
  Result := Result + '        R.GRU_DESGRU, ';
  Result := Result + '        I.ITE_REFERE, ';
  Result := Result + '        U.UNI_SIGUNI, ';
  Result := Result + '        I.ITE_CODMAR, ';
  Result := Result + '        M.MAR_DESMAR, ';
  Result := Result + '        I.ITE_CODFOR, ';
  Result := Result + '        F.FOR_NOMFOR, ';
  Result := Result + '        G.ITE_CODEMP, ';
  Result := Result + '        E.EMP_NOMEMP, ';

  If fCfgSis('ENTPIS', varBoolean) Then
    Result := Result + '      ITE_INCPIS, '
  Else
    Result := Result + '      "N" AS ITE_INCPIS, ';

  Result := Result + '        G.ITE_SALDOS, ';

  Result := Result + '        G.ITE_PREMED, ';
  Result := Result + '        G.ITE_PREMED AS NEW_PREMED, ';

  Result := Result + '        G.ITE_PREULT, ';
  Result := Result + '        G.ITE_PREULT AS NEW_PREULT, ';

  Result := Result + '        G.ITE_IMPULT, ';
  Result := Result + '        G.ITE_IMPULT AS NEW_IMPULT  ';

  Result := Result + ' FROM ITEGER G       ';
  Result := Result + ' INNER JOIN CADEMP E ON E.EMP_CODEMP = G.ITE_CODEMP ';
  Result := Result + ' INNER JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE ';
  Result := Result + ' LEFT  JOIN CADGRU R ON R.GRU_CODGRU = I.ITE_CODGRU ';
  Result := Result + ' LEFT  JOIN CADUNI U ON U.UNI_CODUNI = I.ITE_CODUNI ';
  Result := Result + ' LEFT  JOIN CADFOR F ON F.FOR_CODFOR = I.ITE_CODFOR ';
  Result := Result + ' LEFT  JOIN CADMAR M ON M.MAR_CODMAR = I.ITE_CODMAR ';
  Result := Result + ' WHERE G.ITE_CODITE = :CODITE ';
  Result := Result + '   AND G.ITE_CODEMP = :CODEMP ';

end;

function TfrmManutCustoProdutos.fGravaDados: Boolean;
  Var
    qryUpdIns : TUniQuery;
begin
  Try
    Result := True;
    fStartTransaction;
    qryUpdIns := fCriaQuery(Self);

    With qryUpdIns, SQL Do
    Begin
      Try
        cdsDados.CheckBrowseMode;

        Clear;
        Add(fGetUpdateIteGer);

        ParamByName('CODITE').AsString := cdsDados.FieldByName('ITE_CODITE').AsString;
        ParamByName('CODEMP').AsString := cdsDados.FieldByName('ITE_CODEMP').AsString;

        ParamByName('PREMED').AsFloat  := cdsDados.FieldByName('NEW_PREMED').AsFloat;
        ParamByName('PREULT').AsFloat  := cdsDados.FieldByName('NEW_PREULT').AsFloat;
        ParamByName('IMPULT').AsFloat  := cdsDados.FieldByName('NEW_IMPULT').AsFloat;

        ExecSQL;

        If cdsDados.FieldByName('NEW_PREMED').AsFloat <> cdsDados.FieldByName('ITE_PREMED').AsFloat Then
        Begin
          TCalculoPrecoMedio.fGetPreMed(TConfiguracao.fGetConfiguracao).
          Saldo(cdsDados.FieldByName('ITE_SALDOS').AsFloat).
          IncidePIS(cdsDados.FieldByName('ITE_INCPIS').AsString = 'S').
          NovaQuantidade(0).
          PrecoMedio(cdsDados.FieldByName('ITE_PREMED').AsFloat).
          fGravaCalcPreMed('', Self.Name, cdsDados.FieldByName('ITE_CODITE').AsString, cdsDados.FieldByName('NEW_PREMED').AsFloat);
        End;

      Except
        On E : Exception Do
        Begin
          fRollBack;
          Result := False;
          pMensagensErro(e.Message, 'TfrmManutCustoProdutos.fGravaDados_ITEGER');
        End;
      End;

      if Result Then
      Begin
        Try
          Clear;
          Add(fGetInsertLogCus);

          ParamByName('AUTOIN').AsString   := fRetAutoIncrem('LOGCUS', VS_strCodEmp);
          ParamByName('CODITE').AsString   := cdsDados.FieldByName('ITE_CODITE').AsString;
          ParamByName('CODEMP').AsString   := cdsDados.FieldByName('ITE_CODEMP').AsString;
          ParamByName('DTAENT').AsDateTime := VS_Date;
          ParamByName('HRAENT').AsDateTime := fNow();
          ParamByName('CODOPE').AsString   := strLoginUsuarioLogado;

          ParamByName('MEDATU').AsFloat    := cdsDados.FieldByName('ITE_PREMED').AsFloat;
          ParamByName('MEDNEW').AsFloat    := cdsDados.FieldByName('NEW_PREMED').AsFloat;

          ParamByName('ULTATU').AsFloat    := cdsDados.FieldByName('ITE_PREULT').AsFloat;
          ParamByName('ULTNEW').AsFloat    := cdsDados.FieldByName('NEW_PREULT').AsFloat;

          ParamByName('IMPATU').AsFloat    := cdsDados.FieldByName('ITE_IMPULT').AsFloat;
          ParamByName('IMPNEW').AsFloat    := cdsDados.FieldByName('NEW_IMPULT').AsFloat;

          ExecSQL;
        Except
          On E : Exception Do
          Begin
            fRollBack;
            Result := False;
            pMensagensErro(e.Message, 'TfrmManutCustoProdutos.fGravaDados_LOGCUS');
          End;
        End;
      End;

      if Result Then
        fCommit;

    End;

  Finally
    FreeAndNil(qryUpdIns);
  End;

end;

procedure TfrmManutCustoProdutos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If (ModalResult = MrOk) Then
  Begin
    if cdsDados.Active And (cdsDados.RecordCount > 0) Then
    Begin
      If fGravaDados Then
      Begin
        pSetFocus(btnConfirma);
        cdsDados.Close;
        edtCodPro.Clear;
        dbeNewPreMed.Enabled := False;
        dbeNewPreUlt.Enabled := False;
        dbeNewImpUlt.Enabled := False;
        pSetFocus(edtCodPro);
        pMensagemOK('Atualização Realizada com Sucesso!');
      End;
    End
    Else
      pMensagemOk('Selecione um item para Atualizar!');

    Action := caNone;
  End
  Else
  Begin
    If cdsDados.Active And (cdsDados.RecordCount > 0) Then
    Begin
      pSetFocus(btnConfirma);
      cdsDados.Close;
      edtCodPro.Clear;
      dbeNewPreMed.Enabled := False;
      dbeNewPreUlt.Enabled := False;
      dbeNewImpUlt.Enabled := False;
      pSetFocus(edtCodPro);
      Action := caNone;
    End;
  End;

end;

procedure TfrmManutCustoProdutos.FormCreate(Sender: TObject);
  Var
    intIndex : Integer;
begin
  inherited;
  cdsDados := TZClient.Create(Self, fGetSql);

  For intIndex := 0 to Self.ComponentCount -1 Do
  Begin
    If Self.Components[intIndex] is TDBEditFocus Then
      TDBEditFocus(Self.Components[intIndex]).DataSource := cdsDados.fGetSource;
  End;

  cdsDados.fGetSource.AutoEdit := True;

end;

procedure TfrmManutCustoProdutos.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(cdsDados);
end;

procedure TfrmManutCustoProdutos.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodPro);
  pSetaCodIte(edtCodPro);
end;

function TfrmManutCustoProdutos.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);
  if Result then
  Begin
    if (Sender = edtCodPro) And blnBuscaPorChave Then
    Begin
      cdsDados.qryQuery.ParamByName('CODITE').AsString := edtCodPro.Text;
      cdsDados.qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;
      cdsDados.fAbreClient(True, 'TfrmManutCustoProdutos.fValidaCampos');

      pSetaClient(cdsDados);

      TFloatField(cdsDados.FieldByName('ITE_PREMED')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
      TFloatField(cdsDados.FieldByName('NEW_PREMED')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));

      TFloatField(cdsDados.FieldByName('ITE_PREULT')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
      TFloatField(cdsDados.FieldByName('NEW_PREULT')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));

      TFloatField(cdsDados.FieldByName('ITE_IMPULT')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
      TFloatField(cdsDados.FieldByName('NEW_IMPULT')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));

      pnlPreMed.Enabled := (cdsDados.RecordCount > 0);
      pnlPreUlt.Enabled := (cdsDados.RecordCount > 0);
      pnlImpUlt.Enabled := (cdsDados.RecordCount > 0);

      If cdsDados.RecordCount < 1 Then
      Begin
        Result := False;
        pMensagemOK('Produto não Cadastrado!');
      End
      Else
      Begin
        dbeNewPreMed.DataSource.DataSet.Edit;
        dbeNewPreMed.Enabled := True;
        dbeNewPreUlt.Enabled := True;
        dbeNewImpUlt.Enabled := True;
      End;

    End
    Else
    If ( Sender = dbeNewPreUlt ) Or
       ( Sender = dbeNewImpUlt ) Or
       ( Sender = dbeNewPreMed ) Then
    Begin
      Result := (fStrToFloat(TDBEditFocus(Sender).Text) >= 0 );

      if not Result Then
        pMensagemOK('O valor deve ser maior que 0!');
    End;


  End;

  if Not Result Then
    pSetFocus(Sender);

end;

end.
