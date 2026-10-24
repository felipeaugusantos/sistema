unit untImpEtiRegiao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, cxProgressBar, untGravando,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ExtCtrls, untTypesSistema,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxClasses, cxGridLevel,
  cxGrid, untZClient, UniClientDataSet, EditFocus,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxCheckBox;

type

  TTipoMarca = (tmMarcar, tmDesmarcar, tmInverter);
  
  TfrmImpEtiRegiao = class(TfrmPai)
    cxgRegiaoLevel1: TcxGridLevel;
    cxgRegiaoTableView: TcxGridDBTableViewCitel;
    cxgRegiao: TcxGridCitel;
    cxgRegiaoCODLAR: TcxGridDBColumn;
    cxgRegiaoDESLAR: TcxGridDBColumn;
    cxgRegiaoQTDETI: TcxGridDBColumn;
    Panel1: TPanel;
    btnAplicarQtde: TBitBtnLocked;
    edtQtdEti: TEditFocus;
    Label2: TLabel;
    cxgRegiaoIMPRIMIR: TcxGridDBColumn;
    btnMarcar: TBitBtnLocked;
    btnDesmarcar: TBitBtnLocked;
    btnInverter: TBitBtnLocked;
    btnLazer: TBitBtnLocked;
    btnArgox: TBitBtnLocked;
    Label13: TLabel;
    edtCodReg: TEditFocus;
    edtDesReg: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnLazerClick(Sender: TObject);
    procedure btnAplicarQtdeClick(Sender: TObject);
    procedure edtCodRegKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRegExit(Sender: TObject);
    procedure btnMarcarClick(Sender: TObject);
  private
    cdsRegiao: TZClient;
    cdsRegistros: TUniClientDataSet;
    arrCodReg: TConsultasArray;
    FTipoMarca: TTipoMarca;
    function fGetSQL: String;
    function fGeraRegistros(cxProgress : TcxProgressBar): Boolean;
    function fMarcarProgresso(cxProgress: TcxProgressBar): Boolean;
    function fCdsRegiaoVazio: Boolean;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean; override;
  end;


implementation

{$R *.dfm}

uses TypesRel, untFuncoesSimples, untFuncoesEtiquetas,
  untFuncoesConsulta, untConsultas, untHelperCitel;

{ TfrmImpEtiRegiao }

procedure TfrmImpEtiRegiao.btnAplicarQtdeClick(Sender: TObject);
  Var
    strCodReg : String;
begin
  inherited;

  cdsRegiao.qryQuery.Close;
  cdsRegiao.qryQuery.SQL.Clear;
  cdsRegiao.qryQuery.SQL.Add( fGetSQL );
  cdsRegiao.qryQuery.ParamByName('QTDETI').AsInteger := StrToIntDef(edtQtdEti.Text, 1);
  pSetaParam(edtCodReg.Text, arrCodReg, strCodReg, 'CODREG', cdsRegiao.qryQuery);
  cdsRegiao.fAbreClient(True, 'TfrmImpEtiRegiao.FormCreate');

  pSetFocus(cxgRegiao);
end;

procedure TfrmImpEtiRegiao.btnLazerClick(Sender: TObject);
  Var
    prmDllEtq: TParamDllEtiquetas;
begin
  Try
    cdsRegiao.CheckBrowseMode;
    prmDllEtq := TParamDllEtiquetas.Create;
    cdsRegistros := fCriaClientDatset(cdsRegiao, True, Self);

    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fGeraRegistros;
    frmGravando.lblGravando.Caption := 'Gerando registros...';
    frmGravando.ShowModal;

    If cdsRegistros.IsEmpty Then
    Begin
      fMensagem('','Marque a quantidade de etiquetas para imprimir!', ['&Ok']);
      Exit;
    End;

    Case TBitBtnLocked(Sender).Tag Of
      0 :  prmDllEtq.tpeTipEtq := tpeRegiaoLaser;
      1 :  prmDllEtq.tpeTipEtq := tpeRegiaoArgox;
    End;

    prmDllEtq.dtsImpres := cdsRegistros;

    fImprimeEtiqueta(prmDllEtq, 'fimprimeetiquetas');

  Finally
    cdsRegiao.EnableControls;
    FreeAndNil(frmGravando);
    FreeAndNil(prmDllEtq);
    FreeAndNil(cdsRegistros);
  End;
  cdsRegiao.fAbreClient(True, 'TfrmImpEtiRegiao.btnLazerClick');
end;

procedure TfrmImpEtiRegiao.btnMarcarClick(Sender: TObject);
begin
  inherited;
  
  If fCdsRegiaoVazio Then
  Begin
    fMensagem('', 'Não existe registro para efetuar essa operação!', ['&Ok']);
    Exit;
  End;

  Try
    Case TBitBtnLocked(Sender).Tag Of
      0: FTipoMarca := tmMarcar;
      1: FTipoMarca := tmDesmarcar;
      2: FTipoMarca := tmInverter;
    End;

    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fMarcarProgresso;
    frmGravando.lblGravando.Caption := 'Aguarde...';
    frmGravando.ShowModal;
  Finally
    FreeAndNil(frmGravando);
  End;
