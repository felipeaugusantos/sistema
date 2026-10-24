unit untImpEtiLocalizacao;

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
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmImpEtiLocalizacao = class(TfrmPai)
    cxgEmpresaLevel1: TcxGridLevel;
    cxgEmpresaTableView: TcxGridDBTableViewCitel;
    cxgEmpresa: TcxGridCitel;
    cxgEmpresaCODEMP: TcxGridDBColumn;
    cxgEmpresaNOMEMP: TcxGridDBColumn;
    cxgEmpresaQTDETI: TcxGridDBColumn;
    btnLazer: TBitBtnLocked;
    btnArgox: TBitBtnLocked;
    Label1: TLabel;
    Panel1: TPanel;
    btnAplicarQtde: TBitBtnLocked;
    edtQtdEti: TEditFocus;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnLazerClick(Sender: TObject);
    procedure btnAplicarQtdeClick(Sender: TObject);
  private
    cdsLocFis : TZClient;
    cdsRegistros : TUniClientDataSet;
    function fGetSQL(arrCodLoc : TConsultasArray) : String;
    function fGeraRegistros(cxProgress : TcxProgressBar):Boolean;
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses TypesRel, untFuncoesSimples, untFuncoesEtiquetas, untCadLocFisSelecao,
  untFuncoesConsulta;

{ TfrmImpEtiLocalizacao }

procedure TfrmImpEtiLocalizacao.btnAplicarQtdeClick(Sender: TObject);
  Var
    arrCodLoc : TConsultasArray;
    strCodLoc : String;
begin
  inherited;
  arrCodLoc := TfrmCadLocFisSelecao.fSelecaoCadLoc(tcAutoincrem);

  If Length(arrCodLoc) > 0 Then
  Begin
    With cdsLocFis.qryQuery, SQL Do
    Begin
      Close;
      Clear;
      Add( fGetSQL(arrCodLoc) );
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('QTDETI').AsInteger:= StrToIntDef(edtQtdEti.Text,1);
      pSetaParam(arrCodLoc[0].strCodigo, arrCodLoc, strCodLoc, 'AUTINC', cdsLocFis.qryQuery);
    End;

    cdsLocFis.fAbreClient(True, 'TfrmImpEtiLocalizacao.FormCreate');
  End
  Else
    cdsLocFis.Close;

end;

procedure TfrmImpEtiLocalizacao.btnLazerClick(Sender: TObject);
  Var
    prmDllEtq: TParamDllEtiquetas;
begin

  if cdsLocFis.State in [dsInactive] then
  Begin
    fMensagem('','Marque a quantidade de etiquetas para imprimir!', ['&Ok']);
    Exit;
  End;

  Try

    cdsLocFis.CheckBrowseMode;
    prmDllEtq := TParamDllEtiquetas.Create;
    cdsRegistros := fCriaClientDatset(cdsLocFis, True, Self);

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
      0 :  prmDllEtq.tpeTipEtq := tpeLocFisLaser;
      1 :  prmDllEtq.tpeTipEtq := tpeLocFisArgox;
    End;

    prmDllEtq.dtsImpres := cdsRegistros;

    fImprimeEtiqueta(prmDllEtq, 'fimprimeetiquetas');

  Finally
    cdsLocFis.EnableControls;
    FreeAndNil(frmGravando);
    FreeAndNil(prmDllEtq);
    FreeAndNil(cdsRegistros);
  End;
  cdsLocFis.fAbreClient(True, 'TfrmImpEtiLocalizacao.btnLazerClick');
end;

function TfrmImpEtiLocalizacao.fGeraRegistros(cxProgress: TcxProgressBar): Boolean;
  Var
    intRegis : Integer;
