unit untCadComissaoEspecie;

interface

uses
  Windows, Classes, Controls, DB, UniDataSetProvider, Uni, AppEvnts, Menus,
  StdCtrls, Mask, Grids, DBGridCitel, DBGrids, ComCtrls, BitBtnLockedIncrem, Buttons, ExtCtrls,
  DBCtrls, DBEditFocus, untPaiOrdenaEdit, DBLookupComboBoxFocus, MemDS,
  DBAccess, UniClientDataSet, Provider, EditFocus, MaskEditFocus,
  DBComboBoxFocus, Datasnap.DBClient, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadComissaoEspecie = class(TfrmPaiOrdenaEdit)
    Label57: TLabel;
    dbeEspDoc: TDBEditFocus;
    Label2: TLabel;
    lblTipCar: TLabel;
    dbeTipCar: TDBComboBoxFocus;
    Label4: TLabel;
    dbeValCom: TDBEditFocus;
    qryCadFpg: TUniQuery;
    cdsConsultaAUTOINCREM: TStringField;
    cdsConsultaCOM_ESPDOC: TStringField;
    cdsConsultaCOM_CODFPG: TStringField;
    cdsConsultaCOM_TIPCAR: TStringField;
    cdsConsultaCOM_VALCOM: TFloatField;
    qryCadFpgFPG_CODIGO: TStringField;
    qryCadFpgFPG_DESCRI: TStringField;
    dtsCadFpg: TDataSource;
    cdsConsultaFPG_DESCRI: TStringField;
    dbeCodFpg: TDBLookupComboBoxFocus;
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbeCodFpgClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure pHabilitaTipCar(blnHabilitar: Boolean);
    Function fExisteForma(strCodFpg, strEspDoc, strTipCar, strAutInc: String): Boolean;
  public
    { Public declarations }
  protected
    function fGetSql(blnLike: Boolean): String;override;
    function fGetOrderBy: String; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

{$R *.dfm}

uses SysUtils, Forms, untFuncoesSimples, untModulo;

function TfrmCadComissaoEspecie.fGetSql(blnLike: Boolean): String;
begin
  Result := '';
  Result := Result + ' SELECT        ';
  Result := Result + '  *            ';
  Result := Result + ' FROM          ';
  Result := Result + '   COMESP      ';
end;

procedure TfrmCadComissaoEspecie.pHabilitaTipCar(blnHabilitar: Boolean);
Begin
  lblTipCar.Enabled := blnHabilitar;
  dbeTipCar.Enabled := blnHabilitar;
  dbeTipCar.TabStop := blnHabilitar;
End;

procedure TfrmCadComissaoEspecie.btnIncluirClick(Sender: TObject);
begin
  inherited;

  pHabilitaTipCar(cdsConsultaCOM_CODFPG.AsString = '007');
  cdsConsultaCOM_VALCOM.AsFloat := 0;
end;

procedure TfrmCadComissaoEspecie.dbeCodFpgClick(Sender: TObject);
begin
  inherited;

  pHabilitaTipCar(cdsConsultaCOM_CODFPG.AsString = '007');

  With cdsConsulta Do
  If (cdsConsultaCOM_CODFPG.AsString <> '007') And
     (State in [dsEdit, dsInsert]) Then
    cdsConsultaCOM_TIPCAR.Clear;
  
end;

Function TfrmCadComissaoEspecie.fExisteForma(strCodFpg, strEspDoc,
  strTipCar, strAutInc: String): Boolean;
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery(Self);
  With qryGen, SQL Do
  Begin
    Clear;
    Add('SELECT * FROM COMESP WHERE');
    Add(' COM_ESPDOC = :ESPDOC AND');
    Add(' COM_CODFPG = :CODFPG AND');
    Add(' IFNULL(COM_TIPCAR, "") = :TIPCAR AND ');
    Add(' AUTOINCREM <> :AUTINC');

    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODFPG').AsString := strCodFpg;
    ParamByName('TIPCAR').AsString := strTipCar;
    ParamByName('AUTINC').AsString := strAutInc;

    Open;

    Result := Not IsEmpty;
  End;

  FreeAndNil(qryGen);
End;

procedure TfrmCadComissaoEspecie.btnAlterarClick(Sender: TObject);
begin
  inherited;

  pHabilitaTipCar(cdsConsultaCOM_CODFPG.AsString = '007');
end;

procedure TfrmCadComissaoEspecie.btnGravarClick(Sender: TObject);
begin
  If fExisteForma(cdsConsultaCOM_CODFPG.AsString,
                  cdsConsultaCOM_ESPDOC.AsString,
                  IIF(cdsConsultaCOM_TIPCAR.IsNull, '', cdsConsultaCOM_TIPCAR.AsString),
                  cdsConsultaAUTOINCREM.AsString) Then
    pMensagemOk('Comissão já cadastrada para essa espécie e forma de pagamento')
  Else
    inherited;

end;

function TfrmCadComissaoEspecie.fGetOrderBy: String;
begin
  Result := '';
  Result := Result + ' ORDER BY      ';
  Result := Result + '   COM_ESPDOC, ';
  Result := Result + '   COM_CODFPG  ';
end;

procedure TfrmCadComissaoEspecie.FormCreate(Sender: TObject);
begin
  inherited;
  strCamChave := 'AUTOINCREM';
end;

procedure TfrmCadComissaoEspecie.FormShow(Sender: TObject);
begin
  strNomTab     := 'COMESP';
  blnTemSelecao := False;
  blnAutoCommit := True;
  blnUsaProxCodVirtual := False;

  With qryCadFpg Do
  Begin
    Connection := frmModulo.GetCurrentConnection;
    sql.Text := 'SELECT FPG_CODIGO, CONCAT(FPG_CODIGO, "-", FPG_DESCRI) AS FPG_DESCRI FROM CADFPG';
    Open;
  End;

  inherited;
end;

function TfrmCadComissaoEspecie.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;

  If inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin
    blnMudarFoco := True;
    
    If (Sender = dbeCodFpg) Then
    Begin

      If fEmptyStr(dbeCodFpg.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe a forma de pagamento!', ['&Ok']);
        Result := False;
      End
    End

    Else If (Sender = dbeEspDoc) Then
    Begin
      If fEmptyStr(dbeEspDoc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe a Espécie do Documento!', ['&Ok']);
        Result := False;
      End
      Else If SameText(dbeEspDoc.Text, 'DV') Then
      Begin
        fMensagem('ATENÇÃO!', 'Espécie não permitida!' + Chr(13)+ 'O % de comissão desses documentos são aplicados automaticamente por seus documentos de origem.', ['&OK']);
        Result := False;
      end;
    End

    Else If (Sender = dbeTipCar) Then
    Begin
      If fEmptyStr(dbeTipCar.Text) And (cdsConsultaCOM_CODFPG.AsString = '007') Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o Tipo de Cartão!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeValCom) Then
    Begin
      If (fStrToFloat(dbeValCom.Text) < 0) Or (fStrToFloat(dbeValCom.Text) > 100) Then
      Begin
        fMensagem('ATENÇÃO!', 'O percentual de comissão deve estar entre zero e 100%!', ['&Ok']);
        Result := False;
      End;
    End

  End;

  If (Not Result) Then
    pSetFocus(Sender)

end;

end.
