unit untManutencaoDocas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels, Uni,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxClasses, cxGridLevel, cxGrid, untZClient, cxImageComboBox, System.ImageList,
  Vcl.ImgList, cxDataControllerConditionalFormattingRulesManagerDialog,
  cxImageList;

type
  TfrmManutencaoDocas = class(TfrmPai)
    btnAtualiza: TBitBtnLocked;
    cxgDocasLevel: TcxGridLevel;
    cxgDocasTableView: TcxGridDBTableViewCitel;
    cxgDocas: TcxGridCitel;
    cxgDocasTableViewIDDOCA: TcxGridDBColumn;
    cxgDocasTableViewDESCRI: TcxGridDBColumn;
    cxgDocasTableViewSTATUS: TcxGridDBColumn;
    cxgDocasTableViewPLACA_: TcxGridDBColumn;
    cxgDocasTableViewNOMMOT: TcxGridDBColumn;
    cxgDocasTableViewIDEDIG: TcxGridDBColumn;
    cxgDocasTableViewDTDOCA: TcxGridDBColumn;
    cxgDocasTableViewHRDOCA: TcxGridDBColumn;
    cxgDocasTableViewOPDOCA: TcxGridDBColumn;
    cxImageList: TcxImageList;
    btnEstacionaCaminhao: TBitBtnLocked;
    btnLibDoca: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnAtualizaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnEstacionaCaminhaoClick(Sender: TObject);
    procedure btnLibDocaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    cdsDocas : TZClient;
    function fGetSQL : String;
    procedure pAtualizaDados;
    procedure pAfterScroll(DataSet: TDataSet);
    function fDocaLiberada(strIdDoca : String):Boolean;
  public
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untTypesSistema, untConsultas;

{ TfrmManutencaoDocas }

procedure TfrmManutencaoDocas.btnAtualizaClick(Sender: TObject);
begin
  inherited;
  pAtualizaDados;
end;

procedure TfrmManutencaoDocas.btnEstacionaCaminhaoClick(Sender: TObject);
  Var
    qryAgeRec : TUniQuery;
    qryUpdate : TUniQuery;
    Key       : Char;
    arrSel    : TConsultasArray;
begin
  inherited;
  If not fDocaLiberada( cdsDocas.FieldByName('IDDOCA').AsString ) Then
  Begin
    fMensagem('', 'A Doca Selecionada não está mais Diponível!', ['&Ok']);
    pAtualizaDados;
    Exit;
  End;

  Key := '/';

  Try
    qryAgeRec := fCriaQuery(Self);
    qryUpdate := fCriaQuery(Self);
    With qryUpdate, SQL Do
    Begin
      Close;
      Clear;
      Add(' UPDATE AGEREC SET ARC_IDDOCA = :IDDOCA, ');
      Add('                   ARC_OPDOCA = :OPDOCA, ');
      Add('                   ARC_DTDOCA = :DTDOCA, ');
      Add('                   ARC_HRDOCA = :HRDOCA, ');
      Add('                   ARC_STATUS = "CE"     ');
      Add(' WHERE AUTOINCREM = :AUTINC              ');

      If fPesqAgendamentoEntregaWMS(Self, Nil, qryAgeRec, Key, arrSel, True, QuotedStr('EP')) Then
      Begin
        ParamByName('IDDOCA').AsString   := cdsDocas.FieldByName('IDDOCA').AsString;
        ParamByName('OPDOCA').AsString   := strLoginUsuarioLogado;
        ParamByName('DTDOCA').AsDateTime := fNow;
        ParamByName('HRDOCA').AsDateTime := fNow;
        ParamByName('AUTINC').AsString   := qryAgeRec.FieldByName('AUTOINCREM').AsString;
        ExecSQL;

        Close;
        Clear;
        Add('UPDATE CADOCA SET DOC_STATUS = "O" WHERE DOC_IDDOCA = :IDDOCA AND DOC_CODEMP = :CODEMP ');
        ParamByName('IDDOCA').AsString := cdsDocas.FieldByName('IDDOCA').AsString;
        ParamByName('CODEMP').AsString := VS_strCodEmp;

        ExecSQL;

        pAtualizaDados;
      End;

    End;
  Finally
    FreeAndNil(qryAgeRec);
    FreeAndNil(qryUpdate);
  End;