end;

procedure TfrmImpEtiRegiao.edtCodRegExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodReg, edtDesReg, arrCodReg, nil, fRetNomRegiao, 'da Região');
end;

procedure TfrmImpEtiRegiao.edtCodRegKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqRegiao(Self, edtCodReg, edtDesReg, nil, key, arrCodReg, False) Then
  Begin
    If fValidaCampos(edtCodReg, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmImpEtiRegiao.fCdsRegiaoVazio: Boolean;
begin
  Result := True;

  If (not cdsRegiao.Active) Then
    Exit;

  If (cdsRegiao.RecordCount = 0) Then
    Exit;

  Result := False;
end;

function TfrmImpEtiRegiao.fGeraRegistros(cxProgress: TcxProgressBar): Boolean;
  Var
    intRegis : Integer;
begin
  Result := True;
  cdsRegiao.DisableControls;

  intRegis := 0;
  cdsRegiao.First;
  While not cdsRegiao.Eof Do
  Begin
    If cdsRegiao.FieldByName('IMPRIMIR').AsString = 'S' Then
      intRegis := intRegis + cdsRegiao.FieldByName('QTDETI').AsInteger;
    cdsRegiao.Next;
  End;

  cxProgress.Properties.Max := intRegis;

  cdsRegiao.First;
  While not cdsRegiao.Eof Do
  Begin
    If cdsRegiao.FieldByName('IMPRIMIR').AsString = 'S' Then
    Begin
      For intRegis := 1 to cdsRegiao.FieldByName('QTDETI').AsInteger Do
      Begin
        cdsRegistros.Append;
        cdsRegistros.FieldByName('CODREG').Value := cdsRegiao.FieldByName('CODREG').Value;
        cdsRegistros.FieldByName('DESREG').Value := cdsRegiao.FieldByName('DESREG').Value;
        cdsRegistros.FieldByName('BARREG').Value := cdsRegiao.FieldByName('BARREG').Value;
        cdsRegistros.FieldByName('QTDETI').Value := cdsRegiao.FieldByName('QTDETI').Value;
        cdsRegistros.Post;

        cxProgress.Position := cxProgress.Position + 1;
        Application.ProcessMessages;
      End;
    End;
    cdsRegiao.Next;
  End;
end;

function TfrmImpEtiRegiao.fGetSQL: String;
begin
  Result := '';
  Result := Result + ' SELECT "N"        AS IMPRIMIR, ';
  Result := Result + '        REG_CODREG AS CODREG,   ';
  Result := Result + '        REG_DESREG AS DESREG,   ';
  Result := Result + '        REG_CODREG AS BARREG,   ';
  Result := Result + '        :QTDETI    AS QTDETI    ';
  Result := Result + '   FROM CADREG                  ';
  Result := Result + '  WHERE (1=1)                   ';
  Result := Result + fStrLocate(edtCodReg, arrCodReg, 'REG_CODREG', 'CODREG');
  Result := Result + '  ORDER BY REG_CODREG           ';
end;

function TfrmImpEtiRegiao.fMarcarProgresso(cxProgress: TcxProgressBar): Boolean;
begin
  Try
    Result := True;
    cdsRegiao.DisableControls;
    cdsRegiao.First;
    cxProgress.Properties.Max := cdsRegiao.RecordCount;

    While Not cdsRegiao.Eof Do
    Begin
      cdsRegiao.Edit;

      Case FTipoMarca Of
        tmMarcar    : cdsRegiao.FieldByName('IMPRIMIR').AsString := 'S';
        tmDesmarcar : cdsRegiao.FieldByName('IMPRIMIR').AsString := 'N';
        tmInverter  : cdsRegiao.FieldByName('IMPRIMIR').AsString := IIF(cdsRegiao.FieldByName('IMPRIMIR').AsString = 'S', 'N', 'S');
      End;

      cdsRegiao.Post;

      cdsRegiao.Next;
      cxProgress.pStep;
    End;

  Finally
    cdsRegiao.First;
    cdsRegiao.EnableControls;
  End;
end;

procedure TfrmImpEtiRegiao.FormCreate(Sender: TObject);
begin
  inherited;
  cdsRegiao := TZClient.Create(Self);
  cxgRegiaoTableView.DataController.DataSource := cdsRegiao.dtsSource;
end;

function TfrmImpEtiRegiao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin
    If (Sender = edtCodReg) Then
    Begin
      pDesmarcaLista(edtCodReg, arrCodReg);
    End
  End;

  If not Result Then
    pSetFocus(Sender);
end;

end.














