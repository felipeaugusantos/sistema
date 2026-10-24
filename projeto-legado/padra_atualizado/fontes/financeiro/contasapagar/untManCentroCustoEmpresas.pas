unit untManCentroCustoEmpresas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids,
  DB, UniClientDataSet, Mask, DBCtrls, Uni, BitBtnLockedIncrem,
  Datasnap.DBClient, frxClass, frxExportCSVTestabilidade, Math;

type
  TfrmManCentroCustoEmpresas = class(TfrmPai)
    dbgrdEmpresas: TDBGridCitel;
    dtsEmpresas: TDataSource;
    cdsEmpresas: TUniClientDataSet;
    cdsEmpresasCODEMP: TStringField;
    cdsEmpresasNOMEMP: TStringField;
    cdsEmpresasPEREMP: TFloatField;
    pnlTotais: TPanel;
    lbl1: TLabel;
    dbeTotPer: TDBEdit;
    cdsEmpresasTOTPER: TAggregateField;
    btnGravar: TBitBtnLocked;
    cdsEmpresasEMPATI: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgrdEmpresasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnGravarClick(Sender: TObject);
    procedure dbgrdEmpresasDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    intCorZeb: Integer;
    procedure pPreencheGrid;
  public
    { Public declarations }
  end;

var
  frmManCentroCustoEmpresas: TfrmManCentroCustoEmpresas;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmManCentroCustoEmpresas.btnGravarClick(Sender: TObject);
begin
  inherited;
  If (Round(cdsEmpresas.FieldByName('TOTPER').Value) <> 100) Then
  Begin
    fMensagem('ATENÇÃO', 'Os percentuais devem somar 100%', ['&Ok']);
    pSetFocus(dbgrdEmpresas);
    dbgrdEmpresas.SelectedIndex := 2;
    Exit;
  End;
  ModalResult := mrOk;
end;