begin
  Result := True;
  cdsLocFis.DisableControls;

  intRegis := 0;
  cdsLocFis.First;
  While not cdsLocFis.Eof Do
  Begin
    intRegis := intRegis + cdsLocFis.FieldByName('QTDETI').AsInteger;
    cdsLocFis.Next;
  End;

  cxProgress.Properties.Max := intRegis;


  cdsLocFis.First;
  While not cdsLocFis.Eof Do
  Begin
    For intRegis := 1 to cdsLocFis.FieldByName('QTDETI').AsInteger Do
    Begin
      cdsRegistros.Append;
      cdsRegistros.FieldByName('CODLOC').Value := cdsLocFis.FieldByName('CODLOC').Value;
      cdsRegistros.FieldByName('BARLOC').Value := cdsLocFis.FieldByName('BARLOC').Value;
      cdsRegistros.FieldByName('DESCRI').Value := cdsLocFis.FieldByName('DESCRI').Value;
      cdsRegistros.FieldByName('CODAMZ').Value := cdsLocFis.FieldByName('CODAMZ').Value;
      cdsRegistros.FieldByName('DESAMZ').Value := cdsLocFis.FieldByName('DESAMZ').Value;
      cdsRegistros.FieldByName('ALTURA').Value := cdsLocFis.FieldByName('ALTURA').Value;
      cdsRegistros.FieldByName('ITEPIC').Value := cdsLocFis.FieldByName('ITEPIC').Value;
      cdsRegistros.FieldByName('DESITE').Value := cdsLocFis.FieldByName('DESITE').Value;
      cdsRegistros.FieldByName('PICKIN').Value := cdsLocFis.FieldByName('PICKIN').Value;
      cdsRegistros.FieldByName('PROFUN').Value := cdsLocFis.FieldByName('PROFUN').Value;
      cdsRegistros.FieldByName('CAPACI').Value := cdsLocFis.FieldByName('CAPACI').Value;
      cdsRegistros.FieldByName('R_U_A_').Value := cdsLocFis.FieldByName('R_U_A_').Value;
      cdsRegistros.FieldByName('PREDIO').Value := cdsLocFis.FieldByName('PREDIO').Value;
      cdsRegistros.FieldByName('ANDAR_').Value := cdsLocFis.FieldByName('ANDAR_').Value;
      cdsRegistros.FieldByName('APARTA').Value := cdsLocFis.FieldByName('APARTA').Value;
      cdsRegistros.FieldByName('CODLSE').Value := cdsLocFis.FieldByName('CODLSE').Value;
      cdsRegistros.FieldByName('DESLSE').Value := cdsLocFis.FieldByName('DESLSE').Value;
      cdsRegistros.FieldByName('ATIVO_').Value := cdsLocFis.FieldByName('ATIVO_').Value;
      cdsRegistros.FieldByName('PESMAX').Value := cdsLocFis.FieldByName('PESMAX').Value;
      cdsRegistros.FieldByName('QTDETI').Value := cdsLocFis.FieldByName('QTDETI').Value;
      cdsRegistros.FieldByName('REFERE').Value := cdsLocFis.FieldByName('REFERE').Value;
      cdsRegistros.FieldByName('LARGUR').Value := cdsLocFis.FieldByName('LARGUR').Value;
      cdsRegistros.FieldByName('OBSERV').Value := cdsLocFis.FieldByName('OBSERV').Value;
      cdsRegistros.FieldByName('PRODES').Value := cdsLocFis.FieldByName('PRODES').Value;
      cdsRegistros.FieldByName('QTDMAX').Value := cdsLocFis.FieldByName('QTDMAX').Value;
      cdsRegistros.FieldByName('QTDREP').Value := cdsLocFis.FieldByName('QTDREP').Value;
      cdsRegistros.FieldByName('CODITE').Value := cdsLocFis.FieldByName('CODITE').Value;
      cdsRegistros.FieldByName('LOCFIS').Value := cdsLocFis.FieldByName('LOCFIS').Value;

      cdsRegistros.Post;

      cxProgress.Position := cxProgress.Position + 1;
      Application.ProcessMessages;
    End;
    cdsLocFis.Next;
  End;
end;

