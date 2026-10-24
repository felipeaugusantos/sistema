unit untImpEtiEmpresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, cxProgressBar, untGravando,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxClasses, cxGridLevel,
  cxGrid, untZClient, UniClientDataSet,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmImpEtiEmpresa = class(TfrmPai)
    cxgEmpresaLevel1: TcxGridLevel;
    cxgEmpresaTableView: TcxGridDBTableViewCitel;
    cxgEmpresa: TcxGridCitel;
    cxgEmpresaCODEMP: TcxGridDBColumn;
    cxgEmpresaNOMEMP: TcxGridDBColumn;
    cxgEmpresaQTDETI: TcxGridDBColumn;
    btnLazer: TBitBtnLocked;
    btnArgox: TBitBtnLocked;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnLazerClick(Sender: TObject);
  private
    cdsEmpresa : TZClient;
    cdsRegistros : TUniClientDataSet;
    function fGetSQL : String;
    function fGeraRegistros(cxProgress : TcxProgressBar):Boolean;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses TypesRel, untTypesSistema, untFuncoesSimples, untFuncoesEtiquetas;

{ TfrmImpEtiEmpresa }

procedure TfrmImpEtiEmpresa.btnLazerClick(Sender: TObject);
  Var
    prmDllEtq: TParamDllEtiquetas;
begin
  Try
    cdsEmpresa.CheckBrowseMode;
    prmDllEtq := TParamDllEtiquetas.Create;
    cdsRegistros := fCriaClientDatset(cdsEmpresa, True, Self);

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
      0 :  prmDllEtq.tpeTipEtq := tpeEmpresaLazer;
      1 :  prmDllEtq.tpeTipEtq := tpeEmpresaArgox;
    End;

    prmDllEtq.dtsImpres := cdsRegistros;

    fImprimeEtiqueta(prmDllEtq, 'fimprimeetiquetas');

  Finally
    cdsEmpresa.EnableControls;
    FreeAndNil(frmGravando);
    FreeAndNil(prmDllEtq);
    FreeAndNil(cdsRegistros);
  End;
  cdsEmpresa.fAbreClient(True, 'TfrmImpEtiEmpresa.btnLazerClick');
end;

function TfrmImpEtiEmpresa.fGeraRegistros(cxProgress: TcxProgressBar): Boolean;
  Var
    intRegis : Integer;
begin
  Result := True;
  cdsEmpresa.DisableControls;

  intRegis := 0;
  cdsEmpresa.First;
  While not cdsEmpresa.Eof Do
  Begin
    intRegis := intRegis + cdsEmpresa.FieldByName('QTDETI').AsInteger;
    cdsEmpresa.Next;
  End;

  cxProgress.Properties.Max := intRegis;


  cdsEmpresa.First;
  While not cdsEmpresa.Eof Do
  Begin
    For intRegis := 1 to cdsEmpresa.FieldByName('QTDETI').AsInteger Do
    Begin
      cdsRegistros.Append;
      cdsRegistros.FieldByName('CODEMP').Value := cdsEmpresa.FieldByName('CODEMP').Value;
      cdsRegistros.FieldByName('NOMEMP').Value := cdsEmpresa.FieldByName('NOMEMP').Value;
      cdsRegistros.FieldByName('NOMFAN').Value := cdsEmpresa.FieldByName('NOMFAN').Value;
      cdsRegistros.FieldByName('C_G_C_').Value := cdsEmpresa.FieldByName('C_G_C_').Value;
      cdsRegistros.FieldByName('I_E_S_').Value := cdsEmpresa.FieldByName('I_E_S_').Value;
      cdsRegistros.FieldByName('ENDERE').Value := cdsEmpresa.FieldByName('ENDERE').Value;
      cdsRegistros.FieldByName('BAIRRO').Value := cdsEmpresa.FieldByName('BAIRRO').Value;
      cdsRegistros.FieldByName('NOMCID').Value := cdsEmpresa.FieldByName('NOMCID').Value;
      cdsRegistros.FieldByName('ESTADO').Value := cdsEmpresa.FieldByName('ESTADO').Value;
      cdsRegistros.FieldByName('C_E_P_').Value := cdsEmpresa.FieldByName('C_E_P_').Value;
      cdsRegistros.FieldByName('FONE01').Value := cdsEmpresa.FieldByName('FONE01').Value;
      cdsRegistros.FieldByName('EMAIL_').Value := cdsEmpresa.FieldByName('EMAIL_').Value;
      cdsRegistros.FieldByName('HOMEPA').Value := cdsEmpresa.FieldByName('HOMEPA').Value;
      cdsRegistros.Post;

      cxProgress.Position := cxProgress.Position + 1;
      Application.ProcessMessages;
    End;
    cdsEmpresa.Next;
  End;
end;

function TfrmImpEtiEmpresa.fGetSQL: String;
begin
  Result := '';
  Result := Result + ' SELECT EMP_CODEMP AS CODEMP,                                          ';
  Result := Result + '        EMP_NOMEMP AS NOMEMP,                                          ';
  Result := Result + '        EMP_NOMFAN AS NOMFAN,                                          ';
  Result := Result + '        EMP_C_G_C_ AS C_G_C_,                                          ';
  Result := Result + '        EMP_I_E_S_ AS I_E_S_,                                          ';
  Result := Result + '        CONCAT(EMP_ENDERE, IF(IFNULL(EMP_ENDNUM,"") <> "", ", ", "" ), ';
  Result := Result + '        IFNULL(EMP_ENDNUM,""), IF( IFNULL(EMP_ENDCMP,""), " - ", "" ), ';
  Result := Result + '        IFNULL(EMP_ENDCMP,"") ) AS ENDERE,                             ';
  Result := Result + '        EMP_BAIRRO AS BAIRRO,                                          ';
  Result := Result + '        CID_NOMCID AS NOMCID,                                          ';
  Result := Result + '        CID_ESTADO AS ESTADO,                                          ';
  Result := Result + '        EMP_C_E_P_ AS C_E_P_,                                          ';
  Result := Result + '        EMP_FONE01 AS FONE01,                                          ';
  Result := Result + '        EMP_FONE02 AS FONE02,                                          ';
  Result := Result + '        EMP_F_A_X_ AS F_A_X_,                                          ';
  Result := Result + '        EMP_EMAIL_ AS EMAIL_,                                          ';
  Result := Result + '        EMP_HOMEPA AS HOMEPA,                                          ';
  Result := Result + '        0          AS QTDETI                                           ';
  Result := Result + ' FROM CADEMP                                                           ';
  Result := Result + ' INNER JOIN CADCID ON CID_CODCID = EMP_CODCID                          ';
  Result := Result + ' ORDER BY EMP_CODEMP                                                   ';

end;

procedure TfrmImpEtiEmpresa.FormCreate(Sender: TObject);
begin
  inherited;
  cdsEmpresa := TZClient.Create(Self, fGetSQL);
  cdsEmpresa.fAbreClient(True, 'TfrmImpEtiEmpresa.FormCreate');
  cxgEmpresaTableView.DataController.DataSource := cdsEmpresa.dtsSource;

end;

end.