procedure TfrmManCentroCustoEmpresas.dbgrdEmpresasDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  If (Not TDBGridCitel(Sender).DataSource.DataSet.Active) Then
    Exit;

  If (TDBGridCitel(Sender).DataSource.DataSet.RecordCount <= 0) Then
    Exit;

  if Odd(TDBGridCitel(Sender).DataSource.DataSet.RecNo) Then
    TDBGridCitel(Sender).Canvas.Brush.Color := intCorZeb;

  TDBGridCitel(Sender).Canvas.FillRect(Rect);
  TDBGridCitel(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmManCentroCustoEmpresas.dbgrdEmpresasKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_ESCAPE: If cdsEmpresas.State = dsEdit Then
                 cdsEmpresas.Cancel
               Else
                 Close;
    VK_RETURN: Begin
                 If (dbgrdEmpresas.SelectedIndex <> 2) Then
                   dbgrdEmpresas.SelectedIndex := 2;
                 If Not (cdsEmpresas.State = dsEdit) Then
                   cdsEmpresas.Edit
                 Else
                 Begin
                   cdsEmpresas.Post;
                   If (RoundTo(cdsEmpresas.FieldByName('PEREMP').Value, -2) < 0) Then
                   Begin
                     fMensagem('ATENÇÃO', 'O percentual tem que ser maior ou igual a 0.', ['&Ok']);
                     cdsEmpresas.Edit;
                     cdsEmpresas.FieldByName('PEREMP').AsFloat := 0;
                   End
                   Else If (RoundTo(cdsEmpresas.FieldByName('TOTPER').Value, -2) > 100) Then
                   Begin
                     fMensagem('ATENÇÃO', 'Os percentuais não podem ultrapassar 100%', ['&Ok']);
                     cdsEmpresas.Edit;
                     cdsEmpresas.FieldByName('PEREMP').AsFloat := 0;
                   End
                   Else If (cdsEmpresas.FieldByName('EMPATI').AsString <> 'S') Then
                   Begin
                     fMensagem('ATENÇÃO', 'Somente é possivel realizar lançamento para empresas ativas.', ['&Ok']);
                     cdsEmpresas.Edit;
                     cdsEmpresas.FieldByName('PEREMP').AsFloat := 0;
                   End
                   Else
                     cdsEmpresas.Next;
                   If cdsEmpresas.Eof Then
                     pSetFocus(btnGravar);
                 End;
               End;
    VK_DOWN: Begin
               If (dbgrdEmpresas.SelectedIndex <> 2) Then
                 dbgrdEmpresas.SelectedIndex := 2;

               If Not (cdsEmpresas.State = dsEdit) Then
                 cdsEmpresas.Edit
               Else
               Begin
                 cdsEmpresas.Post;
                 If (RoundTo(cdsEmpresas.FieldByName('PEREMP').Value, -2) < 0) Then
                 Begin
                   fMensagem('ATENÇÃO', 'O percentual tem que ser maior ou igual a 0.', ['&Ok']);
                   cdsEmpresas.Edit;
                   cdsEmpresas.FieldByName('PEREMP').AsFloat := 0;
                 End
                 Else If (RoundTo(cdsEmpresas.FieldByName('TOTPER').Value, -2) > 100) Then
                 Begin
                   fMensagem('ATENÇÃO', 'Os percentuais não podem ultrapassar 100%', ['&Ok']);
                   cdsEmpresas.Edit;
                   cdsEmpresas.FieldByName('PEREMP').AsFloat := 0;
                 End
                 Else If (cdsEmpresas.FieldByName('EMPATI').AsString <> 'S') Then
                 Begin
                   fMensagem('ATENÇÃO', 'Somente é possivel realizar lançamento para empresas ativas.', ['&Ok']);
                   cdsEmpresas.Edit;
                   cdsEmpresas.FieldByName('PEREMP').AsFloat := 0;
                 End
                 Else
                   cdsEmpresas.Next;

                 If cdsEmpresas.Eof Then
                   pSetFocus(btnGravar);
               End;

               iF dbgrdEmpresas.DataSource.DataSet.RecNo = dbgrdEmpresas.DataSource.DataSet.RecordCount then
               begin
                 Abort;
                 pSetFocus(btnGravar);
               end;
             End;

    VK_UP:  Begin
              If (dbgrdEmpresas.SelectedIndex <> 2) Then
                dbgrdEmpresas.SelectedIndex := 2;

              If Not (cdsEmpresas.State = dsEdit) Then
                cdsEmpresas.Edit
              Else
              Begin
                cdsEmpresas.Post;
                If (RoundTo(cdsEmpresas.FieldByName('PEREMP').Value, -2) < 0) Then
                Begin
                  fMensagem('ATENÇÃO', 'O percentual tem que ser maior ou igual a 0.', ['&Ok']);
                  cdsEmpresas.Edit;
                  cdsEmpresas.FieldByName('PEREMP').AsFloat := 0;
                End
                Else If (RoundTo(cdsEmpresas.FieldByName('TOTPER').Value, -2) > 100) Then
                Begin
                  fMensagem('ATENÇÃO', 'Os percentuais não podem ultrapassar 100%', ['&Ok']);
                  cdsEmpresas.Edit;
                  cdsEmpresas.FieldByName('PEREMP').AsFloat := 0;
                End
                Else If (cdsEmpresas.FieldByName('EMPATI').AsString <> 'S') Then
                Begin
                  fMensagem('ATENÇÃO', 'Somente é possivel realizar lançamento para empresas ativas.', ['&Ok']);
                  cdsEmpresas.Edit;
                  cdsEmpresas.FieldByName('PEREMP').AsFloat := 0;
                End
                Else
                  cdsEmpresas.Next;

                If cdsEmpresas.Eof Then
                  pSetFocus(btnGravar);
              End;
            End;
    VK_SUBTRACT:
            Begin
              fMensagem('ATENÇÃO', 'O percentual tem que ser maior ou igual a 0.', ['&Ok']);
              cdsEmpresas.Edit;
              cdsEmpresas.FieldByName('PEREMP').AsFloat := 0;
            end;
    VK_OEM_MINUS:
            Begin
              fMensagem('ATENÇÃO', 'O percentual tem que ser maior ou igual a 0.', ['&Ok']);
              cdsEmpresas.Edit;
              cdsEmpresas.FieldByName('PEREMP').AsFloat := 0;
            end;
  End;
end;

procedure TfrmManCentroCustoEmpresas.FormCreate(Sender: TObject);
begin
  inherited;
  cdsEmpresas.CreateDataSet;
  intCorZeb := fCfgSis('CORZEB', varInteger);
end;

procedure TfrmManCentroCustoEmpresas.FormShow(Sender: TObject);
begin
  inherited;
  pPreencheGrid;
  dbgrdEmpresas.SelectedIndex := 2;
  pSetFocus(dbgrdEmpresas);
end;

procedure TfrmManCentroCustoEmpresas.pPreencheGrid;
  Var
    qryEmp: TUniQuery;
begin
  qryEmp := fCriaQuery(Nil);
  try
    Try
      qryEmp.SQL.Add('SELECT        ');
      qryEmp.SQL.Add('  EMP_CODEMP, ');
      qryEmp.SQL.Add('  EMP_NOMEMP, ');
      qryEmp.SQL.Add('  EMP_EMPATI  ');
      qryEmp.SQL.Add('FROM          ');
      qryEmp.SQL.Add('  CADEMP      ');
      qryEmp.SQL.Add('WHERE EMP_EMPATI = "S" ');
      qryEmp.SQL.Add('ORDER BY      ');
      qryEmp.SQL.Add('  EMP_CODEMP  ');
      qryEmp.Open;

      While Not qryEmp.Eof Do
      Begin
        cdsEmpresas.Append;
        cdsEmpresas.FieldByName('CODEMP').AsString := qryEmp.FieldByName('EMP_CODEMP').AsString;
        cdsEmpresas.FieldByName('NOMEMP').AsString := qryEmp.FieldByName('EMP_NOMEMP').AsString;
        cdsEmpresas.FieldByName('EMPATI').AsString := qryEmp.FieldByName('EMP_EMPATI').AsString;
        cdsEmpresas.FieldByName('PEREMP').AsFloat  := 0;
        cdsEmpresas.Post;

        qryEmp.Next;
      End;

      cdsEmpresas.First;
    except on E: Exception do
      begin
        pMensagensErro(E.Message, '[TfrmManCentroCustoEmpresas.pPreencheGrid]');
      end;
    End;
  finally
    FreeAndNilDatasets(qryEmp);
  end;
end;

end.