function TfrmImpEtiLocalizacao.fGetSQL(arrCodLoc : TConsultasArray): String;
begin
  Result := '';
  Result := Result + ' SELECT LOC_CODLOC AS CODLOC,                  ';
  Result := Result + '        LOC_CODLOC AS BARLOC,                  ';
  Result := Result + '        ITEGER.ITE_LOCFIS AS LOCFIS,           ';
  Result := Result + '        LOC_DESCRI AS DESCRI,                  ';
  Result := Result + '        LOC_CODAMZ AS CODAMZ,                  ';
  Result := Result + '        AMZ_DESCRI AS DESAMZ,                  ';
  Result := Result + '        LOC_ALTURA AS ALTURA,                  ';
  Result := Result + '        LOC_ITEPIC AS ITEPIC,                  ';
  Result := Result + '        CADITE.ITE_DESITE AS DESITE,           ';
  Result := Result + '        LOC_PICKIN AS PICKIN,                  ';
  Result := Result + '        LOC_PROFUN AS PROFUN,                  ';
  Result := Result + '        LOC_CAPACI AS CAPACI,                  ';
  Result := Result + '        LOC_R_U_A_ AS R_U_A_,                  ';
  Result := Result + '        LOC_PREDIO AS PREDIO,                  ';
  Result := Result + '        LOC_ANDAR_ AS ANDAR_,                  ';
  Result := Result + '        LOC_APARTA AS APARTA,                  ';
  Result := Result + '        LOC_CODLSE AS CODLSE,                  ';
  Result := Result + '        LSE_DESCRI AS DESLSE,                  ';
  Result := Result + '        LOC_ATIVO_ AS ATIVO_,                  ';
  Result := Result + '        LOC_PESMAX AS PESMAX,                  ';
  Result := Result + '        :QTDETI    AS QTDETI,                  ';
  Result := Result + '        CADITE.ITE_REFERE AS REFERE,           ';
  Result := Result + '        LOC_LARGUR AS LARGUR,                  ';
  Result := Result + '        LOC_OBSERV AS OBSERV,                  ';
  Result := Result + '        (SELECT LCI_QTDMAX FROM LOCITE WHERE LCI_LOCFIS = CADLOC.AUTOINCREM LIMIT 1)  AS QTDMAX, ';
  Result := Result + '        (SELECT LCI_QTDREP FROM LOCITE WHERE LCI_LOCFIS = CADLOC.AUTOINCREM LIMIT 1)  AS QTDREP, ';
  Result := Result + '        (SELECT LCI_CODITE FROM LOCITE WHERE LCI_LOCFIS = CADLOC.AUTOINCREM LIMIT 1)  AS CODITE, ';
  Result := Result + '        (SELECT CI.ITE_DESITE FROM CADITE CI WHERE CI.ITE_CODITE = CODITE LIMIT 1) AS PRODES  ';
  Result := Result + ' FROM CADLOC                                   ';
  Result := Result + '   LEFT JOIN CADAMZ ON AMZ_CODAMZ = LOC_CODAMZ AND AMZ_CODEMP = LOC_CODEMP ';
  Result := Result + '   LEFT JOIN CADITE ON CADITE.ITE_CODITE = LOC_ITEPIC ';
  Result := Result + '   LEFT JOIN CADLSE ON LSE_CODIGO = LOC_CODLSE ';
  Result := Result + '   LEFT JOIN ITEGER ON CADITE.ITE_CODITE = ITEGER.ITE_CODITE AND ITEGER.ITE_CODEMP = "' + VS_strCodEmp + '"';
  Result := Result + ' WHERE LOC_CODEMP = :CODEMP                    ';
  Result := Result + fStrLocate(Nil, arrCodLoc, 'CADLOC.AUTOINCREM', 'AUTINC', False, False, 'X');
  Result := Result + ' ORDER BY LOC_CODLOC                           ';
end;

procedure TfrmImpEtiLocalizacao.FormCreate(Sender: TObject);
begin
  inherited;
  cdsLocFis := TZClient.Create(Self);
  cxgEmpresaTableView.DataController.DataSource := cdsLocFis.dtsSource;
end;

end.