end;

procedure TfrmManutencaoDocas.btnLibDocaClick(Sender: TObject);
  Var
    qryUpdate : TUniQuery;
begin
  inherited;

  Try
    qryUpdate := fCriaQuery(Self);
    With qryUpdate, SQL Do
    Begin
      Close;
      Clear;
      Add(' UPDATE AGEREC SET ARC_STATUS = "CL"     ');
      Add(' WHERE AUTOINCREM = :AUTINC              ');
      ParamByName('AUTINC').AsString   := cdsDocas.FieldByName('AUTOINCREM').AsString;
      ExecSQL;

      Close;
      Clear;
      Add('UPDATE CADOCA SET DOC_STATUS = "L" WHERE DOC_IDDOCA = :IDDOCA AND DOC_CODEMP = :CODEMP ');
      ParamByName('IDDOCA').AsString := cdsDocas.FieldByName('IDDOCA').AsString;
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      ExecSQL;

      pAtualizaDados;

    End;
  Finally
    FreeAndNil(qryUpdate);
  End;

end;

function TfrmManutencaoDocas.fDocaLiberada(strIdDoca: String): Boolean;
begin
  Result := (fCampoTabela('DOC_STATUS', 'CADOCA', ['DOC_IDDOCA', 'DOC_CODEMP'], [strIdDoca, VS_strCodEmp]) = 'L');
end;

function TfrmManutencaoDocas.fGetSQL: String;
begin
  Result := '';
  Result := Result + ' SELECT DOC_IDDOCA AS IDDOCA,                  ';
  Result := Result + '        DOC_DESCRI AS DESCRI,                  ';
  Result := Result + '        DOC_STATUS AS STATUS,                  ';
  Result := Result + '        ARC_PLACA_ AS PLACA_,                  ';
  Result := Result + '        ARC_NOMMOT AS NOMMOT,                  ';
  Result := Result + '        ARC_IDEDIG AS IDEDIG,                  ';
  Result := Result + '        ARC_DTDOCA AS DTDOCA,                  ';
  Result := Result + '        ARC_HRDOCA AS HRDOCA,                  ';
  Result := Result + '        ARC_OPDOCA AS OPDOCA,                  ';
  Result := Result + '        C.AUTOINCREM                           ';
  Result := Result + ' FROM CADOCA A                                 ';
  Result := Result + '   LEFT JOIN AGEREC C ON ARC_STATUS = "CE"     ';
  Result := Result + '          AND ARC_IDDOCA = A.DOC_IDDOCA        ';
  Result := Result + ' WHERE DOC_CODEMP = ' + QuotedStr(VS_strCodEmp) ;
  Result := Result + ' ORDER BY DOC_DESCRI                           ';
end;

procedure TfrmManutencaoDocas.FormCreate(Sender: TObject);
begin
  inherited;
  cdsDocas := TZClient.Create(Self, fGetSQL);
  cdsDocas.AfterScroll := pAfterScroll;

  pAtualizaDados;
end;

procedure TfrmManutencaoDocas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Shift = [] Then
  Begin
    Case Key Of
      VK_F5 : btnAtualiza.Click;
      VK_F10: If btnEstacionaCaminhao.Visible Then
                btnEstacionaCaminhao.Click
              Else
                btnLibDoca.Click;
    End;
  End;

end;

procedure TfrmManutencaoDocas.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(btnAtualiza);
end;

procedure TfrmManutencaoDocas.pAtualizaDados;
Begin
  cdsDocas.fAbreClient(True, 'TfrmManutencaoDocas.FormCreate', False, True);
  cxgDocasTableView.DataController.DataSource := cdsDocas.dtsSource;
  cxgDocasTableView.ApplyBestFit;
  pSetFocus(cxgDocas);
End;

procedure TfrmManutencaoDocas.pAfterScroll(DataSet : TDataSet);
Begin
  btnLibDoca.Visible := not fEmptyStr(cdsDocas.FieldByName('IDEDIG').AsString);
  btnEstacionaCaminhao.Visible := Not btnLibDoca.Visible;
End;

end.
